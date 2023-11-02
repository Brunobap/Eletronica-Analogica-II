#line 1 "E:/Laboratorio/--Gits--/Eletronica-Analogica-II/Proj8 - Frequencimetro de precisao/codProj8/main.c"
#line 1 "e:/program files/mikroelektronika/mikroc pro for pic/include/math.h"





double fabs(double d);
double floor(double x);
double ceil(double x);
double frexp(double value, int * eptr);
double ldexp(double value, int newexp);
double modf(double val, double * iptr);
double sqrt(double x);
double atan(double f);
double asin(double x);
double acos(double x);
double atan2(double y,double x);
double sin(double f);
double cos(double f);
double tan(double x);
double exp(double x);
double log(double x);
double log10(double x);
double pow(double x, double y);
double sinh(double x);
double cosh(double x);
double tanh(double x);
#line 5 "E:/Laboratorio/--Gits--/Eletronica-Analogica-II/Proj8 - Frequencimetro de precisao/codProj8/main.c"
sbit LCD_RS at RB0_bit;
sbit LCD_EN at RB2_bit;
sbit LCD_D4 at RB3_bit;
sbit LCD_D5 at RB4_bit;
sbit LCD_D6 at RB5_bit;
sbit LCD_D7 at RB7_bit;

sbit LCD_RS_Direction at TRISB0_bit;
sbit LCD_EN_Direction at TRISB2_bit;
sbit LCD_D4_Direction at TRISB3_bit;
sbit LCD_D5_Direction at TRISB4_bit;
sbit LCD_D6_Direction at TRISB5_bit;
sbit LCD_D7_Direction at TRISB7_bit;


sbit LED at RB1_bit;


unsigned int reps;


unsigned int valHi, valLo, intFreq;
unsigned char * strFreq[7];


void main() {

 PCON = 0b00001011;
 TRISB = 0b01000000;
 INTCON = 0b11000000;
 PIE1 = 0b00000010;
 CMCON = 0b00000111;
 T1CON = 0b00000011;


 T2CON = 0b01111111;


 Lcd_Init();
}

void interrupt() {
 valHi = TMR1H;
 valLo = TMR1L;

 if (reps) reps--;
 else {
 TMR1ON_bit = 0;
 LED = !LED;

 intFreq = valHi*256+valLo;

 Lcd_Out(0,3,"FREQUENCIA:");
 Lcd_Out(2,10,"Hz");

 IntToStr(intFreq,strFreq);
 Lcd_Out(2,3,strFreq);

 TMR1H = 0;
 TMR1L = 0;

 reps = 15;
 TMR1ON_bit = 1;
 }

 TMR2IF_bit = 0;
 TMR2 = 190;
}
