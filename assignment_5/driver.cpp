// ***************************************************************************************************************************
// Program name: "Sort Arrays". This program takes the input of an integer number and uses that as a basis for how many      *
// random float numbers should be created and passed in an array to be sorted.                                               *
// Copyright (C) 2022 Loc Nguyen.                                                                                            *
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
//   Program name: Sort Arrays
//   Programming languages: Three modules in C++, one module in C, Three modules in x86, One module in bash
//   Date program began: 2022-Nov-30
//   Date of last update: 2022-Dec-12
//   Date of reorganization of comments: 2022-Dec-12
//   Files in this program: display_array.cpp, driver.cpp, fillarray.asm, getClock.cpp, getFrequency.asm, manager.asm, sort.c, run,sh
//   Status: Finished. The program was tested extensively with no errors in Fedora 36.
//
// This file
//    File name: driver.cpp
//    Language: C++
//    Max page width: 134 columns
//    Assemble: nasm -f elf64 -l manager.lis -o manager.o manager.asm
//
// ========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3


#include <stdio.h>
#include <iostream>
#include <math.h>

using namespace std;

extern "C" double manager();
extern "C" void getClock();

int main(int argc, char *argv[])
{
    printf("\n");
    printf("Welcome to Sort Arrays by Loc Nguyen.\n");
    printf("This program will measure the execution time of a sort function.\n\n");

    double benchmark;
    benchmark = manager();

    printf("The bench mark time will be returned to the driver.\n");
    printf("The main program received %0.6f\n\n", benchmark);

    printf("The time on the wall is now ");
    getClock();

    printf("\n");
    printf("Have a great rest of your day. Zero will be sent to the OS.\n");
    printf("See you next semester in 440. Bye\n\n");
}
