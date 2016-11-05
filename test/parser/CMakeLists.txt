add_executable(parser_test parser_test.cpp)
target_link_libraries(parser_test ${Boost_LIBRARIES} parser)

add_test(parser_test ${EXECUTABLE_OUTPUT_PATH}/parser_test)

