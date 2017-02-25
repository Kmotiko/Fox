add_executable(ast_test ast_test.cpp)
target_link_libraries(ast_test ast gtest_main)

add_test(ast_test ${EXECUTABLE_OUTPUT_PATH}/ast_test)

