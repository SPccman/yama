cmake_minimum_required(VERSION 3.18)

set(project tcp_traisceiver_test)
set(CMAKE_CXX_STANDARD 17)
project(${project} CXX)


yama_module(${project} EXECUTE)

MESSAGE("${PROJECT_ROOT_DIR}/yterm/include")
target_include_directories(${project} PRIVATE ${PROJECT_ROOT_DIR}/yterm/include)

add_dependencies(
    ${project}
    yterm
)

target_link_libraries(
    ${project}
    yterm
)
