#!/bin/bash

#****************************************************************************************************************************
# Program name: "Find cosine". This program takes a float input and converts it to it's radian counterpart as well as       *
# outputs the time in ticks. Then the program finds the cosine of the float input then displays the ticks again.            *
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
#     The bash file used to put together 6 other files.
#     Type "sh run.sh" into the terminal without the quotations to run
#
# ========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3


rm *.out, *.obj, *.o, *.lis

echo "Assemble itoa.asm"

nasm -f elf64 -o itoa.o -l itoa.lis itoa.asm

echo "Assemble atof.asm"

nasm -f elf64 -o atof.o -l atof.lis atof.asm

echo "Assemble ftoa.asm"

nasm -f elf64 -o ftoa.o -l ftoa.lis ftoa.asm

echo "Assemble cosine.asm"

nasm -f elf64 -o cosine.o -l cosine.lis cosine.asm

echo "Assemble strlen.asm"

nasm -f elf64 -o strlen.o -l strlen.lis strlen.asm

echo "Assemble X86 source code"

nasm -f elf64 -o find_cosine.o -l find_cosine.lis find_cosine.asm

echo "link the X86 assembled code"

ld  -o final.out find_cosine.o itoa.o strlen.o atof.o ftoa.o cosine.o

echo "Run the executable file"

./final.out

echo "The Bash script file says Good-bye".
