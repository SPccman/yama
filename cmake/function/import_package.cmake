if(NOT _GAMESH_TOOLKIT_IMPORT_PACKAGE_)
    set(_GAMESH_TOOLKIT_IMPORT_PACKAGE_ ON)

    function(gamesh_import_package name)
        if(NOT GAMESH_HAS_VCPKG)
            message("Package vcpkg does not installed.")
            message(FATAL_ERROR "Execute command `bucket install` or `bucket require gamesh/vcpkg` in project root directory before cmake.")
        endif()

        set(_IMPORT_PREFIX ${GAMESH_VCPKG_INSTALLED}/${VCPKG_TARGET_TRIPLET})

        if(CMAKE_SYSTEM_NAME MATCHES Linux)
            if (EXISTS ${_IMPORT_PREFIX}/lib/lib${name}.so)
                set(filename lib${name}.so)
                set(TYPE SHARED)
            elseif(EXISTS ${_IMPORT_PREFIX}/lib/lib${name}.a)
                set(filename lib${name}.a)
                set(TYPE STATIC)
            else()
                message(FATAL_ERROR "Import package failed. Can not find lib${name}.so or lib${name}.a in ${_IMPORT_PREFIX}/lib")
            endif()
        elseif(CMAKE_SYSTEM_NAME MATCHES Windows)
            if (EXISTS ${_IMPORT_PREFIX}/bin/${name}.dll AND EXISTS ${_IMPORT_PREFIX}/lib/${name}.lib)
                set(filename ${name}.lib)
                set(TYPE SHARED)
            elseif (EXISTS ${_IMPORT_PREFIX}/lib/${name}.lib)
                set(filename ${name}.lib)
                set(TYPE STATIC)
            else()
                message(FATAL_ERROR "Import package failed. Can not find ${name}.dll in ${_IMPORT_PREFIX}/bin or ${name}.a in ${_IMPORT_PREFIX}/lib")
            endif()
        else()
            message(FATAL_ERROR "Unsupported operating system. ${CMAKE_SYSTEM_NAME}")
        endif()

        add_library(${name} ${TYPE} IMPORTED)

        set_target_properties(${name} PROPERTIES
            # INTERFACE_COMPILE_DEFINITIONS "GTEST_LINKED_AS_SHARED_LIBRARY=1"
            INTERFACE_INCLUDE_DIRECTORIES "${_IMPORT_PREFIX}/include"
            INTERFACE_SYSTEM_INCLUDE_DIRECTORIES "${_IMPORT_PREFIX}/include"
        )

        set_property(TARGET ${name} APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
        set_property(TARGET ${name} APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)

        set_target_properties(${name} PROPERTIES
            # IMPORTED_LINK_INTERFACE_LIBRARIES_DEBUG "Threads::Threads"
            IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/${filename}"
            IMPORTED_SONAME_RELEASE "${filename}"
            IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/debug/lib/${filename}"
            IMPORTED_SONAME_DEBUG "${filename}"
        )
    endfunction(gamesh_import_package)
endif()
