// ***************************************************************************************************************************
// Program name: "Getting Hypotenuse". This program takes the input of strings as well as displays those strings after the   *
// exit of the program. The program also takes two float numbers from the standard input device and performs some arithmetic *
// in order to oouput to the user the hypotenuse of the two float numbers. If an invalid float input is inputted, the program*
// will continue to ask for valid float inputs until two are given.  Copyright (C) 2022 Loc Nguyen.                          *
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
//   Program name: Getting Hypotenuse
//   Programming languages: One module in C and one module in X86
//   Date program began: 2022-Sep-7
//   Date of last update: 2022-Sep-19
//   Date of reorganization of comments: 2022-Sep-19
//   Files in this program: driver.c, triangle.asm, run.sh
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

extern double start();

int main(int argc, char* argv[])
{
  double smaller = -99.99;
  printf("Welcome to Right Triangles program maintained by Loc Nguyen.\n\n");
  printf("If errors are discovered please report them to Loc Nguyen at"
         " lnguy121@csu.fullerton.edu for a quick fix."
         " At Columbia Software the customer comes first.\n\n");
  smaller = start();

  printf("The main function received this number %.4lf and plans to keep it.\n\n", smaller);
  printf("An integer zero will be returned to the operating system. Bye.\n");
  return 0;
}
