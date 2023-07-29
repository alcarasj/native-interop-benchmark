#include "NativeStuff.h"
#include <string.h>
#include <stdlib.h>

__attribute__((visibility("default"))) char * say_hello(char * name)
{
	const char* hello = "Hello ";
	const char* exclamationPoint = "!";
	size_t greetingLength = strlen(hello) + strlen(name) + strlen(exclamationPoint) + 1;
	char* greeting = (char *) malloc(greetingLength);
	strcpy(greeting, hello);
	strcat(greeting, name);
	strcat(greeting, exclamationPoint);
	return greeting;
}