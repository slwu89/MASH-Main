#ifndef PATCH_MACRO
#define PATCH_MACRO

#include <iostream>
#include <memory>
#include <vector>

class human;
using humanP = std::unique_ptr<human>;

class patch {

public:
  patch();
  ~patch();

private:

  std::vector<humanP>                  humans;
};

#endif
