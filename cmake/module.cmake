if(NOT YAMA_CMAKE_MODULE_)
    set(YAMA_CMAKE_MODULE_ ON)

    # yama_module(projectName EXECUTE|DYNAMIC|STATIC [EXTRA extra_file_type ...] [EXCLUDE exclude_path ...])
    macro(yama_module projectName projectType)
        set(_CXX_FILE_TYPE_ *.c *.h *.inl *.cpp *.cc *.cxx *.hpp)
        set(_EXCLUDE_DIR_ .git build bin tests benchmark)

        include(${YAMA_CMAKE_DIR}/common.cmake)

        filter_source_files(PROJECT_FILES ${ARGN})
        use_source_folders(${PROJECT_FILES})

        if(${projectType} STREQUAL EXECUTE)
            add_executable(${projectName} ${PROJECT_FILES})
        elseif(${projectType} STREQUAL DYNAMIC)
            add_library(${projectName} SHARED ${PROJECT_FILES})
        elseif(${projectType} STREQUAL STATIC)
            add_library(${projectName} STATIC ${PROJECT_FILES})
        else()
            message(FATAL_ERROR "Unknown ProjectType ${projectType} expect EXECUTE|DYNAMIC|STATIC")
        endif()

        cmake_set_install(${projectName})

        use_proj_folders(${projectName})

    endmacro(yama_module)
endif()
