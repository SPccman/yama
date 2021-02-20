/**
 * @file tcp_tranceiver.cc
 * @brief 
 * @author 42(chenchao)
 * @version 0.0.0
 * @date 2021-02-19
 */

#include "transport/tcp_transceiver.h"
#include "log/Logger.h"

namespace yama {
    namespace transport {
        /***************uv callbacks*****************************/
        static void UvOnTCPConnection(uv_stream_t * stream, int status) {

        }


        /***************ChannelTCP*****************************/
        TCPTransceiver::TCPTransceiver(uv_loop_t * ev_loop) {
            m_ev_loop_ = ev_loop;
        }

        int TCPTransceiver::Listen(int port) {
            // init uv loop
            int ret = uv_tcp_init(m_ev_loop_, &m_server_);
            if(ret) {
                LOG_ERROR("uv_tcp_init failed err(%s)", uv_err_name(ret));
                return -1;
            }

            // uv addr for ipv4
            // todo(42) add support for ipv6
            struct sockaddr_in addr;
            ret = uv_ip4_addr("0.0.0.0", port, &addr);
            if (ret == 0) {
                LOG_DEBUG("create ip4 addr failed");
                return -1;
            }

            // uv bind
            ret = uv_tcp_bind(&m_server_, (const struct sockaddr*)&addr, 0);
            if(ret) {
                LOG_ERROR("uv_tcp_bind failed ret(%s)", uv_err_name(ret));
                return -1;
            }
            
            ret = uv_listen((uv_stream_t *)&m_server_, SOMAXCONN, UvOnTCPConnection);
            if(ret) {
                LOG_ERROR("uv_listen failed err(%s)", uv_err_name(ret));
                return -1;
            }
        
            return 0;
        }

    } // namespace transport
} // namespace yama
