#include "world.hpp"

int main(int argc, char** argv)
{
#ifdef ONECOV
  f(g(2.43));
#endif

#ifdef TWOCOV
  f(3);
#endif
}
