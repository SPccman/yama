if(NOT YAMA_CMAKE_COMMON)
    set(YAMA_CMAKE_COMMON ON)

    option(ENABLE_COVERAGE "Generates the coverage build" OFF)
    option(ENABLE_TEST "Build test cases" OFF)
    option(ENABLE_BENCHMARK "Build benchmark" OFF)

    include(${YAMA_CMAKE_DIR}/variables.cmake)

    if(DEFINED YAMA_INCLUDE_DIRECTORIES)
        include_directories(${YAMA_INCLUDE_DIRECTORIES})
    endif()

    if(DEFINED YAMA_LINK_DIRECTORIES)
        link_directories(${YAMA_LINK_DIRECTORIES})
    endif()

    if(ENABLE_TEST)
        enable_testing()
    endif()

    if(ENABLE_COVERAGE)
        setup_coverage()
    endif()
endif()
