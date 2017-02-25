add_executable(lexer_test lexer_test.cpp)
target_link_libraries(lexer_test lexer gtest_main)

add_test(lexer_test ${EXECUTABLE_OUTPUT_PATH}/lexer_test)

