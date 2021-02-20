if(NOT _CMAKE_TOOLKIT_USE_PROJ_FOLDERS_)
    set(_CMAKE_TOOLKIT_USE_PROJ_FOLDERS_ ON)

    function(use_proj_folders name)
        if("${CMAKE_CURRENT_SOURCE_DIR}" MATCHES "${CMAKE_SOURCE_DIR}/vendor/.+")
            set_property(TARGET ${name} PROPERTY FOLDER "Modules")
        endif()

        if("${CMAKE_CURRENT_SOURCE_DIR}" MATCHES "${CMAKE_SOURCE_DIR}/app/.+")
            set_property(TARGET ${name} PROPERTY FOLDER "App")
        endif()

        if("${CMAKE_CURRENT_SOURCE_DIR}" MATCHES "^${CMAKE_SOURCE_DIR}/.+/tests$")
            set_property(TARGET ${name} PROPERTY FOLDER "Tests")
        endif()

        if("${CMAKE_CURRENT_SOURCE_DIR}" MATCHES "^${CMAKE_SOURCE_DIR}/test")
            set_property(TARGET ${name} PROPERTY FOLDER "Tests")
        endif()
    endfunction(use_proj_folders)
endif()
