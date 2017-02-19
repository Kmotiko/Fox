#include "src/fox/driver/fox_driver.hpp"

namespace fox {
namespace driver {

int fox_driver::compile(const std::string &filename) {
  // create filestream
  std::ifstream file_stream(filename, std::ios::in);

  // create lexer
  fox::lexer::fox_lexer lexer;
  lexer.switch_streams(file_stream, std::cout);
  lexer.set_location_filename(filename);

  // create parser
  fox::parser::fox_parser parser(*this, lexer);
  int result = parser.parse();

  // TODO: generate object code


  // return result
  return result;
}

}
}
