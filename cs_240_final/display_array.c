//=====================================================================================================================================
//  Name: Loc Nguyen
//  Email: locdacnguyen0@gmail.com
//	This course number, namely “CPSC240-1”.
//	The words: “Final Program Test”.
//======================================================================================================================================

#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <sys/time.h>
#include <stdlib.h>

extern void printArray(double array[], long amount);

void printArray(double array[], long amount){

	printf("\n");

	printf("Here are the values in the array:\n");
	for (int i = 0; i < amount; ++i){
		printf("%0.9f\n", array[i]);
	}
	printf("\n");
}
