// ***************************************************************************************************************************
// Program name: "Sort". This program sorts an array given the array and its capacity.                                       *
// Copyright (C) 2022 Diamondburned.                                                                                            *
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
//   Author name: Diamondburned
//   Author email:
//
// Function information
//   Function name: Sort
//   Programming language: C
//
// Assemble: gcc -c -m64 -Wall -o sort.o sort.c -fno-pie -no-pie -std=c17
//
// Date development began: N/A
// Date comments restructured: N/A
//
// ========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3


#include <stdlib.h>

int _qsort_double(const void *aptr, const void *bptr) {
  float a = *(float *)aptr;
  float b = *(float *)bptr;
  if (a < b)
    return -1;
  if (a > b)
    return 1;
  return 0;
}

void fsort(float *farray, size_t arraylen) {
  qsort(farray, arraylen, sizeof(float), _qsort_double);
}
