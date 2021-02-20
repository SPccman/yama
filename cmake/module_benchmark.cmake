if(NOT _GAMESH_TOOLKIT_MODULE_BENCHMARK_)
    set(_GAMESH_TOOLKIT_MODULE_BENCHMARK_ ON)

    macro(gamesh_module_add_benchmark directory)
        if(ENABLE_BENCHMARK AND NOT "${CMAKE_CURRENT_SOURCE_DIR}" MATCHES "${CMAKE_SOURCE_DIR}/vendor/.+")
            add_subdirectory(${directory})
        endif()
    endmacro(gamesh_module_add_benchmark)

    # gamesh_module_benchmark(projectName [EXTRA extra_file_type ...] [EXCLUDE exclude_path ...])
    macro(gamesh_module_benchmark projectName)
        set(_GAMESH_CXX_FILE_TYPE_ *.c *.h *.inl *.cpp *.cc *.cxx *.hpp)
        set(_GAMESH_EXCLUDE_DIR_ .git vendor build bin)

        include(${GAMESH_TOOLKIT_DIR}/cmake/common.cmake)

        find_package(benchmark CONFIG REQUIRED)

        filter_source_files(PROJECT_FILES ${ARGN})
        use_source_folders(${PROJECT_FILES})

        add_executable(${projectName} ${PROJECT_FILES})
        target_link_libraries(${projectName} PRIVATE benchmark::benchmark benchmark::benchmark_main)

        use_proj_folders(${projectName})

        # if(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/test_cases)
        #     file(REMOVE_RECURSE ${CMAKE_SOURCE_DIR}/bin/tests/${projectName})
        #     file(GLOB_RECURSE testCases ${CMAKE_CURRENT_SOURCE_DIR}/test_cases/*)
        #     foreach(f ${testCases})
        #         get_filename_component(dirName ${f} DIRECTORY)
        #         file(RELATIVE_PATH relative ${CMAKE_CURRENT_SOURCE_DIR}/test_cases ${dirName})
        #         file(COPY ${f} DESTINATION ${CMAKE_SOURCE_DIR}/bin/tests/${projectName}/${relative})
        #     endforeach()
        # endif()

        # set_target_properties(${projectName} PROPERTIES
        #     RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}
        #     CXX_STANDARD 17 
        #     CXX_STANDARD_REQUIRED YES 
        #     CXX_EXTENSIONS NO
        # )
    endmacro(gamesh_module_benchmark)
endif()
