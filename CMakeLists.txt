cmake_minimum_required(VERSION 3.18)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(PROJECT_ROOT_DIR ${CMAKE_CURRENT_SOURCE_DIR})

project(yama)


# root dir of cmake utils
set(PROJECT_CMAKE_UTIL_DIR "${CMAKE_CURRENT_LIST_DIR}/cmake")

# add cmake tool file
include(${PROJECT_CMAKE_UTIL_DIR}/yama.cmake)

# prepare 3rd_party
include (${CMAKE_SOURCE_DIR}/3rd_party/3rd_party.prepare.cmake)

# use for find_package
list(APPEND CMAKE_MODULE_PATH "${PROJECT_CMAKE_UTIL_DIR}/modules")

# output with color
include (${PROJECT_CMAKE_UTIL_DIR}/modules/EchoWithColor.cmake)
# use for getting 3rd libs(source code)
include (${PROJECT_CMAKE_UTIL_DIR}/find_configure_package.cmake)
include (${PROJECT_CMAKE_UTIL_DIR}/project_build_option.cmake)
include (${PROJECT_CMAKE_UTIL_DIR}/find_platform.cmake)

# compiler option
include (${PROJECT_CMAKE_UTIL_DIR}/compiler_option.cmake)
include (${PROJECT_CMAKE_UTIL_DIR}/project_tools.cmake)

# get and build 3rd libs
include (${CMAKE_SOURCE_DIR}/3rd_party/3rd_party.macro.cmake)


# build yama
add_subdirectory(yterm)
add_subdirectory(tests)

