cmake_minimum_required(VERSION 3.18)

set(projectName yterm)
set(CMAKE_CXX_STANDARD 17)
project(${projectName} CXX)

# todo(42)
# find libuv
# find jemalloc

yama_module(${projectName} STATIC)

target_include_directories(${projectName} PUBLIC "$<BUILD_INTERFACE:${3RD_PARTY_PUBLIC_INCLUDE_DIRS}>"
                                                 "$<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/include>")

# include
# target_include_directories(${projectName} PRIVATE ${THIRD_PARTY_ROOT_PATH}/libuv/include)
# target_include_directories(${projectName} PRIVATE ${THIRD_PARTY_ROOT_PATH}/jemalloc/include)

# libs
# target_link_directories(${projectName} PRIVATE ${THIRD_PARTY_ROOT_PATH}/libuv/.libs)
# target_link_directories(${projectName} PRIVATE ${THIRD_PARTY_ROOT_PATH}/jemalloc/lib)

target_link_libraries(${projectName} uv jemalloc)
