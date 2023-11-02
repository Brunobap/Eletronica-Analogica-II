#line 1 "E:/Downloads/prj5/prj5.c"
#line 1 "e:/program files/mikroelektronika/mikroc pro for pic/include/stdbool.h"



 typedef char _Bool;
#line 7 "E:/Downloads/prj5/prj5.c"
unsigned int CONTADOR =  1 ;
unsigned int FILTRO =  230 ;
 _Bool  CONTROLE =  0 ;



sbit BTN_LED at PORTB.B0;
sbit OUT_LED at PORTB.B1;
sbit BTN_CNT at PORTB.B2;
sbit OUT_ONDA at PORTB.B7;


void main() {
 TRISA = 0x00;
 TRISB = 0x05;

 OPTION_REG = 0b00010001;
 INTCON = 0b10110000;

 PORTA = 0x00;
 PORTB = 0x00;


 while(1){
 PORTA = CONTADOR;
 FILTRO =  230 ;
 while (BTN_CNT == 0 && FILTRO > 0) {
 FILTRO--;
 }
 if (BTN_CNT == 0 && FILTRO == 0) {
 if (CONTROLE) {

 CONTADOR--;
 if (CONTADOR == 1) CONTROLE =  0 ;
 } else {

 CONTADOR++;
 if (CONTADOR == 9) CONTROLE =  1 ;
 }
 PORTA = CONTADOR;
 while (BTN_CNT == 0);
 }
 }
}

void interrupt() {
 if (INTCON.B2) {

 INTCON.B2 = 0;
 switch (CONTADOR) {
 case 1:
 TMR0 = 14;
 break;
 case 2:
 Delay_us(1);
 TMR0 = 141;
 break;
 case 3:
 TMR0 = 184;
 break;
 case 4:
 TMR0 = 207;
 break;
 case 5:
 TMR0 = 222;
 break;
 case 6:
 Delay_us(1);
 Delay_us(1);
 TMR0 = 233;
 break;
 case 7:
 Delay_us(1);
 TMR0 = 240;
 break;
 case 8:
 Delay_us(1);
 TMR0 = 247;
 break;

 default:
 Delay_us(1);
 TMR0 = 250;
 }
 OUT_ONDA = !OUT_ONDA;

 } else if (INTCON.B1) {

 INTCON.B1 = 0;
 OUT_LED = !OUT_LED;
 }
}
