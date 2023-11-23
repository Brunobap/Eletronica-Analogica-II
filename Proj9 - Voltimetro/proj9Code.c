
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
     ADON_bit = 1;
     GO_DONE_bit = 1;
     Delay_us(4);
     ADLow = ADRESL;
     ADHigh = ADRESH;
}

void main() {
     Lcd_Init();
     Lcd_Cmd(_LCD_CURSOR_OFF);

     // Configurar o módulo CCP2 para o PWM
     /*PWM2_Init(1);
     PWM2_Set_Duty(128);
     PWM2_Start();    */
     CCP2CON = 0b00001111;
     T2CON =
     
     // Passo 1: Configurar o módulo AD
     ADCON1 = 0b00001110;
     ADCON0 = 0b00000000;
     ADCON2 = 0b10010100;
     
     while (1) {
           Delay_ms(500);
           ADRead();
           ADComp = ADLow + 256*ADHigh;
           numTensao = ADComp/204.6667;
           FloatToStr_FixLen(numTensao, saida, 6);
           Lcd_Out(0,5,"TENSAO");
           Lcd_Out(2,4,saida);
           Lcd_Out(2,9," Volts");
     }
}