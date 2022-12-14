//=====================================================================================================================================
//  Name: Loc Nguyen
//  Email: locdacnguyen0@gmail.com
//	This course number, namely “CPSC240-1”.
//	The words: “Final Program Test”.
//======================================================================================================================================


#include <stdio.h>
#include <iostream>
#include <math.h>

using namespace std;

extern "C" double supervisor();

int main(int argc, char *argv[])
{
    printf("\n");
    printf("Welcome to Harmonic Mean by Loc Nguyen.\n\n");
    printf("This program will compute the harmonic mean of your numbers.\n\n");

    double harmonic;
    harmonic = supervisor();

    printf("The main function received this number %0.9f and will keep it for awhile.\n\n", harmonic);

    printf("Enjoy your winter break.\n\n");
}
