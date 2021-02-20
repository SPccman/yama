if(NOT _GAMESH_TOOLKIT_SET_NOT_EXIST_)
    set(_GAMESH_TOOLKIT_SET_NOT_EXIST_ ON)

    function(set_not_exists variable)
        if(NOT DEFINED ${variable} OR ${variable} STREQUAL "")
            set(${variable} ${ARGN} PARENT_SCOPE)
        endif()
    endfunction(set_not_exists)
endif()
