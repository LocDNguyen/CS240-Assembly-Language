#!/bin/bash

#=====================================================================================================================================
#  Name: Loc Nguyen
#  Email: locdacnguyen0@gmail.com
#	This course number, namely “CPSC240-1”.
#	The words: “Final Program Test”.
#======================================================================================================================================

rm *.o
rm *.lis
rm *.out


echo "Assembling the module supervisor.asm"
nasm -f elf64 -l supervisor.lis -o supervisor.o supervisor.asm

echo "Assembling the module random_fill_array.asm"
nasm -f elf64 -l random_fill_array.lis -o random_fill_array.o random_fill_array.asm

echo "Assembling the module hsum.asm"
nasm -f elf64 -l hsum.lis -o hsum.o hsum.asm

echo "Compiling display_array.c"
gcc -c -m64 -Wall -o display_array.o display_array.c -fno-pie -no-pie -std=c17

echo "Compiling driver.cpp"
g++ -c -m64 -Wall -o driver.o driver.cpp -fno-pie -no-pie -std=c++17

echo "Linking object files already created"
g++ -m64 -std=c++17 -fno-pie -no-pie -o harmonic.out driver.o supervisor.o random_fill_array.o display_array.o hsum.o

echo "Running the program"
./harmonic.out

echo "Bash script file is now closing."
