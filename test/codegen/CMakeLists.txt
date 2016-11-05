add_executable(codegen_test codegen_test.cpp)
target_link_libraries(codegen_test ${Boost_LIBRARIES} code_generator)

add_test(codegen_test ${EXECUTABLE_OUTPUT_PATH}/codegen_test)

