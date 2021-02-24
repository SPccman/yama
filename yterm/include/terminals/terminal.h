/**
 * File              : terminal.cc
 * Author            : 42 <chenchao@ztgame.com>
 * Date              : 22.02.2021
 * Last Modified Date: 22.02.2021
 * Last Modified By  : 42 <chenchao@ztgame.com>
 */
#pragma once
#ifndef YAMA_TERMINAL_H_
#define YAMA_TERMINAL_H_

#include <cstddef>

#include "transport/tcp_transceiver.h"

namespace yama {
    namespace terminal {
        /**
         * @brief SFT is a  statefull terminal. It will connect to all SFR or SLR through service
         * discorery. But Only its father SFR or SLR can see it. All request to a sft must be proxied
         * by its father SFR or SLR.
         * todo(42): show detail diagram.
         */

        /**
         * @brief Terminal is a base component in YAMA. It works as transport/service discorery/message proxy, etc.
         * Its duty is to keep a strong channel that connect to other services. It will proxy all the traffic between
         * itself and other services. YAMA system have other roles, they all based on Terminal.
         */
        class Terminal {
            public:
                Terminal();
                ~Terminal();
            
            public:
                int Run();
                int Stop();

            public:
                // callbacks

                // transceiver event callbacks
                // listen cb
                // connect cb
                // disconnect cb
                
                // recv data cb 
                void transceiver_on_read(void *buffer, size_t s);
                // write data cb 

                // service discorery callbacks
                // service list
                // service online
                // service offline


            private:
                // YAMA address, application must give this information.
                std::string m_yama_address_;

                // tcp transceiver, used to send/recv data by socket.
                transport::TCPTransceiver m_tcp_transceiver_ = nullptr;

                
                // MessageDemux, used to demux data that received by transceiver
                
                // Service Discovery, used to discover and route services.
                
                // CustomMessageQ, used to post custom message to application.
        };
    } // namespace terminal
} // namespace yama

#endif
