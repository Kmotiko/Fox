add_executable(driver_test driver_test.cpp)
target_link_libraries(driver_test driver gtest_main)

add_test(driver_test ${EXECUTABLE_OUTPUT_PATH}/driver_test)

