/**
 * File              : tcp_transceiver_test.cc
 * Author            : 42 <chenchao@ztgame.com>
 * Date              : 24.03.2021
 * Last Modified Date: 24.03.2021
 * Last Modified By  : 42 <chenchao@ztgame.com>
 */

/**
 * test tcp_transceiver module
 */
#include <iostream>

#include "transport/tcp_transceiver.h"

// default uv loop
uv_loop_t * server_loop = nullptr;
uv_loop_t * client_loop = nullptr;

std::string host = "127.0.0.1";
int port = 8888;

void server()
{
    using TCPTransceiver = yama::transport::TCPTransceiver;

    TCPTransceiver transceiver(server_loop);
    transceiver.Listen(port);

    uv_run(server_loop, UV_RUN_DEFAULT);
}

void client()
{

}

int main(void)
{
    server_loop = uv_default_loop();
    client_loop = uv_default_loop();
    std::cout << server_loop << ":" << client_loop << std::endl;

    // server thread

    // client thread
    
    return 0;
}
