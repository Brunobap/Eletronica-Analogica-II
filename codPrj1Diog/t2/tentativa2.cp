#line 1 "D:/Programacao/Eletronica-Analogica-II/codPrj1Diog/t2/tentativa2.c"


sbit LED at RD2_bit;


sbit LCD_RS at RC0_bit;
sbit LCD_EN at RC1_bit;
sbit LCD_D7 at RC6_bit;
sbit LCD_D6 at RC5_bit;
sbit LCD_D5 at RC4_bit;
sbit LCD_D4 at RC2_bit;


sbit LCD_RS_Direction at TRISC.B0;
sbit LCD_EN_Direction at TRISC.B1;
sbit LCD_D7_Direction at TRISC.B6;
sbit LCD_D6_Direction at TRISC.B5;
sbit LCD_D5_Direction at TRISC.B4;
sbit LCD_D4_Direction at TRISC.B2;


unsigned int tempAtual;

short contagem;
unsigned char * strTemp[7], strIni;






void main() {
 strIni = "Temp atual:";


 TRISA = 0x01;
 TRISB = 0x03;
 TRISD = 0x00;


 ADC_Init();
 Lcd_Init();


 IPEN_bit = 0;
 RBPU_bit = 0;
 GIE_bit = 1;
 PEIE_bit = 1;
 TMR1IE_bit = 1;


 TMR1IF_bit = 1;
}

void interrupt(){
 TMR1ON_bit = 0;
 TMR1IF_bit = 0;


 if (contagem) contagem--;

 else {
 contagem = 100;
 ADC_Read(0);
 tempAtual = ADRES/2.025;
 IntToStr(tempAtual, strTemp);


 if (tempAtual < 72) LED = 1;

 else if (tempAtual > 75) LED = 0;

 Lcd_Out(0,1,"T. atual:");
 Lcd_Out(0,10, strTemp);

 if (LED) Lcd_Out(2,1,"Ligado   ");
 else Lcd_Out(2,1,"Desligado");
 }


 TMR1H = 0;
 TMR1L = 0;
 TMR1ON_bit = 1;
}
