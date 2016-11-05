add_executable(semantics_test semantics_test.cpp)

target_link_libraries(semantics_test ${Boost_LIBRARIES} semantics_analyzer)

add_test(semantics_test ${EXECUTABLE_OUTPUT_PATH}/semantics_test)

