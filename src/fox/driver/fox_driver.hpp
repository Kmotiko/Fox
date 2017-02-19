#ifndef FOX_DRIVER_HPP
#define FOX_DRIVER_HPP


#include<string>
#include<map>
#include "src/fox/lexer/fox_lexer.hpp"
#include "src/fox/parser/fox_parser.hpp"

namespace fox{
namespace driver{

class fox_driver{
  public:
    fox_driver(){}
    virtual ~fox_driver(){}

    int compile (const std::string &f);
  private:
};

}
}

#endif // FOX_DRIVER_HPP
