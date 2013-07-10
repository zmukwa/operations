cmake_minimum_required(VERSION 2.8)

project(OPERATIONS CXX)

set(OPERATIONS_VERSION_MAJOR 0)
set(OPERATIONS_VERSION_MINOR 1)
set(OPERATIONS_VERSION_PATCH 0)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

add_subdirectory(${PROJECT_SOURCE_DIR}/external/gmock)
add_subdirectory(${PROJECT_SOURCE_DIR}/external/gmock/gtest)

include_directories(${GMOCK_INCLUDE_DIRS})
include_directories(${GTEST_INCLUDE_DIRS})

add_executable(operations main.cpp operations.cpp)

install(TARGETS operations RUNTIME DESTINATION bin)

add_executable(operations_test operations_test.cpp operations.cpp)

add_dependencies(operations_test googlemock)
add_dependencies(operations_test googletest)

target_link_libraries(operations_test pthread)
target_link_libraries(operations_test ${GTEST_LIBS_DIR}/libgtest.a ${GTEST_LIBS_DIR}/libgtest_main.a)
target_link_libraries(operations_test ${GMOCK_LIBS_DIR}/libgmock.a ${GMOCK_LIBS_DIR}/libgmock_main.a)

enable_testing()

add_test(NAME test COMMAND operations_test --gtest_output=xml:report.xml)
