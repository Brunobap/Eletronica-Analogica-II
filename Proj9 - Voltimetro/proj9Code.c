
// Marcar quais são os pinos do LCD
sbit LCD_RS at RD0_bit;
sbit LCD_EN at RD1_bit;
sbit LCD_D7 at RD7_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D4 at RD4_bit;

// Marcar quais são os bits que controlam o fluxo dos pinos do LCD
sbit LCD_RS_Direction at TRISD.B0;
sbit LCD_EN_Direction at TRISD.B1;
sbit LCD_D7_Direction at TRISD.B7;
sbit LCD_D6_Direction at TRISD.B6;
sbit LCD_D5_Direction at TRISD.B5;
sbit LCD_D4_Direction at TRISD.B4;

float numTensao;      // Número real da tensão vai aqui
unsigned long ADComp; //
char saida[14];

sbit LED at PORTC.B1;

// Função para ativar a leitura da conversão AD
void ADRead() {
     Delay_us(4);     // Espera um tempo de aquisição para estabilizar a leitura
     GO_DONE_bit = 1; // Liga o conversor para pegar uma medida
     Delay_us(4);     // Espera outro tempo de aquisição para estabilizar a leitura
}

void main() {
     // Inicia o LCD com a configuração acima e desliga o cursor
     Lcd_Init();
     Lcd_Cmd(_LCD_CURSOR_OFF);

     // Garante que o pino RC1 seja uma saída
     TRISC.B1 = 0;

     // Configurar o módulo AD
     ADCON1 = 0b00001110;
     ADCON0 = 0b00000000;
     ADCON2 = 0b10010100;
     ADON_bit = 1;        // Liga o módulo de conversão
     
     

     while (1) {
           ADRead();                          // Chama a função de leitura AD
           numTensao = ADRES*5.0/1023;        // Converte para a tensão real com a proporção
           sprintf(saida, "%.3f", numTensao); // Transforma o número em real em texto para saída

           // Escreve os textos na tela do LCD
           Lcd_Out(0,5,"TENSAO");
           Lcd_Out(2,4,saida);
           Lcd_Out(2,9," Volts");

           // Controla o LED
           LED = 1;
           Delay_ms(500);
           LED = 0;
           Delay_ms(500);
     }
}