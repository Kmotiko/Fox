set(CMAKE_VERBOSE_MAKEFILE 1)
cmake_minimum_required(VERSION 2.8.11)
PROJECT(FOX CXX)

enable_testing()


#GTEST Settings
set(GTEST_DIR ${CMAKE_BINARY_DIR}/ext-proj/gtest)
configure_file(gtest.cmake ${GTEST_DIR}CMakeLists.txt)
execute_process(COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}" .
  RESULT_VARIABLE result
  WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/ext-proj/gtest)
execute_process(COMMAND ${CMAKE_COMMAND} --build .
  RESULT_VARIABLE result
  WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/ext-proj/gtest)
add_subdirectory(${GTEST_DIR}/src ${GTEST_DIR}/build)


# BISON and FLEX
find_package(BISON 3)
find_package(FLEX 2.6)

if(NOT CMAKE_CXX_COMPILER)
  set(CMAKE_CXX_COMPILER clang++)
endif()


# LLVM FLAGS
if(NOT LLVM_CONFIG)
  set(LLVM_CONFIG llvm-config)
endif()

execute_process(COMMAND ${LLVM_CONFIG}  --libdir
  OUTPUT_VARIABLE LLVM_LIB_DIR
  OUTPUT_STRIP_TRAILING_WHITESPACE
  )
execute_process(COMMAND ${LLVM_CONFIG}  --includedir
  OUTPUT_VARIABLE LLVM_INCLUDE_DIR
  OUTPUT_STRIP_TRAILING_WHITESPACE
  )
execute_process(COMMAND ${LLVM_CONFIG}  --libs
  OUTPUT_VARIABLE LLVM_LIB_FLAGS
  OUTPUT_STRIP_TRAILING_WHITESPACE
  )

list(APPEND LLVM_LIB_NAMES
     ncurses
     pthread
     z
     m
     dl)
string(REGEX MATCHALL "-l([^ ]+)" LLVM_LIBS ${LLVM_LIB_FLAGS})
foreach(var ${LLVM_LIBS})
  string(REGEX REPLACE "-l([^ ]+)" "\\1" LIB_NAME ${var})
  list(APPEND LLVM_LIB_NAMES ${LIB_NAME})
endforeach(var)

set (LLVM_CXX_FLAGS
  -D_DEBUG -D_GNU_SOURCE -D__STDC_CONSTANT_MACROS -D__STDC_FORMAT_MACROS -D__STDC_LIMIT_MACROS -O3 -fvisibility-inlines-hidden -fno-common -Wcast-qual
)

include_directories(${PROJECT_SOURCE_DIR})
include_directories(${PROJECT_BINARY_DIR})
include_directories(${LLVM_INCLUDE_DIR})
link_directories(${LLVM_LIB_DIR})

add_definitions(-std=c++1y -Wall)
add_definitions(${LLVM_CXX_FLAGS})

add_subdirectory(src)
add_subdirectory(test)
