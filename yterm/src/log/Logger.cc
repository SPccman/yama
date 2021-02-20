/**
 * File              : Logger.cc
 * Author            : 42(chenchao) <chenchao@ztgame.com>
 * Date              : 09.12.2020
 * Last Modified Date: 10.12.2020
 * Last Modified By  : 42(chenchao) <chenchao@ztgame.com>
 */
#define RTV_CLASS "Logger"

#include "log/Logger.h"
#include <iostream>

namespace cl 
{
	/* Class variables. */

    LogHandlerInterface* Logger::handler{ nullptr };
	char Logger::buffer[Logger::bufferSize];
	LogLevel Logger::logLevel = LogLevel::LOG_NONE;

	/* Class methods. */

	void Logger::SetLogLevel(LogLevel level)
	{
		Logger::logLevel = level;
	}

	void Logger::SetHandler(LogHandlerInterface* handler)
	{
		Logger::handler = handler;
	}

	void Logger::SetDefaultHandler()
	{
		Logger::handler = new Logger::DefaultLogHandler();
	}

	/* DefaultLogHandler */

	void Logger::DefaultLogHandler::OnLog(LogLevel /*level*/, char* payload, size_t /*len*/)
	{
		std::cout << payload << std::endl;
	}
} // namespace cl
