set(EXECUTABLE_OUTPUT_PATH ${PROJECT_BINARY_DIR})
add_executable(fox main.cpp)
target_link_libraries(fox
              ast
              parser
              driver
              lexer
              semantics_analyzer
              code_generator
              ${LLVM_LIB_NAMES}
              )
add_subdirectory(fox)

install(TARGETS fox DESTINATION bin)

