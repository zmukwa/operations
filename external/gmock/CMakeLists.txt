include(ExternalProject)

ExternalProject_Add(googlemock
    URL /usr/local/src/gmock
    PREFIX "${CMAKE_CURRENT_BINARY_DIR}"
    INSTALL_COMMAND "")

ExternalProject_Get_Property(googlemock source_dir)
set(GMOCK_INCLUDE_DIRS ${source_dir}/include PARENT_SCOPE)

ExternalProject_Get_Property(googlemock binary_dir)
set(GMOCK_LIBS_DIR ${binary_dir} PARENT_SCOPE)
