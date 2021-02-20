if(NOT _CMAKE_TOOLKIT_SHELL_GENERATOR_)
    set(_CMAKE_TOOLKIT_SHELL_GENERATOR_ ON)

    function(shell_generator inputfile outfile)
        if(NOT IS_ABSOLUTE ${outfile})
            get_filename_component(outfile "${outfile}" REALPATH BASE_DIR "${CMAKE_CURRENT_SOURCE_DIR}")
        endif()

        if(NOT IS_ABSOLUTE ${inputfile})
            get_filename_component(inputfile "${inputfile}" REALPATH BASE_DIR "${CMAKE_CURRENT_SOURCE_DIR}")
        endif()

        if(CMAKE_SYSTEM_NAME MATCHES "Windows")
            set(NODE ${GAMESH_TOOLKIT_DIR}/node/runtime/node.exe)
        else()
            set(NODE ${GAMESH_TOOLKIT_DIR}/node/runtime/node)
        endif()

        set(js_path ${GAMESH_TOOLKIT_DIR}/node/scripts/generate_example.js)

        gamesh_execute(
            COMMAND "${NODE}" ${js_path} "${CMAKE_SOURCE_DIR}" "${CMAKE_CURRENT_SOURCE_DIR}" "${inputfile}" "${outfile}"
            WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
        )

        gamesh_execute(COMMAND "${outfile}")
    endfunction(shell_generator)
endif()
