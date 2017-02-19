file(GLOB_RECURSE CPPFILES *.cpp)
BISON_TARGET(fox_parser ${CMAKE_CURRENT_SOURCE_DIR}/fox.y ${CMAKE_CURRENT_BINARY_DIR}/fox_parser.cpp)
add_library(parser ${BISON_fox_parser_OUTPUTS})
