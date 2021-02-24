/**
 * @file tcp_tranceiver.cc
 * @brief 
 * @author 42(chenchao)
 * @version 0.0.0
 * @date 2021-02-19
 */

#include <memory>
#include <assert.h>

#include "transport/tcp_transceiver.h"
#include "log/Logger.h"
#include "general/yama_errors.h"

namespace yama {
    namespace transport {
        /***************uv callbacks*****************************/
        static void UvOnTCPConnection(uv_stream_t * stream, int status) {
            // listen connection
            TCPConnection * listen_conn  = (TCPConnection *)stream->data;
            assert(listen_conn);

            // create a new client connection
            int ret = EN_YAMA_SUCCESS;
            uv_os_fd_t lfd = -1;
            uv_tcp_t * client = (uv_tcp_t *)malloc(sizeof(uv_tcp_t));
            do {
                // init uv loop
                uv_tcp_init(listen_conn->m_transceiver_->GetEVLoop(), client);

                // accept
                if(uv_accept(stream, (uv_stream_t *)client)) {
                    LOG_ERROR("uv_accept failed err(%s)", uv_err_name(ret));
                    ret = EN_YAMA_ERR_TCP_ACCEPT_FAILED;
                    break;
                }

                if(uv_fileno((uv_handle_t *)client, &lfd)) {
                    LOG_ERROR("uv_fileno failed err(%s)", uv_err_name(ret));
                    ret = EN_YAMA_ERR_TCP_FD_FAILED;
                    break;
                }
            }while(false);

            if(ret != EN_YAMA_SUCCESS) {
                free(client);
                return;
            }

            TCPConnection * client_conn = new TCPConnection();
            client_conn->m_fd_ = lfd;
            client_conn->m_stream_handle_ = (uv_stream_t *)client;
            client_conn->m_transceiver_ = listen_conn->m_transceiver_;

            client_conn->m_transceiver_->AddToPool(client_conn);

        }
        
        static void UvOnTCPClose(uv_handle_t * peer) {
            free(peer);
        }
        



        /***************ChannelTCP*****************************/
        TCPTransceiver::TCPTransceiver(uv_loop_t * ev_loop) {
            m_ev_loop_ = ev_loop;
        }

        int TCPTransceiver::Listen(int port) {
            // create a uv_stream_t for server.
            uv_tcp_t * server = (uv_tcp_t *)malloc(sizeof(uv_tcp_t));

            int ret = EN_YAMA_SUCCESS;
            // fd
            uv_os_fd_t lfd = -1;
            do {
                // init uv loop
                uv_tcp_init(m_ev_loop_, server);

                // uv addr for ipv4
                // todo(42) add support for ipv6
                struct sockaddr_in addr;
                if (0 == uv_ip4_addr("0.0.0.0", port, &addr)) {
                    LOG_DEBUG("create ip4 addr failed");
                    ret = EN_YAMA_ERR_TCP_ADDR_FAILED;
                    break;
                }

                // uv bind
                if(uv_tcp_bind(server, (const struct sockaddr*)&addr, 0)) {
                    LOG_ERROR("uv_tcp_bind failed ret(%s)", uv_err_name(ret));
                    ret = EN_YAMA_ERR_TCP_BIND_FAILED;
                    break;
                }

                if(uv_listen((uv_stream_t *)server, SOMAXCONN, UvOnTCPConnection)) {
                    LOG_ERROR("uv_listen failed err(%s)", uv_err_name(ret));
                    ret = EN_YAMA_ERR_TCP_LISTEN_FAILED;
                    break;
                }

                if(uv_fileno((uv_handle_t *)server, &lfd)) {
                    LOG_ERROR("uv_fileno failed err(%s)", uv_err_name(ret));
                    ret = EN_YAMA_ERR_TCP_FD_FAILED;
                    break;
                }
            } while(false);

            if(ret != EN_YAMA_SUCCESS) {
                uv_close((uv_handle_t *)server, UvOnTCPClose);
                return ret;
            }

            // create a TCPConnection, and push into m_connections_
            TCPConnection * tcp_conn = new TCPConnection();
            tcp_conn->m_fd_ = lfd;
            tcp_conn->m_stream_handle_ = (uv_stream_t *)server;
            tcp_conn->m_transceiver_ = this;
            m_connections_[lfd] = tcp_conn;

            // save tcp_conn to server
            ((uv_stream_t *)server)->data = tcp_conn;

            return 0;
        }

        int TCPTransceiver::AddToPool(TCPConnection *conn) {
            if(!conn) {
                return EN_YAMA_ERR_NIL;
            }

            m_connections_[conn->m_fd_] = conn;
            return EN_YAMA_SUCCESS;
        }

    } // namespace transport
} // namespace yama
