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
#include <thread>
#include <chrono>

#include "transport/tcp_transceiver.h"
#include "log/Logger.h"

// default uv loop
uv_loop_t * server_loop = nullptr;
uv_loop_t * client_loop = nullptr;

std::string host = "127.0.0.1";
int port = 8888;

using TCPTransceiver = yama::transport::TCPTransceiver;

void server()
{
    LOG_INFO("server thread start");
    TCPTransceiver transceiver(server_loop);
    auto ret = transceiver.Listen(port);
    if(ret == 0)
    {
        LOG_INFO("server listen Success");
        uv_run(server_loop, UV_RUN_DEFAULT);
    }
    else
    {
        LOG_ERROR("server listen error (%d)", ret);
    }
}

void client()
{
    TCPTransceiver transceiver(client_loop);
    auto ret = transceiver.Connect(host, port);
    if(ret == 0)
    {
        LOG_INFO("client connect Success");
        uv_run(client_loop, UV_RUN_DEFAULT);
    }
    else
    {
        LOG_INFO("client listen failed (%d)", ret);
    }
}

int main(void)
{
    // setup logger
    cl::Logger::SetDefaultHandler();
    cl::Logger::SetLogLevel(cl::LogLevel::LOG_TRACE);

    // create default event loop
    server_loop = uv_default_loop();
    client_loop = uv_default_loop();
    std::cout << server_loop << ":" << client_loop << std::endl;

    // server thread
    std::thread t_server([](){
            server();
            });

    // sleep for a while
    std::this_thread::sleep_for(std::chrono::milliseconds(1000));

    // client thread
    std::thread t_client([](){
            client();
            });

    t_server.join();
    t_client.join();

    
    return 0;
}
