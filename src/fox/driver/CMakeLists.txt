file(GLOB_RECURSE CPPFILES *.cpp)
add_library(driver ${CPPFILES})
add_dependencies(driver parser)
