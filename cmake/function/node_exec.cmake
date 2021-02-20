if(NOT _CMAKE_TOOLKIT_NODE_EXEC_)
    set(_CMAKE_TOOLKIT_NODE_EXEC_ ON)

    function(node_exec)
        message("GAMESH_TOOLKIT_DIR ${GAMESH_TOOLKIT_DIR}")
        if(CMAKE_SYSTEM_NAME MATCHES "Linux")
            set(NODE "${GAMESH_TOOLKIT_DIR}/node/runtime/node")
        else()
            set(NODE "${GAMESH_TOOLKIT_DIR}/node/runtime/node.exe")
        endif()

        gamesh_execute(COMMAND "${NODE}" ${ARGN})
    endfunction(node_exec)
endif()
