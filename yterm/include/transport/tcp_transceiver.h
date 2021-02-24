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
#include <unordered_map>

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
        static void UVOnTCPConnection(uv_stream_t * stream, int status);
        static void UVOnTCPClose(uv_handle_t * peer);

        /**
         * @brief used by tcp client, return connect status
         *
         * @Param req
         * @Param status
         */
        static void UVOnTCPClientConnection(uv_connect_t * req, int status);
        static void UVOnServerClose(uv_handle_t * peer);
        static void UVOnRead(uv_stream_t * stream, ssize_t n_read, const uv_buf_t * buf);
        static void UVOnWrite(uv_write_t * req, int status);

        class TCPTransceiver;

        /**
         * @brief describe a tcp connection.
         */
        struct TCPConnection {
            // socket fd
            uv_os_fd_t m_fd_; 
            // uv stream object
            uv_stream_t * m_stream_handle_;
            // TCPTransceiver 
            TCPTransceiver * m_transceiver_;
        };

        
        /**
         * @brief tcp traceiver, used to manager tcp connections.
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
                // int Connect(std::string & host, int port);

                //int SetEvtCallbacks();



                /**
                 * @brief get ev loop
                 *
                 * @Returns   
                 */
                uv_loop_t * GetEVLoop() { return m_ev_loop_; }

                /**
                 * @brief add a tcp connection to conn pool
                 *
                 * @Param conn
                 *
                 * @Returns   
                 */
                int AddToPool(TCPConnection * conn);

            private:
                // uv loop, this pointer managed by upper level.
                uv_loop_t * m_ev_loop_ = nullptr;

                // connections 
                std::unordered_map<uv_os_fd_t, TCPConnection *> m_connections_;
            private:
        };

    } // namespace transport
} // namespace yama

#endif // YAMA_TCP_TRANSCEIVER_H_
