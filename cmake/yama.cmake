if(NOT YAMA_CMAKE_ENTRY)
    set(YAMA_CMAKE_ENTRY ON)

    set(YAMA_CMAKE_DIR ${CMAKE_CURRENT_LIST_DIR})

    include (${CMAKE_CURRENT_LIST_DIR}/find_platform.cmake)

    # include cmake functions
    # CMAKE_CURRENT_LIST_DIR means the directory of this file
    # find all files in function directory, result will be return as relative path to CMAKE_CURRENT_LIST_DIR
    file(GLOB files RELATIVE ${CMAKE_CURRENT_LIST_DIR} ${CMAKE_CURRENT_LIST_DIR}/function/*)
    foreach(file ${files})
        message("include ${CMAKE_CURRENT_LIST_DIR}/${file}")
        include(${CMAKE_CURRENT_LIST_DIR}/${file})
    endforeach()

    # include cmake files
    include(${CMAKE_CURRENT_LIST_DIR}/module.cmake)
endif()
