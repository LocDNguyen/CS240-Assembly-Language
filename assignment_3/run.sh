#!/bin/bash

# ***************************************************************************************************************************
# Program name: "Adding Integers Array". This program takes a string input as well as a sequence of integer inputs.         *
# The program then displays the integer inputs that were put in an array as well as sums all the integers. The program then *
# returns the string input and exits. Copyright (C) 2022 Loc Nguyen.                                                        *
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
#     The bash file used to put together 7 other files.
#     Type "sh run.sh" into the terminal without the quotations to run
#
# ========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3

rm *.o
rm *.lis
rm *.out

echo "Assembling the module manager.asm"
nasm -f elf64 -l manager.lis -o manager.o manager.asm

echo "Assembling the module atol.asm"
nasm -f elf64 -l atol.lis -o atol.o atol.asm

echo "Assembling the module input_array.asm"
nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm

echo "Assembling the module sum.asm"
nasm -f elf64 -l sum.lis -o sum.o sum.asm


echo "Compiling display_array.cpp"
g++ -c -m64 -Wall -o display_array.o display_array.cpp -fno-pie -no-pie -std=c++17

echo "Compiling isInteger.cpp"
g++ -c -m64 -Wall -o isInteger.o isInteger.cpp -fno-pie -no-pie -std=c++17


echo "Compiling driver.c"
gcc -c -m64 -Wall -o driver.o driver.c -fno-pie -no-pie -std=c17


echo "Linking the object files already created"
gcc -m64 -std=c17 -fno-pie -no-pie -o array.out driver.o display_array.o isInteger.o manager.o atol.o input_array.o sum.o

echo "Running the program"
./array.out

echo "Bash script file is now closing."
