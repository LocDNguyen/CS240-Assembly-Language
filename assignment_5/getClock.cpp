// ***************************************************************************************************************************
// Program name: "Get Date". This program returns the current date and time.                                                 *
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
// Function information
//   Function name: Get Date
//   Programming language: C++
//   Function prototype:  void getClock()
//   Reference: None
//   Input parameter: N/A
//   Output parameter: Date & Time
//
// Assemble: g++ -c -m64 -Wall -fno-pie -no-pie -o getClock.o getClock.cpp -std=c++17
//
// Date development began: 2018-Dec-12
// Date comments restructured: 2022-Dec-12
//
// ========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3


#include <iostream>
#include <time.h>
#include <ctime>

using namespace std;

extern "C" void getClock();

void getClock()
{
    time_t rawtime;
    time(&rawtime);
    tm* curr_tm;
    curr_tm = localtime(&rawtime);

    char date[100];

    strftime(date, 50, "%b %d, %Y at %I:%M%P.", curr_tm);
    cout << date << endl;
}
