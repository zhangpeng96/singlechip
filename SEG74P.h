#include "stlo.h"

// Define pins
sbit P_SEG74P_1 = P1^0;
sbit P_SEG74P_2 = P1^1;
sbit P_SEG74P_3 = P1^2;
sbit P_SEG74P_4 = P1^3;
sfr P_SEG74P    = 0x80;

// Define segment table (0 ~ F)
unsigned char _SEG74P_table[] = {0xc0, 0xf9, 0xa4, 0xb0, 0x99, 0x92, 0x82,
     0xf8, 0x80, 0x90, 0x88, 0x83, 0xc6, 0xa1, 0x86, 0x8e };
// Function declaration
void _SEG74P_display (unsigned int number[], unsigned int refresh_time);
unsigned int _SEG74P_bitcount (unsigned int time, unsigned int i);


void _SEG74P_display (unsigned int number[], unsigned int refresh_time) {

    P_SEG74P_1 = 0;
    // Enable segment map pin
    P_SEG74P  = _SEG74P_table[number[0]];
    delay (refresh_time / 4);
    P_SEG74P = 0xff;
    P_SEG74P_1 = 1;

    P_SEG74P_2 = 0;
    P_SEG74P = _SEG74P_table[number[1]];
    delay (refresh_time / 4);
    P_SEG74P = 0xff;
    P_SEG74P_2 = 1;

    P_SEG74P_3 = 0;
    P_SEG74P = _SEG74P_table[number[2]];
    delay (refresh_time / 4);
    P_SEG74P = 0xff;
    P_SEG74P_3 = 1;

    P_SEG74P_4 = 0;
    P_SEG74P = _SEG74P_table[number[3]];
    delay (refresh_time / 4);
    P_SEG74P = 0xff;
    P_SEG74P_4 = 1;
}
