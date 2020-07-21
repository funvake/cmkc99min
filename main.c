/*!@file  main.c
*  @brief Minimal C99 & CMake Example
*
*  The macros `PRJ_UNAME`, `PRJ_DESC` and `PRJ_VERSION` are created in
*  `CMakeLists.txt` and passed on the compiler command line. Static
*  analysis tools will not know that, and may complain about them.
*/
#include "main.h"

int main (int argc, char* argv[]) {
   printf("%s: %s -v%s\n", PRJ_UNAME, PRJ_DESC, PRJ_VERSION);
   printf("Invocation: %s\n", argv[0]);
   for (int i = 1; i < argc; ++i)
      printf("Argument %d: %s\n", i, argv[i]);
   printf("Build type: %s\n", BUILD_TYPE);
   }
