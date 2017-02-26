%{
#include<iostream>
#include<string>
#include"src/fox/lexer/fox_lexer.hpp"
#include"src/fox/parser/fox_parser.hpp"

# undef yywrap
# define yywrap() 1

// define yyterminate
#define yyterminate() fox::parser::fox_parser::make_END(loc);
%}

%option c++
%option noyywrap
%option yyclass="fox_lexer"
%option prefix="fox_"

%%

<<EOF>>                         return fox::parser::fox_parser::make_END(loc);
"int"                           return fox::parser::fox_parser::make_INT(loc);
"int8"                          return fox::parser::fox_parser::make_INT8(loc);
"int16"                         return fox::parser::fox_parser::make_INT16(loc);
"int32"                         return fox::parser::fox_parser::make_INT32(loc);
"int64"                         return fox::parser::fox_parser::make_INT64(loc);
"uint"                          return fox::parser::fox_parser::make_UINT(loc);
"uint8"                         return fox::parser::fox_parser::make_UINT8(loc);
"uint16"                        return fox::parser::fox_parser::make_UINT16(loc);
"uint32"                        return fox::parser::fox_parser::make_UINT32(loc);
"uint64"                        return fox::parser::fox_parser::make_UINT64(loc);
"float"                         return fox::parser::fox_parser::make_FLOAT(loc);
"double"                        return fox::parser::fox_parser::make_DOUBLE(loc);
"bool"                          return fox::parser::fox_parser::make_BOOL(loc);
"byte"                          return fox::parser::fox_parser::make_BYTE(loc);
"def"                           return fox::parser::fox_parser::make_DEF(loc);
"class"                         return fox::parser::fox_parser::make_CLASS(loc);
"if"                            return fox::parser::fox_parser::make_IF(loc);
"else"                          return fox::parser::fox_parser::make_ELSE(loc);
"switch"                        return fox::parser::fox_parser::make_SWITCH(loc);
"case"                          return fox::parser::fox_parser::make_CASE(loc);
"default"                       return fox::parser::fox_parser::make_DEFAULT(loc);
"for"                           return fox::parser::fox_parser::make_FOR(loc);
"continue"                      return fox::parser::fox_parser::make_CONTINUE(loc);
"jump"                          return fox::parser::fox_parser::make_JUMP(loc);
"return"                        return fox::parser::fox_parser::make_RETURN(loc);
"import"                        return fox::parser::fox_parser::make_IMPORT(loc);
"new"                           return fox::parser::fox_parser::make_NEW(loc);
"nil"                           return fox::parser::fox_parser::make_NIL(loc);
"true"                          return fox::parser::fox_parser::make_TRUE(loc);
"false"                         return fox::parser::fox_parser::make_FALSE(loc);
"\n"                            return fox::parser::fox_parser::make_LF(loc);
"\r\n"                          return fox::parser::fox_parser::make_CRLF(loc);
"*"                             return fox::parser::fox_parser::make_MUL_OP(loc);
"/"                             return fox::parser::fox_parser::make_DIV_OP(loc);
"+"                             return fox::parser::fox_parser::make_ADD_OP(loc);
"-"                             return fox::parser::fox_parser::make_SUB_OP(loc);
"++"                            return fox::parser::fox_parser::make_INC(loc);
"--"                            return fox::parser::fox_parser::make_DEC(loc);
"="                             return fox::parser::fox_parser::make_ASSIGN(loc);
"*="                            return fox::parser::fox_parser::make_MULASSIGN(loc);
"/="                            return fox::parser::fox_parser::make_DIVASSIGN(loc);
"+="                            return fox::parser::fox_parser::make_PLUSASSIGN(loc);
"-="                            return fox::parser::fox_parser::make_MINUSASSIGN(loc);
"=="                            return fox::parser::fox_parser::make_EQUAL(loc);
"!="                            return fox::parser::fox_parser::make_NOTEQUAL(loc);
"<"                             return fox::parser::fox_parser::make_LESS(loc);
">"                             return fox::parser::fox_parser::make_GREATER(loc);
"<="                            return fox::parser::fox_parser::make_LESSEQ(loc);
">="                            return fox::parser::fox_parser::make_GREATEREQ(loc);
"||"                            return fox::parser::fox_parser::make_OR(loc);
"&&"                            return fox::parser::fox_parser::make_AND(loc);
"!"                             return fox::parser::fox_parser::make_NOT(loc);
"|"                             return fox::parser::fox_parser::make_BITOR(loc);
"&"                             return fox::parser::fox_parser::make_BITAND(loc);
"~"                             return fox::parser::fox_parser::make_BITNOT(loc);
"^"                             return fox::parser::fox_parser::make_BITXOR(loc);
">>"                            return fox::parser::fox_parser::make_RSHIFT(loc);
"<<"                            return fox::parser::fox_parser::make_LSHIFT(loc);
"("                             return fox::parser::fox_parser::make_LPAREN(loc);
")"                             return fox::parser::fox_parser::make_RPAREN(loc);
"{"                             return fox::parser::fox_parser::make_LBREATH(loc);
"}"                             return fox::parser::fox_parser::make_RBREATH(loc);
"["                             return fox::parser::fox_parser::make_LSQUARE_BRACKET(loc);
"]"                             return fox::parser::fox_parser::make_RSQUARE_BRACKET(loc);
"."                             return fox::parser::fox_parser::make_DOT(loc);
","                             return fox::parser::fox_parser::make_COMMA(loc);
":"                             return fox::parser::fox_parser::make_COLLON(loc);
"::"                            return fox::parser::fox_parser::make_DCOLLON(loc);
";"                             return fox::parser::fox_parser::make_SEMICOLLON(loc);
[ \t]                           loc.step();
[a-zA-Z_]+[a-zA-Z0-9_]*         return fox::parser::fox_parser::make_IDENTIFIER(yytext, loc);
[0-9]+.[0-9]*                   return fox::parser::fox_parser::make_FLOATING(yytext, loc);
[0-9]+                          return fox::parser::fox_parser::make_INTEGER(yytext, loc);
\"[.]*\"                        return fox::parser::fox_parser::make_STRINGLITERAL(yytext, loc);

%%
