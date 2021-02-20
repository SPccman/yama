/**
 * @file tcp_transceiver.h
 * @brief 
 * @author 42(chenchao)
 * @version 
 * @date 2021-02-19
 */

#pragma once

#ifndef YAMA_TCP_TRANSCEIVER_H_
#define YAMA_TCP_TRANSCEIVER_H_

#include <string>

// libuv
#include "uv.h"

namespace yama {
    namespace transport {
        // uv callbacks
        /**
         * @brief  used by tcp server, accept a client connection
         *
         * @Param stream
         * @Param status
         */
        static void UvOnTCPConnection(uv_stream_t * stream, int status);
        static void UvOnTCPclose(uv_handle_t * peer);
        static void UvOnServerClose(uv_handle_t * peer);
        static void UvOnRead(uv_stream_t * stream, ssize_t n_read, const uv_buf_t * buf);
        static void UvOnWrite(uv_write_t * req, int status);

        
        /**
         * @brief tcp traceiver
         */
        class TCPTransceiver {
            public:
                TCPTransceiver(uv_loop_t * ev_loop);
                ~TCPTransceiver(){};

                /**
                 * @brief listen a tcp port
                 *
                 * @Param port
                 *
                 * @Returns   
                 */
                int Listen(int port);

                /**
                 * @brief  connect to peer
                 *
                 * @Param host
                 * @Param port
                 *
                 * @Returns   
                 */
                int Connect(std::string & host, int port);


            private:
                // uv loop
                uv_loop_t *m_ev_loop_ = nullptr;
            private:
                // for server
                uv_tcp_t m_server_;
                // connect pool (for server)
        };

    } // namespace transport
} // namespace yama

#endif // YAMA_TCP_TRANSCEIVER_H_
