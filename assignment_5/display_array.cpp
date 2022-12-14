//=====================================================================================================================================
//Program Name: Array Sort
//Programming Language: C++
//File Description: This takes in the array defined in manager.asm and current amount of items in array to print out each
//					integer in the array.
//General Purpose: This program asks the user to input integers into an array to get it sorted in ascending order. Display 
//				  this array before sort and after. 

//Author: Justin Bui
//Email: Justin_Bui12@csu.fullerton.edu
//Institution: California State University, Fullerton
//Course: CPSC 240-05
//Start Date: 25 October, 2020

//Copyright (C) 2020 Justin Bui
//This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License
//version 3 as published by the Free Software Foundation.
//This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
//Warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
//A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.
//======================================================================================================================================

#include<stdio.h>
using namespace std;

extern "C" void printArray(float array[], long amount);

void printArray(float array[], long amount){
	
	printf("\n");

	printf("Here are 10 numbers of the array at the beginning.\n");
	for (int i = 0; i < 10; ++i){
		printf("%1.9f\n", array[i]);
	}
	printf("\n\n");

	printf("Here are 10 numbers starting at the middle of the array.\n");
	if(amount < 20)
	{
		for (int i = 0; i < 10; ++i)
		{
			printf("%1.9f\n", array[i]);
		}
		printf("\n\n");
	}
	else
	{
		for (int i = amount/2; i < (amount/2)+10; ++i)
		{
			printf("%1.9f\n", array[i]);
		}
		printf("\n\n");
	}

	printf("Here are the last 10 numbers of the array.\n");
	if(amount < 10)
	{
		for (int i = 0; i < amount; ++i)
		{
			printf("%1.9f\n", array[i]);
		}
		printf("\n\n");
	}
	else
	{
		for (int i = amount-10; i < amount; ++i)
		{
			printf("%1.9f\n", array[i]);
		}
		printf("\n\n");
	}
}