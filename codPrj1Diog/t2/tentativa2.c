
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

// Vari�veis sobre temperatura
unsigned int tempAtual, tempIdeal, tempMargem;
// Vari�veis para controle
short estado, contagem;
unsigned char * texto;

// (termostato)| (conv. A/D)
// Temperatura | Convertido
// 72�C        | 150
// 75�C        | 152
// 80�C        | 164
// 82�C        | 168

void main() {
     // Come�a desligando
     estado = 1;

     // Come�a com 72�C
     tempIdeal = 150;
     tempMargem = 152;
     
     // Config de entradas e sa�das
     TRISA = 0x01;
     TRISB = 0x03;
     TRISD = 0x00;

     // Inicia o conversor e  lcd
     ADC_Init();
     Lcd_Init();

     // Configura��es de interrup��o
     IPEN_bit = 0;  // Sem prioridades
     RBPU_bit = 0;  // Pull-ups de RB ligados
     GIE_bit = 1;   // Chave geral das interrup��es ligada
     PEIE_bit = 1;  // Chave das interrup��es de perif�ricos ligada
     TMR1IE_bit = 1;// Interrup��o de Timer1 ligada
     INT0IE_bit = 1;// Interrup��o de INT0 ligada
     INT1IE_bit = 1;// Interrup��o de INT1 ligada
     
     // Timer1 est� com todas as configura��es padr�es (T1CON zerado)

     // Toca todas as interrup��es uma 1� vez, para iniciar os valores no LCD
     TMR1IF_bit = 1;
     INT0IF_bit = 1;
     INT1IF_bit = 1;
}

void interrupt(){
     // Caso seja a verifica��o de estado
     if (TMR1IF_bit){
        TMR1ON_bit = 0;    // Para o Timer1
        TMR1IF_bit = 0;    // Abaixa a flag do Timer1

        // Se n�o contou x segundos, n�o faz nada
        if (contagem) contagem--;
        // Se j� contou x segundos, pega a temperatura do forno e atualiza o estado
        else {
          contagem = 100;         // Reinicia a contagem
          tempAtual = ADC_Get_Sample(0); // Pega a temperatura do forno
          // Temperatura abaixo do ideal, liga o forno
          if (tempAtual < tempIdeal) LED = 1;
          // Temperatura j� passou de uma margem est�vel, pode desligar o forno
          else if (tempAtual > tempMargem) LED = 0;
        }
        // Reinicia o Timer1
        TMR1H = 0;
        TMR1L = 0;
        TMR1ON_bit = 1;    // Para o Timer1
        
     // Caso seja o bot�o de liga/desliga
     } else if (INT0IF_bit){
       estado = -estado;    // Inverte o estado da m�quina
       if (estado > 0) Lcd_Out(2,1,"Ligado");
       else Lcd_Out(2,1,"Desligado");
       INT0IF_bit = 0;      // Abaixa a flag do INT0
     
     // Caso seja a troca de temperatura
     } else {
       // Caso esteja configurado para 72�C
       if (tempIdeal==150) {
          tempIdeal = 164; // Muda pra 80�C
          tempMargem = 168;// Muda pra 82�C
          Lcd_Out(2,11,"80oC");
          
       // Caso esteja configurado para 80�C
       } else {
          tempIdeal = 150; // Muda pra 80�C
          tempMargem = 152;// Muda pra 82�C
          Lcd_Out(2,11,"72oC");
       }
       
       INT1IF_bit = 0;      // Abaixa a flag do INT1
     }
}