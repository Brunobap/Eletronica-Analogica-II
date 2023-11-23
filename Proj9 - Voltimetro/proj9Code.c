
// Lcd pinout settings
sbit LCD_RS at RD0_bit;
sbit LCD_EN at RD1_bit;
sbit LCD_D7 at RD7_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D4 at RD4_bit;

// Pin direction
sbit LCD_RS_Direction at TRISD.B0;
sbit LCD_EN_Direction at TRISD.B1;
sbit LCD_D7_Direction at TRISD.B7;
sbit LCD_D6_Direction at TRISD.B6;
sbit LCD_D5_Direction at TRISD.B5;
sbit LCD_D4_Direction at TRISD.B4;

unsigned int ADHigh, ADLow;
float numTensao;
unsigned long ADComp;
unsigned char* saida[7];

void ADRead() {
     Delay_us(4);
     GO_DONE_bit = 1;
     Delay_us(4);
     ADLow = ADRESL;
     ADHigh = ADRESH;
}

void main() {
     // Inicia o LCD com a configura��o acima e desliga o cursor
     Lcd_Init();
     Lcd_Cmd(_LCD_CURSOR_OFF);

     // Configurar o m�dulo AD
     ADCON1 = 0b00001110;
     ADCON0 = 0b00000000;
     ADCON2 = 0b10010100;
     ADON_bit = 1;        // Liga o m�dulo de convers�o
     
     while (1) {
           ADRead();      // Chama a fun��o de leitura AD
           ADComp = ADLow + 256*ADHigh;     // Calcula o n�mero inteiro lido da convers�o
           numTensao = ADComp/204.6667;     // Converte para a tens�o real com a propor��o
           FloatToStr_FixLen(numTensao, saida, 6); // Transforma o n�mero em real em texto para sa�da

           // Escreve os textos na tela do LCD
           Lcd_Out(0,5,"TENSAO");
           Lcd_Out(2,4,saida);
           Lcd_Out(2,9," Volts");

           // Controla o PWM do LED
           PORTB = 0xFF;
           Delay_ms(500);
           PORTB = 0x00;
           Delay_ms(500);
     }
}