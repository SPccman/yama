if(NOT YAMA_TOOLKIT_VARIABLES)
    set(YAMA_TOOLKIT_VARIABLES ON)
    set_not_exists(YAMA_TOOLKIT_VARIABLES ON)

    if(CMAKE_SYSTEM_NAME MATCHES Linux)
        set(CMAKE_SYSTEM_NAME_LOWER linux)

        set(DEFAULT_BUILD_TYPE Debug)
        if(CMAKE_BUILD_TYPE STREQUAL "")
            set(CMAKE_BUILD_TYPE ${DEFAULT_BUILD_TYPE} CACHE STRING "Choose the type of build.[Debug|Release|RelWithDebInfo|MinSizeRel]" FORCE)
        endif()
        string(TOLOWER ${CMAKE_BUILD_TYPE} CMAKE_BUILD_TYPE_LOWER)

        string(APPEND CMAKE_CXX_FLAGS " -fPIC")

        set(PLAT_LIBS dl pthread)
    elseif(CMAKE_SYSTEM_NAME MATCHES Windows)
        set(CMAKE_SYSTEM_NAME_LOWER win)

        string(APPEND CMAKE_CXX_FLAGS " /MP -wd4251 -wd4275 -wd4819 -DWIN32_LEAN_AND_MEAN -D_WIN32=0x0601 -D_CRT_SECURE_NO_WARNINGS")
        string(APPEND CMAKE_CXX_FLAGS_DEBUG " /MDd")
        string(APPEND CMAKE_CXX_FLAGS_RELEASE " /MD")
        string(APPEND CMAKE_CXX_FLAGS_MINSIZEREL " /MD")
        string(APPEND CMAKE_CXX_FLAGS_RELWITHDEBINFO " /MD")
    else()
        message(FATAL_ERROR "Unsupported operating system. ${CMAKE_SYSTEM_NAME}")
    endif()

    set_not_exists(YAMA_TEST_WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)

    set_not_exists(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG             ${CMAKE_SOURCE_DIR}/bin/debug/exe)
    set_not_exists(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE           ${CMAKE_SOURCE_DIR}/bin/release/exe)
    set_not_exists(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELWITHDEBINFO    ${CMAKE_SOURCE_DIR}/bin/release/exe)
    set_not_exists(CMAKE_RUNTIME_OUTPUT_DIRECTORY_MINSIZEREL        ${CMAKE_SOURCE_DIR}/bin/release/exe)
    set_not_exists(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG             ${CMAKE_SOURCE_DIR}/bin/debug/dll)
    set_not_exists(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE           ${CMAKE_SOURCE_DIR}/bin/release/dll)
    set_not_exists(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELWITHDEBINFO    ${CMAKE_SOURCE_DIR}/bin/release/dll)
    set_not_exists(CMAKE_LIBRARY_OUTPUT_DIRECTORY_MINSIZEREL        ${CMAKE_SOURCE_DIR}/bin/release/dll)
    set_not_exists(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG             ${CMAKE_SOURCE_DIR}/bin/debug/lib)
    set_not_exists(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE           ${CMAKE_SOURCE_DIR}/bin/release/lib)
    set_not_exists(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELWITHDEBINFO    ${CMAKE_SOURCE_DIR}/bin/release/lib)
    set_not_exists(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_MINSIZEREL        ${CMAKE_SOURCE_DIR}/bin/release/lib)
    set_not_exists(CMAKE_BUILD_RPATH                                "$ORIGIN/../dll")

    set_not_exists(YAMA_INSTALL_PREFIX                            ${CMAKE_SOURCE_DIR}/publish)
    set_not_exists(YAMA_INSTALL_RPATH                             "$ORIGIN/yama_lib;$ORIGIN/lib;$ORIGIN/std_lib;$ORIGIN/../yama_lib;$ORIGIN/../lib;$ORIGIN/../std_lib")

    if (CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
        set(CMAKE_INSTALL_PREFIX                                    ${YAMA_INSTALL_PREFIX} CACHE PATH "..." FORCE)
        set(CMAKE_INSTALL_RPATH                                     ${YAMA_INSTALL_RPATH} CACHE PATH "..." FORCE)
    endif ()

    # todo(42): from atsf4g-co, tidy them later
    # installer directory
    include(GNUInstallDirs)
    if (NOT PROJECT_INSTALL_BAS_DIR)
        # set (PROJECT_INSTALL_BAS_DIR "${PROJECT_BINARY_DIR}/${PROJECT_BUILD_NAME}")
        set (PROJECT_INSTALL_BAS_DIR "${CMAKE_SOURCE_DIR}/bin")
    endif ()
    if(NOT EXISTS ${PROJECT_INSTALL_BAS_DIR})
        file(MAKE_DIRECTORY ${PROJECT_INSTALL_BAS_DIR})
        message(STATUS "create ${PROJECT_INSTALL_BAS_DIR} for build target.")
    endif()



    set (CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${PROJECT_INSTALL_BAS_DIR}/${CMAKE_INSTALL_LIBDIR}/${PROJECT_VCS_COMMIT_SHORT_SHA}")
    set (CMAKE_LIBRARY_OUTPUT_DIRECTORY "${PROJECT_INSTALL_BAS_DIR}/${CMAKE_INSTALL_LIBDIR}/${PROJECT_VCS_COMMIT_SHORT_SHA}")
    set (CMAKE_RUNTIME_OUTPUT_DIRECTORY "${PROJECT_INSTALL_BAS_DIR}/${CMAKE_INSTALL_BINDIR}")

    set (PROJECT_INSTALL_RES_DIR "${PROJECT_INSTALL_BAS_DIR}/resource")
    set (PROJECT_INSTALL_TOOLS_DIR  "${PROJECT_INSTALL_BAS_DIR}/tools")
    set (PROJECT_INSTALL_SHARED_DIR "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}")
    set (PROJECT_INSTALL_RES_PBD_DIR "${PROJECT_INSTALL_RES_DIR}/pbdesc")
    file(MAKE_DIRECTORY "${PROJECT_INSTALL_TOOLS_DIR}/bin")
    file(MAKE_DIRECTORY ${PROJECT_INSTALL_SHARED_DIR})
    file(MAKE_DIRECTORY ${PROJECT_INSTALL_RES_PBD_DIR})
    link_directories(${CMAKE_ARCHIVE_OUTPUT_DIRECTORY})
endif()
