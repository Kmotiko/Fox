
%skeleton "lalr1.cc"
%require "3.0.4"
%defines
%define api.namespace {fox::parser}
%define api.token.constructor
%define api.value.type variant
%define parse.assert
%define parser_class_name {fox_parser}


%code requires{
#include<iostream>
#include<string>

namespace fox{
namespace driver{
class fox_driver;
}
}

namespace fox{
namespace lexer{
class fox_lexer;
}
}

}

%param { fox::driver::fox_driver &driver }
%param { fox::lexer::fox_lexer &lexer }
%locations


%define parse.trace
%define parse.error verbose


%code{
#include"src/fox/driver/fox_driver.hpp"
#include"src/fox/parser/fox_parser.hpp"
#include"src/fox/lexer/fox_lexer.hpp"
#include"src/fox/parser/location.hh"

static fox::parser::fox_parser::symbol_type yylex(fox::driver::fox_driver &driver, fox::lexer::fox_lexer &lexer){
  return lexer.next_token();
}
}


%define api.token.prefix {TOK_}
%token END 0 "end of file";
%token <std::string> IDENTIFIER FLOATING INTEGER STRINGLITERAL
%token NIL              "nil"
%token TRUE             "true"
%token FALSE            "false"
%token LF               "\n"
%token CRLF             "\r\n"
%token MUL              "*"
%token DIV              "/"
%token PLUS             "+"
%token MINUS            "-"
%token INC              "++"
%token DEC              "--"
%token ASSIGN           "="
%token MULASSIGN        "*="
%token DIVASSIGN        "/="
%token PLUSASSIGN       "+="
%token MINUSASSIGN      "-="
%token EQUAL            "=="
%token NOTEQUAL         "!="
%token LESS             "<"
%token LESSEQ           "<="
%token GREATER          ">"
%token GREATEREQ        ">="
%token LPAREN           "("
%token RPAREN           ")"
%token LBREATH          "{"
%token RBREATH          "}"
%token OR               "||"
%token AND              "&&"
%token NOT              "!!"
%token BITNOT           "~"
%token BITOR            "!"
%token BITAND           "&"
%token BITXOR           "^"
%token LSHIFT           "<<"
%token RSHIFT           ">>"
%token DOT              "."
%token COMMA            ","
%token COLLON           ":"
%token DCOLLON          "::"
%token SEMICOLLON       ";"
%token INT              "int"
%token SHORT            "short"
%token LONG             "long"
%token FLOAT            "float"
%token DOUBLE           "double"
%token BOOL             "bool"
%token STR              "str"
%token DEF              "def"
%token CLASS            "class"
%token CONST            "const"
%token IF               "if"
%token ELSE             "else"
%token SWITCH           "switch"
%token CASE             "case"
%token DEFAULT          "default"
%token FOR              "for"
%token CONTINUE         "continue"
%token JUMP             "jump"
%token RETURN           "return"
%token IMPORT           "import"

%start translation_unit


%%


new_line
: LF {}
| CRLF {}
;

separater
: SEMICOLLON {}
| new_line {}
;


translation_unit 
: external_declaration {}
| external_declaration translation_unit {}
;


external_declaration
: class_definition {}
| func_definition {}
| variable_declaration {}
| import_statement {}
| new_line 
;


class_definition 
: CLASS IDENTIFIER LBREATH in_class_declarations RBREATH {}
| CLASS IDENTIFIER LBREATH new_line in_class_declarations RBREATH {}
| CLASS IDENTIFIER COLLON IDENTIFIER LBREATH in_class_declarations RBREATH {}
| CLASS IDENTIFIER COLLON IDENTIFIER new_line LBREATH in_class_declarations RBREATH {}
;


in_class_declarations
: in_class_declaration {}
| in_class_declaration in_class_declarations {}
;


in_class_declaration
: variable_declaration {}
| func_definition {}
| new_line
|
;


func_definition 
: prototype compound_statement {}
;


prototype
: DEF IDENTIFIER LPAREN RPAREN type_specifier {}
| DEF IDENTIFIER LPAREN parameter_list RPAREN type_specifier {}
;


parameter_list
: variable_declaration {}
| variable_declaration COMMA parameter_list {}
;


variable_declaration
: IDENTIFIER type_specifier separater {}
| IDENTIFIER type_specifier ASSIGN initializer separater {}
| IDENTIFIER type_qualifier type_specifier separater {}
| IDENTIFIER type_qualifier type_specifier ASSIGN initializer separater {}
;


