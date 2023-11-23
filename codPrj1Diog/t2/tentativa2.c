
// Setar pino do LED/forno
sbit LED at RD2_bit;

// Lcd pinout settings
sbit LCD_RS at RC0_bit;
sbit LCD_EN at RC1_bit;
sbit LCD_D7 at RC6_bit;
sbit LCD_D6 at RC5_bit;
sbit LCD_D5 at RC4_bit;
sbit LCD_D4 at RC2_bit;

// Pin direction
sbit LCD_RS_Direction at TRISC.B0;
sbit LCD_EN_Direction at TRISC.B1;
sbit LCD_D7_Direction at TRISC.B6;
sbit LCD_D6_Direction at TRISC.B5;
sbit LCD_D5_Direction at TRISC.B4;
sbit LCD_D4_Direction at TRISC.B2;

// Variáveis sobre temperatura
unsigned int tempAtual;
// Variáveis para controle
short contagem;
unsigned char * strTemp[7], strIni;

// (termostato)| (conv. A/D)
// Temperatura | Convertido
// 72°C        | 150
// 75°C        | 152

void main() {
     strIni = "Temp atual:";
     
     // Config de entradas e saídas
     TRISA = 0x01;
     TRISB = 0x03;
     TRISD = 0x00;

     // Inicia o conversor e  lcd
     ADC_Init();
     Lcd_Init();

     // Configurações de interrupção
     IPEN_bit = 0;  // Sem prioridades
     RBPU_bit = 0;  // Pull-ups de RB ligados
     GIE_bit = 1;   // Chave geral das interrupções ligada
     PEIE_bit = 1;  // Chave das interrupções de periféricos ligada
     TMR1IE_bit = 1;// Interrupção de Timer1 ligada
     
     // Timer1 está com todas as configurações padrões (T1CON zerado)
     TMR1IF_bit = 1;
}

void interrupt(){
      TMR1ON_bit = 0;    // Para o Timer1
      TMR1IF_bit = 0;    // Abaixa a flag do Timer1

      // Se não contou x segundos, não faz nada
      if (contagem) contagem--;
      // Se já contou x segundos, pega a temperatura do forno e atualiza o estado
      else {
        contagem = 100;         // Reinicia a contagem
        ADC_Read(0);
        tempAtual = ADRES/2.025; // Pega a temperatura do forno
        IntToStr(tempAtual, strTemp);

        // Temperatura abaixo do ideal, liga o forno
        if (tempAtual < 72) LED = 1;
        // Temperatura já passou de uma margem estável, pode desligar o forno
        else if (tempAtual > 75) LED = 0;

        Lcd_Out(0,1,"T. atual:");
        Lcd_Out(0,10, strTemp);
        
        if (LED) Lcd_Out(2,1,"Ligado   ");
        else Lcd_Out(2,1,"Desligado");
      }
      
      // Reinicia o Timer1
      TMR1H = 0;
      TMR1L = 0;
      TMR1ON_bit = 1;    // Volta o Timer1
}