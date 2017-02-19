#ifndef FOX_LEXER_HPP
#define FOX_LEXER_HPP

#include<iostream>
#include<fstream>
#include "src/fox/parser/fox_parser.hpp"

#if ! defined(yyFlexLexerOnce)
#undef yyFlexLexer
#define yyFlexLexer fox_FlexLexer
#include <FlexLexer.h>
#endif

#undef YY_DECL
#define YY_DECL \
    fox::parser::fox_parser::symbol_type fox::lexer::fox_lexer::next_token ()

namespace fox {
namespace lexer {

class fox_lexer : public yyFlexLexer {
public:
  fox_lexer() {}
  ~fox_lexer() {}

  virtual fox::parser::fox_parser::symbol_type next_token();


  void set_location_filename(std::string filename){
    this->loc.begin.filename = &filename;
    this->loc.end.filename = &filename;
  }

private:
  fox::parser::location loc;
};

}
}

#endif
