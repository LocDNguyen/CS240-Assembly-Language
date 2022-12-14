#!/bin/bash

# ***************************************************************************************************************************
# Program name: "Sort Arrays". This program takes the input of an integer number and uses that as a basis for how many      *
# random float numbers should be created and passed in an array to be sorted.                                               *
# Copyright (C) 2022 Loc Nguyen.                                                                                            *
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
#     The bash file used to put together the main file manager.asm
#     with the driver file driver.cpp and another functions.
#     Type "sh run.sh" into the terminal without the quotations to run
#
# ========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3
rm *.o
rm *.lis
rm *.out


echo "Assembling the module manager.asm"
nasm -f elf64 -l manager.lis -o manager.o manager.asm

echo "Assembling the module getFrequency.asm"
nasm -f elf64 -l getFrequency.lis -o getFrequency.o getFrequency.asm

echo "Assembling the module fill_array.asm"
nasm -f elf64 -l fillarray.lis -o fillarray.o fillarray.asm

echo "Compiling display_array.cpp"
g++ -c -m64 -Wall -o display_array.o display_array.cpp -fno-pie -no-pie -std=c++17

echo "Compiling getClock.cpp"
g++ -c -m64 -Wall -o getClock.o getClock.cpp -fno-pie -no-pie -std=c++17

echo "Compiling driver.cpp"
g++ -c -m64 -Wall -o driver.o driver.cpp -fno-pie -no-pie -std=c++17

echo "Compiling sort.c"
gcc -c -m64 -Wall -o sort.o sort.c -fno-pie -no-pie -std=c17

echo "Linking object files already created"
g++ -m64 -std=c++17 -fno-pie -no-pie -o sortarray.out driver.o manager.o fillarray.o display_array.o sort.o getFrequency.o getClock.o

echo "Running the program"
./sortarray.out

echo "Bash script file is now closing."
