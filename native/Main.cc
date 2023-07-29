#include "NativeStuff.h"
#include "NativeStuff.cc"
#include "string.h"
#include <stdexcept>

int main()
{
    const char* name = "Interop";
    char* greeting = say_hello((char*) name);
    const char* expected = "Hello Interop!";
    if (strcmp((char*) expected, (char*) greeting) != 0) {
       throw std::runtime_error("Program returned incorrect greeting!");
    }
    return 0;
}