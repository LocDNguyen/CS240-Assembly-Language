// ========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3
//
// Author information
//   Author name: Loc Nguyen
//   Author email: lnguy121@csu.fullerton.edu
//   Date: October 12, 2022
//   Section ID: Section MW 12-2pm
//
// ========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3



#include <stdio.h>
#include <cctype>
using namespace std;

extern "C" char* start();

int main()
{
  printf("Welcome to Maximum"
         " authored by Loc Nguyen\n\n");
  char* name = start();

  printf("Thank you for using this software, %s.\n", name);
  printf("Bye.\n");
  printf("A zero was returned to the operating system.\n");
  return 0;
}
