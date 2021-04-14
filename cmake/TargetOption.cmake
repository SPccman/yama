if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.10")
  include_guard(GLOBAL)
endif()

# 设置实际的默认编译输出目录，为防止呗外部模块设置，所以要先判定一下

if(NOT DEFINED __TARGET_OPTION_LOADED)
  set(__TARGET_OPTION_LOADED 1)
  include(GNUInstallDirs)
  # add CMAKE_INSTALL_*, CMAKE_INSTALL_LIBDIR, CMAKE_INSTALL_BINDIR, CMAKE_INSTALL_INCLUDEDIR and etc.

  if(NOT CMAKE_ARCHIVE_OUTPUT_DIRECTORY)
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/${CMAKE_INSTALL_LIBDIR}")
  endif()

  if(NOT CMAKE_LIBRARY_OUTPUT_DIRECTORY)
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/${CMAKE_INSTALL_LIBDIR}")
  endif()

  if(NOT CMAKE_RUNTIME_OUTPUT_DIRECTORY)
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/${CMAKE_INSTALL_BINDIR}")
  endif()

  # set(EXECUTABLE_OUTPUT_PATH "${PROJECT_BINARY_DIR}/bin")

  link_directories(${CMAKE_ARCHIVE_OUTPUT_DIRECTORY})
endif()