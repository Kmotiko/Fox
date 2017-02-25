add_executable(codegen_test codegen_test.cpp)
target_link_libraries(codegen_test code_generator gtest_main)

add_test(codegen_test ${EXECUTABLE_OUTPUT_PATH}/codegen_test)

