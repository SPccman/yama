if(NOT _GAMESH_TOOLKIT_PROJECT_)
    set(_GAMESH_TOOLKIT_PROJECT_ ON)

    # GAMESH_INCLUDE_DIRECTORIES
    # GAMESH_LINK_DIRECTORIES
    # GAMESH_VENDOR_DIRECTORY
    # GAMESH_VCPKG_INSTALLED
    function(gamesh_project projectName)
        include(${GAMESH_TOOLKIT_DIR}/cmake/common.cmake)
        include(${GAMESH_VENDOR_DIRECTORY}/bucket/packages.cmake)

        if (EXISTS ${_VCPKG_INSTALLED_DIR})
            install(DIRECTORY ${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/debug/lib
                CONFIGURATIONS Debug
                DESTINATION ${CMAKE_INSTALL_PREFIX}/debug
                FILES_MATCHING PATTERN "*.so*")
            install(DIRECTORY ${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/lib
                CONFIGURATIONS Release MinSizeRel RelWithDebInfo
                DESTINATION ${CMAKE_INSTALL_PREFIX}/release
                FILES_MATCHING PATTERN "*.so*")
        endif ()
    endfunction(gamesh_project)
endif()
