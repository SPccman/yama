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

        class TCPTransceiver;

        /**
         * @brief describe address of a connection
         */
        struct ConnAddr {
            std::string m_scheme_;  // address type, ip4/ip6/shm/
            std::string m_addr_;    // complete address, example, ip4://127.0.0.1:8888
            int m_port_;            // port
            std::string m_host;     // host addr, example, 127.0.0.1
        };

        void MakeAddr(ConnAddr &addr, const char * scheme, const char * host,  int port);

        /**
         * @brief describe a tcp connection.
         */
        struct TCPConnection {
            // socket fd
            uv_os_fd_t m_fd_; 
            // addr of this connection
            ConnAddr m_addr_;
            // uv stream object
            uv_stream_t * m_stream_handle_;
            // TCPTransceiver 
            TCPTransceiver * m_transceiver_;
            
            // readbuf 
            // writebuf
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
                int Connect(const std::string & host, int port);

                /**
                 * @brief send message
                 *
                 * @Param conn
                 * @Param buf
                 * @Param len
                 *
                 * @Returns   
                 */
                int Send(const TCPConnection *conn, char *buf, uint32_t len);


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
