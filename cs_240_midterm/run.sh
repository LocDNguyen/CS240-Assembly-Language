#!/bin/bash

# ========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3
#
# Author information
#   Author name: Loc Nguyen
#   Author email: lnguy121@csu.fullerton.edu
#   Date: October 12, 2022
#   Section ID: Section MW 12-2pm
#
# ========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3

rm *.o
rm *.lis
rm *.out

echo "Assembling the module manager.asm"
nasm -f elf64 -l manager.lis -o manager.o manager.asm

echo "Assembling the module get_data.asm"
nasm -f elf64 -l get_data.lis -o get_data.o get_data.asm

echo "Assembling the module max.asm"
nasm -f elf64 -l max.lis -o max.o max.asm


echo "Compiling show_data.cpp"
g++ -c -m64 -Wall -o show_data.o show_data.cpp -fno-pie -no-pie -std=c++17

echo "Compiling isfloat.cpp"
g++ -c -m64 -Wall -o isfloat.o isfloat.cpp -fno-pie -no-pie -std=c++17

echo "Compiling driver.cpp"
g++ -c -m64 -Wall -o driver.o driver.cpp -fno-pie -no-pie -std=c++17


echo "Linking the object files already created"
g++ -m64 -std=c17 -fno-pie -no-pie -o biggest.out driver.o show_data.o manager.o get_data.o max.o isfloat.o

echo "Running the program"
./biggest.out

echo "Bash script file is now closing."
