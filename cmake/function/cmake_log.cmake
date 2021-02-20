if(NOT _CMAKE_TOOLKIT_CMAKE_LOG_)
    set(_CMAKE_TOOLKIT_CMAKE_LOG_ ON)

    function(cmake_log)
        if(_CMAKE_TOOLKIT_LOG_SWITCH_)
            message(${ARGN})
        endif()
    endfunction(cmake_log)

endif()