#line 1 "C:/Users/bruno/Desktop/Programacao/Gits/Eletronica-Analogica-II/Eletronica-Analogica-II/codPrj1Diog/codPrj1Diogenes.c"


sbit LED at RD2_bit;



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
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/include/stdio.h"
#line 28 "C:/Users/bruno/Desktop/Programacao/Gits/Eletronica-Analogica-II/Eletronica-Analogica-II/codPrj1Diog/codPrj1Diogenes.c"
float tempAtual, tempIdeal;

void leituraAD() {

 ADCON0.ADON = 1;

 PIR1.ADIF = 0;
 PIE1.ADIE = 1;

 Delay_ms(50);

 ADCON0.GO_DONE = 1;

 while (ADCON0.GO_DONE!=0);
 while (PIR1.ADIF!=1) ;

 tempAtual = ADRES;
}

void main() {
 int adc = 0, y = 1;

 tempIdeal = .725;


 Lcd_Init();



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



 while(1){
 Delay_ms(150);

 }
}

void interrupt_low(){
 if(INT1IF) {
 PIR1.B0 = 0;
 LED = !LED;



 T1CON.TMR1ON = 0;
 TMR1H = 0x3C;
 TMR1L = 0x24;
 T1CON.TMR1ON = 1;
 }
}
