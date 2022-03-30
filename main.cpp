#include "world.hpp"
#include <iostream>

void f(int c)
{
  std::cout << "The integer number is :" << c << "\n";
}

void f(double c)
{
  std::cout << "The double number is :" << c << "\n";
}

int main(int argc, char** argv)
{
#ifdef FULLCOV
  f(g(2.43));
#endif
  f(3);
}
