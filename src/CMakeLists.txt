set(EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR})
add_executable(fox main.cpp)
target_link_libraries(fox
              ast
              parser
              semantics_analyzer
              code_generator
              ${LLVM_LIB_NAMES}
              )
install(TARGETS fox DESTINATION bin)

add_subdirectory(fox)
