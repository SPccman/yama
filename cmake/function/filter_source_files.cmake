if(NOT _CMAKE_TOOLKIT_FILTER_SROUCE_FILES_)
    set(_CMAKE_TOOLKIT_FILTER_SROUCE_FILES_ ON)

    cmake_policy(SET CMP0057 NEW)

    # filter_source_files(out_file_list [EXTRA extra_file_type ...] [EXCLUDE exclude_path ...])
    function(filter_source_files out_file_list)
        cmake_log("${CMAKE_CURRENT_SOURCE_DIR} filter_source_files start")
        list(APPEND method_type EXTRA EXCLUDE)

        # add params to extra_file_type or exclude_path
        set(i 0)
        list(LENGTH ARGN length)
        while(i LESS ${length})
            list(GET ARGN ${i} arg)
            math(EXPR i "${i}+1")

            if(${arg} STREQUAL EXTRA)
                set(LOOP ON)
                while(${LOOP} AND i LESS ${length})
                    list(GET ARGN ${i} next_arg)
                    if(${next_arg} IN_LIST method_type)
                        set(LOOP OFF)
                    else()
                        list(APPEND extra_file_type ${next_arg})
                        math(EXPR i "${i}+1")
                    endif()
                endwhile()
            elseif(${arg} STREQUAL EXCLUDE)
                set(LOOP ON)
                while(${LOOP} AND i LESS ${length})
                    list(GET ARGN ${i} next_arg)
                    if("${next_arg}" IN_LIST method_type)
                        set(LOOP OFF)
                    else()
                        list(APPEND exclude_path ${next_arg})
                        math(EXPR i "${i}+1")
                    endif()
                endwhile()
            else()
                message(FATAL_ERROR "Invalid argument: ${arg} Unknown arguments specified")
            endif()
        endwhile()

        # add extra file type to file_types
        set(file_types ${_CXX_FILE_TYPE_})
        list(APPEND file_types ${extra_file_type})

        # add all source files in ./
        file(GLOB sources_list ${file_types})

        cmake_log("curdir sources ${sources_list} file_types ${file_types}")

        # add all source files in subdirectory except in list _EXCLUDE_DIR_
        file(GLOB children RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_SOURCE_DIR}/*)
        foreach(child ${children})
            cmake_log("child ${child}")
            if(IS_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/${child} AND NOT ${child} IN_LIST _EXCLUDE_DIR_)
                foreach(types ${file_types})
                    list(APPEND cur_dir_file_types ${CMAKE_CURRENT_SOURCE_DIR}/${child}/${types})
                endforeach()
                file(GLOB_RECURSE dir_sources_list ${cur_dir_file_types})
                cmake_log("dir_sources_list ${dir_sources_list}")
                list(APPEND sources_list ${dir_sources_list})
            endif()
        endforeach()

        if(DEFINED exclude_path)
            foreach(path ${exclude_path})
                filter_list(sources_list ${path} EXCLUDE ${sources_list})
            endforeach(path)
        endif()

        set(${out_file_list} ${sources_list} PARENT_SCOPE)
        cmake_log("sources_list ${sources_list}")
        cmake_log("${CMAKE_CURRENT_SOURCE_DIR} filter_source_files end")
    endfunction(filter_source_files)
endif()
