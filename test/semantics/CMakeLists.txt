add_executable(semantics_test semantics_test.cpp)

target_link_libraries(semantics_test semantics_analyzer gtest_main)

add_test(semantics_test ${EXECUTABLE_OUTPUT_PATH}/semantics_test)

