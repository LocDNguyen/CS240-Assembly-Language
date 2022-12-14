// ***************************************************************************************************************************
// Program name: "Adding Integers Array". This program takes a string input as well as a sequence of integer inputs.         *
// The program then displays the integer inputs that were put in an array as well as sums all the integers. The program then *
// returns the string input and exits. Copyright (C) 2022 Loc Nguyen.                                                        *
//                                                                                                                           *
// This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License *
// version 3 as published by the Free Software Foundation.                                                                   *
// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied        *
// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.    *
// A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                           *
// ***************************************************************************************************************************
//
//
// ========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3
//
// Author information
//   Author name: Loc Nguyen
//   Author email: lnguy121@csu.fullerton.edu
//
// Program information
//   Program name: Adding Integers Array
//   Programming languages: One module in C, two modules in C++, 4 modules in X86, and one module in bash
//   Date program began: 2022-Sep-28
//   Date of last update: 2022-Oct-9
//   Date of reorganization of comments: 2022-Oct-9
//   Files in this program: driver.c, display_array.cpp, isInteger.cpp, manager.asm, input_array.asm, sum.asm, atol.asm, run.sh
//   Status: Finished. The program was tested extensively with no errors in Fedora 36.
//
// This file
//    File name: driver.c
//    Language: C
//    Max page width: 133 columns
//    Assemble: g++ -c -m64 -Wall -o driver.o driver.c -fno-pie -no-pie -std=c++17
//
// ========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3



#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <sys/time.h>
#include <stdlib.h>

extern char* start(void);

int main(void)
{
  printf("Welcome to Arrays of Integers"
         " Brought to you by Loc Nguyen\n\n");
  char* name = start();

  printf("I hoped you liked your arrays %s. \n", name);
  printf("Main will return 0 to the operating system. Bye.\n");
  return 0;
}
