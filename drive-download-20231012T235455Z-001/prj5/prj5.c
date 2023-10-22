#include <stdbool.h>

#define MIN 1
#define MAX 9
#define T_FILTRO 230

unsigned int CONTADOR = MIN;
unsigned int FILTRO = T_FILTRO;
bool CONTROLE = false;
// CONTROLE = false: somar
// CONTROLE = true: subtrair;

sbit BTN_LED at PORTB.B0;
sbit OUT_LED at PORTB.B1;
sbit BTN_CNT at PORTB.B2;
sbit OUT_ONDA at PORTB.B7;


void main() {
     TRISA = 0x00;        // Todas as portas de RA de s�o sa�das
     TRISB = 0x05;        // Somente as portas RB0 e RB2 s�o sa�das

     OPTION_REG = 0b00010001;
     INTCON = 0b10110000;
     
     PORTA = 0x00;
     PORTB = 0x00;

     // Rotina main: CONTADOR com display
     while(1){
          // Reinicia o FILTRO e mostra o valor no CONTADOR no display 7-seg
          PORTA = CONTADOR;
          FILTRO = T_FILTRO;
          
          // Verifica se o bot�o est� realmente sendo segurado
          while (BTN_CNT == 0 && FILTRO > 0) {
                FILTRO--;
          }

          // Caso segurado por tempo suficiente, muda o valor do CONTADOR
          if (BTN_CNT == 0 && FILTRO == 0) {
             if (CONTROLE) { // Verifica qual a dire��o que o display vai contar
             // Subtrair
                CONTADOR--;
                if (CONTADOR == 1) CONTROLE = false;
             } else {
             // Somar
                CONTADOR++;
                if (CONTADOR == 9) CONTROLE = true;
             }
             PORTA = CONTADOR;
             
             // N�o faz mais nada at� o bot�o ser solto novamente
             while (BTN_CNT == 0);
          }
     }
}

void interrupt() {
     // Verifica se a interrup��o veio do Timer0 (flag TMR0IF)
     if (INTCON.B2) {
        // Interrup��o da onda (Timer0)
        INTCON.B2 = 0;    // Abaixa a flag do Timer0
        switch (CONTADOR) {  // Analisa de quantos k's deve ser a frequ�ncia
               case 1:
                    TMR0 = 14;
                    break;
               case 2:
                    Delay_us(1); // Ajuste fino
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
                    Delay_us(1); // Delay's foram adicionados para o ajuste fino da frequ�ncia
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
               default:// "case 9"
                    Delay_us(1);
                    TMR0 = 250;
        }
        OUT_ONDA = !OUT_ONDA; // Inverte o n�vel da onda
     
     // Se a interrup��o n�o foi do Timer0, ent�o foi de RB (flag RBIF)
     } else {
       // Interrup��o do led (bot�o)
       INTCON.B1 = 0; // Abaixa a flag de interrup��o do bot�o
       OUT_LED = !OUT_LED; // Inverte o estado do Led
     }
}