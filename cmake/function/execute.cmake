if(NOT _CMAKE_TOOLKIT_EXECUTE_)
    set(_CMAKE_TOOLKIT_EXECUTE_ ON)

    function(gamesh_execute)
        set(params)
        set(index 0)
        while(index LESS ${ARGC})
            set(params ${params} ${ARGV${index}})
            math(EXPR index "${index}+1")
        endwhile()

        execute_process(
            ${params}
            RESULT_VARIABLE EXE_RESUTL
            OUTPUT_VARIABLE EXE_OUTPUT
            ERROR_VARIABLE EXE_ERR
            ENCODING UTF8
            # ECHO_OUTPUT_VARIABLE
            # ECHO_ERROR_VARIABLE
        )

        if(${EXE_RESUTL} EQUAL 0)
            # if("${EXE_OUTPUT}" STREQUAL "")
            # else()
            #     message(${EXE_OUTPUT})
            # endif()
        elseif(${EXE_RESUTL} EQUAL 1)
            if("${EXE_OUTPUT}" STREQUAL "")
            else()
                message(${EXE_OUTPUT})
            endif()
            if("${EXE_ERR}" STREQUAL "")
            else()
                message("${EXE_ERR}")
                list(JOIN params " " params_string)
                message(FATAL_ERROR "${params_string}")
            endif()
        else()
            message("${EXE_RESUTL}")
            if("${EXE_ERR}" STREQUAL "")
            else()
                message("${EXE_ERR}")
            endif()
            list(JOIN params " " params_string)
            message(FATAL_ERROR "${params_string}")
        endif()
    endfunction(gamesh_execute)
endif()