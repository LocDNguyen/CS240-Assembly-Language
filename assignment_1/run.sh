#!/bin/bash

# ***************************************************************************************************************************
# Program name: "Comparing Floats". This program takes the input of multiple float numbers from the standard input device   *
# using a single instruction and the output of multiple float numbers to the standard output device also using a single     *
# instruction.  Copyright (C) 2022 Loc Nguyen.                                                                              *
#                                                                                                                           *
# This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License *
# version 3 as published by the Free Software Foundation.                                                                   *
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied        *
# warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.    *
# A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                           *
# ***************************************************************************************************************************
#
#
# ========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3
#
# Author information
#   Author name: Loc Nguyen
#   Author email: lnguy121@csu.fullerton.edu
#
#
# This file
#     The bash file used to put together the main file comparison.asm
#     with the driver file driver.cpp and another function isfloat.cpp.
#     Type "sh run.sh" into the terminal without the quotations to run
#
# ========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3
rm *.o
rm *.lis
rm *.out

echo "Assembling the module comparison.asm"
nasm -f elf64 -l comparison.lis -o comparison.o comparison.asm

echo "Compiling driver.cpp"
g++ -c -m64 -Wall -o driver.o driver.cpp -fno-pie -no-pie -std=c++17

echo "Compiling isfloat.cpp"
g++ -c -m64 -Wall -o isfloat.o isfloat.cpp -fno-pie -no-pie -std=c++17

echo "Linking the two object files already created"
g++ -m64 -std=c++17 -fno-pie -no-pie -o largerfloat.out driver.o comparison.o isfloat.o

echo "Running the program"
./largerfloat.out

echo "Bash script file is now closing."
