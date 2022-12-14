#!/bin/bash

# ***************************************************************************************************************************
# Program name: "Getting Hypotenuse". This program takes the input of strings as well as displays those strings after the   *
# exit of the program. The program also takes two float numbers from the standard input device and performs some arithmetic *
# in order to oouput to the user the hypotenuse of the two float numbers. If an invalid float input is inputted, the program*
# will continue to ask for valid float inputs until two are given.  Copyright (C) 2022 Loc Nguyen.                          *
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
#     The bash file used to put together the main file triangle.asm
#     with the driver file driver.c.
#     Type "sh run.sh" into the terminal without the quotations to run
#
# ========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3
rm *.o
rm *.lis
rm *.out

echo "Assembling the module triangle.asm"
nasm -f elf64 -l triangle.lis -o triangle.o triangle.asm

echo "Compiling driver.c"
gcc -c -m64 -Wall -o driver.o driver.c -fno-pie -no-pie -std=c17

echo "Linking the two object files already created"
gcc -m64 -std=c17 -fno-pie -no-pie -o hypotenuse.out driver.o triangle.o

echo "Running the program"
./hypotenuse.out

echo "Bash script file is now closing."
