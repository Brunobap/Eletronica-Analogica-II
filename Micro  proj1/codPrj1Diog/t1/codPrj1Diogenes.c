
// Setar a sa�da do led
sbit LED at RD2_bit;

// Setar os pinos do lcd
// Lcd pinout settings
/*sbit LCD_RS at RB5_bit;
sbit LCD_EN at RB4_bit;
sbit LCD_D7 at RB3_bit;
sbit LCD_D6 at RB2_bit;
sbit LCD_D5 at RB1_bit;
sbit LCD_D4 at RB0_bit;

// Pin direction
sbit LCD_RS_Direction at TRISB.B5;
sbit LCD_EN_Direction at TRISB.B4;
sbit LCD_D7_Direction at TRISB.B3;
sbit LCD_D6_Direction at TRISB.B2;
sbit LCD_D5_Direction at TRISB.B1;
sbit LCD_D4_Direction at TRISB.B0;  */

#include <stdio.h>
#define _XTAL_FREQ 8000000
float tempAtual, tempIdeal;

/*void leituraAD() {
     // Passo 1:
     ADCON0.ADON = 1;
     // Passo 2:
     PIR1.ADIF = 0;
     PIE1.ADIE = 1;
     // Passo 3:
     Delay_ms(1000);
     // Passo 4:
     ADCON0.GO_DONE = 1;
     // Passo 5:
     while (ADCON0.GO_DONE!=0);
     while (PIR1.ADIF!=1) ;
     // Passo 6:
     tempAtual = ADRES;
} */

void main() {
    //tempIdeal = .725;
    
     // Configurar o LCD
    //Lcd_Init();
    //Lcd_Chr_CP('a');

    // Configurar as interrup��es (somente a de timer1)
    //INTCON  = 0b11000000;
    //INTCON2 = 0b10110000;
    
    // Congura TMR1 para contar em 1s
    /*T1CON.TMR1ON = 0;   // Desliga o Timer1 durante a configura��o
    T1CON.T1CKPS1 = 1;  // Define o pr�-escalonamento 1:8
    T1CON.T1CKPS0 = 1;  // (Isso define o pr�-escalonamento como 8)
    TMR1H = 0x3C;       // Valor inicial alto (MSB) do contador (65536-15624)
    TMR1L = 0x24;       // Valor inicial baixo (LSB) do contador (65536-15624)
    T1CON.TMR1ON = 1;   // Liga o Timer1*/
    
     // Configurar o conversor
     //ADCON1 = 0x0F;
     //ADCON0 = 0x00;
     //ADCON2 = 0b10010000;
     //leituraAD();

    
    // main vai ficar lendo a temperatura
    //while(1){
       //Delay_ms(150);
       //leituraAD();
    //}
}