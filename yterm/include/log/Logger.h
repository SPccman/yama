/**
 * File              : Logger.h
 * Author            : 42(chenchao) <chenchao@ztgame.com>
 * Date              : 09.12.2020
 * Last Modified Date: 10.12.2020
 * Last Modified By  : 42(chenchao) <chenchao@ztgame.com>
 */
/**
 * Logger facility.
 *
 * This include file defines logging macros for source files (.cpp). Each
 * source file including Logger.hpp MUST define its own CL_CLASS macro. Include
 * files (.hpp) MUST NOT include Logger.hpp.
 *
 * All the logging macros use the same format as printf().
 *
 * If the macro CL_LOG_FILE_LINE is defied, all the logging macros print more
 * verbose information, including current file and line.
 *
 * LOG_TRACE()
 *
 *   Logs the current method/function if CL_LOG_TRACE macro is defined and
 *   logLevel is 'debug'.
 *
 * LOG_DEBUG(...)
 *
 * 	 Logs a debug.
 *
 * LOG_WARN(...)
 *
 *   Logs a warning.
 *
 * LOG_ERROR(...)
 *
 *   Logs an error.
 *
 * LOG_DUMP(...)
 *
 * 	 Logs always to stdout.
 *
 * LOG_ABORT(...)
 *
 *   Logs the given error to stderr and aborts the process.
 *
 * LOG_ASSERT(condition, ...)
 *
 *   If the condition is not satisfied, it calls CL_ABORT().
 */

#ifndef CL_LOGGER_HPP
#define CL_LOGGER_HPP

#include <cstdio>  // std::snprintf(), std::fprintf(), stdout, stderr
#include <cstdlib> // std::abort()
#include <cstring>
#include <stdint.h>

#include "LoggerHandlerInterface.h"

namespace cl
{
	class Logger
	{
	public:
        class DefaultLogHandler : public LogHandlerInterface
        {
            void OnLog(LogLevel level, char* payload, size_t len) override;
        };


		static void SetLogLevel(LogLevel level);
		static void SetHandler(LogHandlerInterface* handler);
		static void SetDefaultHandler();

	public:
		static LogLevel logLevel;
		static LogHandlerInterface* handler;
		static const size_t bufferSize{ 50000 };
		static char buffer[];
	};
} // namespace cl 

// clang-format off

/* Logging macros. */

//using Logger = cl::Logger;

#define _CL_LOG_SEPARATOR_CHAR "\n"

#ifdef CL_LOG_FILE_LINE
	#define _CL_LOG_STR " %s:%d | %s::%s()"
	#define _CL_LOG_STR_DESC _CL_LOG_STR " | "
	#define _CL_FILE (std::strchr(__FILE__, '/') ? std::strchr(__FILE__, '/') + 1 : __FILE__)
	#define _CL_LOG_ARG _CL_FILE, __LINE__, CL_CLASS, __FUNCTION__
#else
	#define _CL_LOG_STR " %s::%s()"
	#define _CL_LOG_STR_DESC _CL_LOG_STR " | "
    //TODO: remove this
	//#define _CL_LOG_ARG CL_CLASS, __FUNCTION__
	#define _CL_LOG_ARG "", __FUNCTION__
#endif

#ifdef CL_LOG_TRACE
	#define LOG_TRACE() \
		do \
		{ \
			if (cl::Logger::handler && cl::Logger::logLevel >= cl::LogLevel::LOG_TRACE) \
			{ \
				int loggerWritten = std::snprintf(cl::Logger::buffer, cl::Logger::bufferSize, "[TRACE]" _CL_LOG_STR, _CL_LOG_ARG); \
				cl::Logger::handler->OnLog(cl::LogLevel::LOG_TRACE, cl::Logger::buffer, loggerWritten); \
			} \
		} \
		while (false)
#else
	#define LOG_TRACE() ;
#endif

#define LOG_DEBUG(desc, ...) \
	do \
	{ \
		if (cl::Logger::handler && cl::Logger::logLevel >= cl::LogLevel::LOG_DEBUG) \
		{ \
			int loggerWritten = std::snprintf(cl::Logger::buffer, cl::Logger::bufferSize, "[DEBUG]" _CL_LOG_STR_DESC desc, _CL_LOG_ARG, ##__VA_ARGS__); \
			cl::Logger::handler->OnLog(cl::LogLevel::LOG_DEBUG, cl::Logger::buffer, loggerWritten); \
		} \
	} \
	while (false)

#define LOG_INFO(desc, ...) \
	do \
	{ \
		if (cl::Logger::handler && cl::Logger::logLevel >= cl::LogLevel::LOG_INFO) \
		{ \
			int loggerWritten = std::snprintf(cl::Logger::buffer, cl::Logger::bufferSize, "[INFO]" _CL_LOG_STR_DESC desc, _CL_LOG_ARG, ##__VA_ARGS__); \
			cl::Logger::handler->OnLog(cl::LogLevel::LOG_INFO, cl::Logger::buffer, loggerWritten); \
		} \
	} \
	while (false)

#define LOG_WARN(desc, ...) \
	do \
	{ \
		if (cl::Logger::handler && cl::Logger::logLevel >= cl::LogLevel::LOG_WARN) \
		{ \
			int loggerWritten = std::snprintf(cl::Logger::buffer, cl::Logger::bufferSize, "[WARN]" _CL_LOG_STR_DESC desc, _CL_LOG_ARG, ##__VA_ARGS__); \
			cl::Logger::handler->OnLog(cl::LogLevel::LOG_WARN, cl::Logger::buffer, loggerWritten); \
		} \
	} \
	while (false)

#define LOG_ERROR(desc, ...) \
	do \
	{ \
		if (cl::Logger::handler && cl::Logger::logLevel >= cl::LogLevel::LOG_ERROR) \
		{ \
			int loggerWritten = std::snprintf(cl::Logger::buffer, cl::Logger::bufferSize, "[ERROR]" _CL_LOG_STR_DESC desc, _CL_LOG_ARG, ##__VA_ARGS__); \
			cl::Logger::handler->OnLog(cl::LogLevel::LOG_ERROR, cl::Logger::buffer, loggerWritten); \
		} \
	} \
	while (false)

#define LOG_DUMP(desc, ...) \
	do \
	{ \
		std::fprintf(stdout, _CL_LOG_STR_DESC desc _CL_LOG_SEPARATOR_CHAR, _CL_LOG_ARG, ##__VA_ARGS__); \
		std::fflush(stdout); \
	} \
	while (false)

#define LOG_ABORT(desc, ...) \
	do \
	{ \
		std::fprintf(stderr, "[ABORT]" _CL_LOG_STR_DESC desc _CL_LOG_SEPARATOR_CHAR, _CL_LOG_ARG, ##__VA_ARGS__); \
		std::fflush(stderr); \
		std::abort(); \
	} \
	while (false)

#define LOG_ASSERT(condition, desc, ...) \
	if (!(condition)) \
	{ \
		LOG_ABORT("failed assertion `%s': " desc, #condition, ##__VA_ARGS__); \
	}

// clang-format on

#endif
