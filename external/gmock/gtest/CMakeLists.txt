include(ExternalProject)

ExternalProject_Add(googletest
    URL /usr/local/src/gmock/gtest
    PREFIX "${CMAKE_CURRENT_BINARY_DIR}"
    INSTALL_COMMAND "")

ExternalProject_Get_Property(googletest source_dir)
set(GTEST_INCLUDE_DIRS ${source_dir}/include PARENT_SCOPE)

ExternalProject_Get_Property(googletest binary_dir)
set(GTEST_LIBS_DIR ${binary_dir} PARENT_SCOPE)
