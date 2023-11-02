
// Setar os bits do LCD
sbit LCD_RS at RB0_bit;
sbit LCD_EN at RB2_bit;
sbit LCD_D4 at RB3_bit;
sbit LCD_D5 at RB4_bit;
sbit LCD_D6 at RB5_bit;
sbit LCD_D7 at RB7_bit;
// Setar o controle de fluxo dos bits do LCD
sbit LCD_RS_Direction at TRISB0_bit;
sbit LCD_EN_Direction at TRISB2_bit;
sbit LCD_D4_Direction at TRISB3_bit;
sbit LCD_D5_Direction at TRISB4_bit;
sbit LCD_D6_Direction at TRISB5_bit;
sbit LCD_D7_Direction at TRISB7_bit;

// Setar o bit do LED indicador
sbit LED at RB1_bit;

// Vari�vel de controle da contagem de tempo
unsigned int reps;

// Vari�veis com o valor da frequ�ncia
unsigned int valHi, valLo, intFreq;
unsigned char * strFreq[7];


void main() {
     // Configura o PIC assim como o do projeto anterior
     PCON = 0b00001011;
     TRISB = 0b01000000;
     INTCON = 0b11000000;
     PIE1 = 0b00000010;
     CMCON = 0b00000111;
     T1CON = 0b00000011;
     
     // ...exceto o Timer2, agora ele tem uma frequ�ncia diferente
     T2CON = 0b01111111;

     // Liga o LCD com a configura��o padr�o
     Lcd_Init();
}

void interrupt() {
     valHi = TMR1H;
     valLo = TMR1L;

     if (reps) reps--;        // Se reps != 0, tira 1 dela
     else {                           // sen�o, pega a amostra e reinicia
          TMR1ON_bit = 0;        // Para a contagem do Timer1
          LED = !LED;            // Altera o LED, para mostrar o tempo da contagem
          
          intFreq = valHi*256 + valLo; // Calcula o valor inteiro da frequ�ncia
          
          Lcd_Out(0,3,"FREQUENCIA:");// Escreve as palavras constantes no LCD
          Lcd_Out(2,10,"Hz");
          
          IntToStr(intFreq,strFreq);       // Transforma o valor do Timer1 em String
          Lcd_Out(2,3,strFreq);           // Escreve a frequ�ncia no display

          TMR1H = 0;        // Reinicia o contador do Timer1
          TMR1L = 0;
          
          reps = 15;        // Reinicia o n�mero de repeti��es da interrup��o
          TMR1ON_bit = 1;  // Volta a conatgem do Timer1
     }

     TMR2IF_bit = 0;  // Abaixa a flag da interrup��o
     TMR2 = 190;     // Carrega o preset do Timer2
}