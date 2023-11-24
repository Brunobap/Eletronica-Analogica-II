#line 1 "C:/Users/bruno/Desktop/Programacao/Gits/Eletronica-Analogica-II/Proj9 - Voltimetro/proj9Code.c"


sbit LCD_RS at RD0_bit;
sbit LCD_EN at RD1_bit;
sbit LCD_D7 at RD7_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D4 at RD4_bit;


sbit LCD_RS_Direction at TRISD.B0;
sbit LCD_EN_Direction at TRISD.B1;
sbit LCD_D7_Direction at TRISD.B7;
sbit LCD_D6_Direction at TRISD.B6;
sbit LCD_D5_Direction at TRISD.B5;
sbit LCD_D4_Direction at TRISD.B4;

unsigned int ADHigh, ADLow;
float numTensao;
unsigned long ADComp;
char saida[14];

sbit LED at PORTC.B1;

void ADRead() {
 Delay_us(4);
 GO_DONE_bit = 1;
 Delay_us(4);
}

void main() {

 Lcd_Init();
 Lcd_Cmd(_LCD_CURSOR_OFF);

 TRISC.B1 = 0;


 ADCON1 = 0b00001110;
 ADCON0 = 0b00000000;
 ADCON2 = 0b10010100;
 ADON_bit = 1;



 while (1) {
 ADRead();
 numTensao = ADRES*5.0/1023;
 sprintf(saida, "%.3f", numTensao);


 Lcd_Out(0,5,"TENSAO");
 Lcd_Out(2,4,saida);
 Lcd_Out(2,9," Volts");


 LED = 1;
 Delay_ms(500);
 LED = 0;
 Delay_ms(500);
 }
}
