if(NOT _GAMESH_TOOLKIT_SERVICE_)
    set(_GAMESH_TOOLKIT_SERVICE_ ON)

    # gamesh_service(projectName [EXTRA extra_file_type ...] [EXCLUDE exclude_path ...])
    macro(gamesh_service projectName)
        set(_GAMESH_CXX_FILE_TYPE_ *.c *.h *.inl *.cpp *.cc *.cxx *.hpp)
        set(_GAMESH_EXCLUDE_DIR_ .git vendor build bin)

        include(${GAMESH_TOOLKIT_DIR}/cmake/common.cmake)

        filter_source_files(PROJECT_FILES ${ARGN})
        use_source_folders(${PROJECT_FILES})

        add_library(${projectName} SHARED ${PROJECT_FILES})

        use_proj_folders(${projectName})

        if (CMAKE_SYSTEM_NAME MATCHES Windows)
            set_not_exists(GAMESH_DLL_OUTPUT_DIRECTORY_DEBUG                ${CMAKE_SOURCE_DIR}/bin/debug/exe)
            set_not_exists(GAMESH_DLL_OUTPUT_DIRECTORY_RELEASE              ${CMAKE_SOURCE_DIR}/bin/release/exe)
            set_not_exists(GAMESH_DLL_OUTPUT_DIRECTORY_RELWITHDEBINFO       ${CMAKE_SOURCE_DIR}/bin/release/exe)
            set_not_exists(GAMESH_DLL_OUTPUT_DIRECTORY_MINSIZEREL           ${CMAKE_SOURCE_DIR}/bin/release/exe)

            set_target_properties(
                ${projectName}
                PROPERTIES
                LIBRARY_OUTPUT_DIRECTORY_DEBUG ${CMAKE_SOURCE_DIR}/bin/debug/exe
                LIBRARY_OUTPUT_DIRECTORY_RELEASE ${CMAKE_SOURCE_DIR}/bin/release/exe
                LIBRARY_OUTPUT_DIRECTORY_RELWITHDEBINFO ${CMAKE_SOURCE_DIR}/bin/release/exe
                LIBRARY_OUTPUT_DIRECTORY_MINSIZEREL ${CMAKE_SOURCE_DIR}/bin/release/exe
            )
        endif()

        cmake_set_install(${projectName})

        if(${CMAKE_SOURCE_DIR} STREQUAL ${CMAKE_CURRENT_SOURCE_DIR})
            include(${GAMESH_VENDOR_DIRECTORY}/bucket/packages.cmake)
        endif()
    endmacro(gamesh_service)
endif()
