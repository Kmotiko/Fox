#include "src/fox/exception.hpp"
#include "src/fox/driver/fox_driver.hpp"


int main(int argc, char *argv[]){
  fox::driver::fox_driver driver;
  if(argc > 1)
    return driver.compile(std::string(argv[1]));
  else
    return 1;
}
