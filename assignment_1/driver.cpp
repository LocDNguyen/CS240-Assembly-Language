// ***************************************************************************************************************************
// Program name: "Comparing Floats". This program takes the input of multiple float numbers from the standard input device   *
// using a single instruction and the output of multiple float numbers to the standard output device also using a single     *
// instruction.  Copyright (C) 2022 Loc Nguyen.                                                                              *
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
//   Program name: Comparing Floats
//   Programming languages: Two modules in C++ and one module in X86
//   Date program began: 2022-Aug-24
//   Date of last update: 2022-Sep-3
//   Date of reorganization of comments: 2022-Sep-3
//   Files in this program: driver.cpp, isfloat.cpp, comparison.asm, run.sh
//   Status: Finished. The program was tested extensively with no errors in Fedora 36.
//
// This file
//    File name: driver.cpp
//    Language: C++
//    Max page width: 133 columns
//    Assemble: g++ -c -m64 -Wall -o driver.o driver.cpp -fno-pie -no-pie -std=c++17
//
// ========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3



#include <stdio.h>
#include <cctype>
using namespace std;

extern "C" double start();

int main()
{
  double smaller = -99.99;
  printf("Welcome to Floating Points Numbers programmed by Loc Nguyen.\n");
  printf("Loc Nguyen has been working for the Longstreet Software Company for the last two years.\n\n");
  smaller = start();

  printf("The driver module received this float number %.13lf and will keep it.\n", smaller);
  printf("The driver module will return integer 0 to the operating system.\n");
  printf("Have a nice day. Good-bye.\n");
  return 0;
}
