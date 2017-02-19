file(GLOB_RECURSE CPPFILES *.cpp)
FLEX_TARGET(fox_lexer ${CMAKE_CURRENT_SOURCE_DIR}/fox.l ${CMAKE_CURRENT_BINARY_DIR}/fox_lexer.cpp)
add_library(lexer ${FLEX_fox_lexer_OUTPUTS})
add_dependencies(lexer parser)
