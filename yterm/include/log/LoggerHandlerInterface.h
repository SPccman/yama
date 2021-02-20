/**
 * File              : LoggerHandlerInterface.h
 * Author            : 42(chenchao) <chenchao@ztgame.com>
 * Date              : 10.12.2020
 * Last Modified Date: 10.12.2020
 * Last Modified By  : 42(chenchao) <chenchao@ztgame.com>
 */

#pragma once

#ifndef CL_LOGGER_HANDLER_INTERFACE_H_
#define CL_LOGGER_HANDLER_INTERFACE_H_

#include <cstdio>

namespace cl
{
    enum LogLevel
    {
        LOG_NONE  = 0,
        LOG_ERROR = 1,
        LOG_WARN  = 2,
        LOG_INFO =  3,
        LOG_DEBUG = 4,
        LOG_TRACE = 5 
    };

    class LogHandlerInterface
    {
        public:
            virtual void OnLog(LogLevel level, char* payload, size_t len) = 0;
    };

}// namespace cl

#endif //CL_LOGGER_HANDLER_INTERFACE_H_

