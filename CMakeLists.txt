cmake_minimum_required(VERSION 3.18)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

project(yama)

# add cmake tool file
include(${CMAKE_CURRENT_LIST_DIR}/cmake/yama.cmake)

add_subdirectory(yterm)

