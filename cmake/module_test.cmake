if(NOT _GAMESH_TOOLKIT_MODULE_TEST_)
    set(_GAMESH_TOOLKIT_MODULE_TEST_ ON)

    macro(gamesh_module_add_test directory)
        if(ENABLE_TEST AND NOT "${CMAKE_CURRENT_SOURCE_DIR}" MATCHES "${CMAKE_SOURCE_DIR}/vendor/.+")
            add_subdirectory(${directory})
        endif()
    endmacro(gamesh_module_add_test)

    # gamesh_module_test(projectName testParams [EXTRA extra_file_type ...] [EXCLUDE exclude_path ...])
    macro(gamesh_module_test projectName testParams)
        set(_GAMESH_CXX_FILE_TYPE_ *.c *.h *.inl *.cpp *.cc *.cxx *.hpp)
        set(_GAMESH_EXCLUDE_DIR_ .git vendor build bin)

        include(${GAMESH_TOOLKIT_DIR}/cmake/common.cmake)

        find_package(GTest CONFIG REQUIRED)

        filter_source_files(PROJECT_FILES ${ARGN})
        use_source_folders(${PROJECT_FILES})

        add_executable(${projectName} ${PROJECT_FILES})
        target_link_libraries(${projectName} PRIVATE GTest::gtest GTest::gtest_main GTest::gmock GTest::gmock_main)

        use_proj_folders(${projectName})

        set_not_exists(GAMESH_TEST_CASE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/test_cases)

        if(EXISTS ${GAMESH_TEST_CASE_DIR})
            file(REMOVE_RECURSE ${GAMESH_TEST_CASE_DIR}/${projectName})
            file(GLOB_RECURSE testCases ${GAMESH_TEST_CASE_DIR}/*)
            foreach(f ${testCases})
                get_filename_component(dirName ${f} DIRECTORY)
                file(RELATIVE_PATH relative ${GAMESH_TEST_CASE_DIR} ${dirName})
                file(COPY ${f} DESTINATION ${CMAKE_SOURCE_DIR}/bin/tests/${projectName}/${relative})
            endforeach()
        endif()

        # set_target_properties(${projectName} PROPERTIES
        #     RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}
        #     CXX_STANDARD 17 
        #     CXX_STANDARD_REQUIRED YES 
        #     CXX_EXTENSIONS NO
        # )
        
        # add in ctest
        if(ENABLE_TEST AND NOT "${CMAKE_CURRENT_SOURCE_DIR}" MATCHES "${CMAKE_SOURCE_DIR}/vendor/.+")
            add_test(
                NAME ${projectName}
                COMMAND ${projectName} ${testParams}
                WORKING_DIRECTORY ${GAMESH_TEST_WORKING_DIRECTORY}
            )

            if(ENABLE_COVERAGE AND CMAKE_SYSTEM_NAME MATCHES "Linux")
                setup_target_for_coverage_lcov(
                    NAME  ${projectName}.coverage
                    EXECUTABLE ${projectName}
                    EXECUTABLE_ARGS ${testParams}
                    DEPENDENCIES ${projectName}
                    EXCLUDE
                        "/usr/*"
                        "${CMAKE_SOURCE_DIR}/deps/*"
                        "${CMAKE_SOURCE_DIR}/vendor/*"
                        "${CMAKE_CURRENT_SOURCE_DIR}/*")

                add_custom_command(
                    TARGET ${projectName}.coverage POST_BUILD
                    COMMAND cp ${PROJECT_BINARY_DIR}/${projectName}.coverage.info ${CMAKE_CURRENT_SOURCE_DIR}/../lcov.info;
                    COMMENT "Copy ${projectName}.coverage.info to ./lcov.info."
                )
            endif()
        endif()
    endmacro(gamesh_module_test)
endif()
