#line 1 "E:/Downloads/codPrj1Diog/codPrj1Diogenes.c"



sbit LCD_RS at RB5_bit;
sbit LCD_EN at RB4_bit;
sbit LCD_D7 at RB3_bit;
sbit LCD_D6 at RB2_bit;
sbit LCD_D5 at RB1_bit;
sbit LCD_D4 at RB0_bit;


sbit LCD_RS_Direction at TRISB.B5;
sbit LCD_EN_Direction at TRISB.B4;
sbit LCD_D7_Direction at TRISB.B3;
sbit LCD_D6_Direction at TRISB.B2;
sbit LCD_D5_Direction at TRISB.B1;
sbit LCD_D4_Direction at TRISB.B0;
#line 1 "e:/program files/mikroelektronika/mikroc pro for pic/include/stdio.h"
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
#line 26 "E:/Downloads/codPrj1Diog/codPrj1Diogenes.c"
float Temp;

void leituraAD() {

 ADCON0.ADON = 1;

 PIR1.ADIF = 0;
 PIE1.ADIE = 1;

 Delay_ms(50);

 ADCON0.GO_DONE = 1;

 while (ADCON0.GO_DONE!=0);
 while (PIR1.ADIF!=1) ;

 Temp = ADRES;
}

void main() {
 int adc = 0, x = 128, y = 1;


 INTCON = 0b11000000;
 INTCON2 = 0b10110000;
 INTCON3 = 0b00000000;


 T1CON.TMR1ON = 0;
 T1CON.T1CKPS1 = 1;
 T1CON.T1CKPS0 = 1;
 TMR1H = 0x3C;
 TMR1L = 0x24;
 T1CON.TMR1ON = 1;


 ADCON1 = 0x0F;
 ADCON0 = 0b00000000;
 ADCON1 = 0b00000110;
 ADCON2 = 0b10010000;
 leituraAD();


 TRISA.B0 = 1;
 TRISB = 0;
 TRISB.B0 = 1;
 TRISB = 0b00000001;
 Lcd_Init();
 Lcd_Out_CP(0b00000001);
 Lcd_Out_CP(x);


 while(1){
 Delay_ms(150);
 leituraAD();
 }
}

void interrupt(){
 if(INT1IF) {
 PIR1.B0 = 0;
 T1CON.TMR1ON = 0;
 TMR1H = 0x3C;
 TMR1L = 0x24;
 T1CON.TMR1ON = 1;
 }
}
