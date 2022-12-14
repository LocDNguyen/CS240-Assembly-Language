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
using namespace std;

extern "C" void Display(double array[], long array_size);

void Display(double array[], long array_size)
{
  for (int i = 0; i < array_size; i++)
  {
    printf("%.10lf\n", array[i]);
  }
}