import_statement
: IMPORT module_name new_line {}
;


module_name
: IDENTIFIER {}
| IDENTIFIER DOT module_name {}
;


type_qualifier
: CONST {}
;


type_specifier
: INT {}
| SHORT {}
| LONG {}
| FLOAT {}
| DOUBLE {}
| BOOL {}
| STR {}
| IDENTIFIER {}
;


initializer
: assignment_expression {}
| assignment_expression EQUAL initializer {}
;


compound_statement
: LBREATH RBREATH {}
| LBREATH new_line RBREATH {}
| LBREATH statement_list RBREATH {}
;


statement_list
: statement {}
| statement_list statement {}
;


statement
: compound_statement {}
| variable_declaration {}
| labeld_statement {}
| expression_statement {}
| if_statement {}
| switch_statement {}
| for_statement {}
| jump_statement {}
;


labeld_statement
: IDENTIFIER COLLON statement {}
;


expression_statement
: separater {}
| expression separater {}
;


expression
: assignment_expression {}
| assignment_expression expression {}
;


if_statement
: IF expression statement {}
| IF expression statement ELSE statement {}
;


switch_statement
: SWITCH expression LBREATH case_statement RBREATH {}
;


case_statement
: CASE expression COLLON new_line statement {}
| DEFAULT COLLON new_line statement {}
;


for_statement
: FOR expression statement {}
| FOR expression SEMICOLLON expression SEMICOLLON statement {}
;


jump_statement
: JUMP IDENTIFIER {}
| CONTINUE {}
| RETURN {}
| RETURN expression {}
;


assignment_expression
: conditional_expression {}
| IDENTIFIER ASSIGN conditional_expression {}
| IDENTIFIER DIVASSIGN conditional_expression {}
| IDENTIFIER MULASSIGN conditional_expression {}
| IDENTIFIER PLUSASSIGN conditional_expression {}
| IDENTIFIER MINUSASSIGN conditional_expression {}
;


conditional_expression
: logical_or_expression {}
| expression IF logical_or_expression ELSE conditional_expression {}
;


logical_or_expression
: logical_and_expression {}
| logical_or_expression OR logical_and_expression {}
;


logical_and_expression
: inclusive_or_expression {}
| logical_and_expression AND inclusive_or_expression {}
;


inclusive_or_expression
: exclusive_or_expression {}
| inclusive_or_expression BITOR exclusive_or_expression {}
;


exclusive_or_expression
: and_expression {}
| exclusive_or_expression BITXOR and_expression {}
;


and_expression
: equality_expression {}
| and_expression BITAND equality_expression {}


equality_expression
: relational_expression {}
| equality_expression EQUAL relational_expression {}
| equality_expression NOTEQUAL relational_expression {}
;


relational_expression
: shift_expression {}
| relational_expression LESS shift_expression {}
| relational_expression GREATER shift_expression {}
| relational_expression LESSEQ shift_expression {}
| relational_expression GREATEREQ shift_expression {}
;

shift_expression
: additive_expression {}
| shift_expression LSHIFT additive_expression {}
| shift_expression RSHIFT additive_expression {}
;


additive_expression
: multiplicative_expression {}
| additive_expression PLUS multiplicative_expression {}
| additive_expression MINUS additive_expression {}
;


multiplicative_expression
: cast_expression {}
| multiplicative_expression MUL cast_expression {}
| multiplicative_expression DIV cast_expression {}
;

cast_expression
: unary_expression {}
| LPAREN type_specifier RPAREN cast_expression {}
;


unary_expression
: postfix_expression {}
| unary_expression INC postfix_expression {}
| unary_expression DEC postfix_expression {}
;


postfix_expression
: primary_expression {}
| call_expression {}
| postfix_expression INC {}
| postfix_expression DEC {}
;

call_expression
: IDENTIFIER LPAREN argument_list RPAREN {}
| IDENTIFIER DOT call_expression {}
;


argument_list
: assignment_expression {}
| argument_list COMMA assignment_expression {}
;


primary_expression
: IDENTIFIER {}
| INTEGER {}
| FLOATING {}
| STRINGLITERAL {}
| NIL {}
| TRUE {}
| FALSE {}
| LPAREN expression RPAREN {}
;

%%


// define fox_parser::error to avoid link error.
void fox::parser::fox_parser::error(const location &loc , const std::string &message) {
  std::cerr << loc <<  ": " << "Error: " <<  message << std::endl;
}
