
// Vari�veis sobre temperatura
unsigned int tempAtual;
// Vari�veis para controle
short contagem;
unsigned char * strTemp[7], strIni;

// (termostato)| (conv. A/D)
// Temperatura | Convertido
// 72�C        | 150
// 75�C        | 152

void main() {
     // Config de entradas e sa�das
     TRISA = 0x01;
     TRISB = 0x00;
     TRISC = 0x00;
     TRISD = 0x00;
     RBPU_bit = 0;

     // Inicia os m�dulos de conversor, lcd e pwm
     ADC_Init();
     PWM1_Init(2500);
     PWM1_Start();

     // Configura��es de interrup��o
     IPEN_bit = 0;  // Sem prioridades
     RBPU_bit = 0;  // Pull-ups de RB ligados
     GIE_bit = 1;   // Chave geral das interrup��es ligada
     PEIE_bit = 1;  // Chave das interrup��es de perif�ricos ligada
     TMR1IE_bit = 1;// Interrup��o de Timer1 ligada
     
     I2C1_Init(100000);         // initialize I2C communication
      I2C1_Start();              // issue I2C start signal
      I2C1_Wr(0x02);             // send byte via I2C  (device address + W)
      I2C1_Wr(2);                // send byte (address of EEPROM location)
      I2C1_Wr(0x0A);             // send data (data to be written)
      I2C1_Stop();               // issue I2C stop signal

    /*  Delay_100ms();

      I2C1_Start();              // issue I2C start signal
      I2C1_Wr(0x02);             // send byte via I2C  (device address + W)
      I2C1_Wr(2);                // send byte (data address)
      I2C1_Repeated_Start();     // issue I2C signal repeated start
      I2C1_Wr(0x03);             // send byte (device address + R)
      PORTB = I2C1_Rd(0u);       // Read the data (NO acknowledge)   */
      //I2C1_Stop();
     // Timer1 est� com todas as configura��es padr�es (T1CON zerado)
     TMR1IF_bit = 1;
}

void interrupt(){
      TMR1ON_bit = 0;    // Para o Timer1
      TMR1IF_bit = 0;    // Abaixa a flag do Timer1

      // Se n�o contou x segundos, n�o faz nada
      if (contagem) contagem--;
      // Se j� contou x segundos, pega a temperatura do forno e atualiza o estado
      else {
        contagem = 100;         // Reinicia a contagem
        ADC_Read(0);
        tempAtual = ADRES/2.025; // Pega a temperatura do forno
        IntToStr(tempAtual, strTemp);

        // Temperatura abaixo do ideal, liga o forno 100%
        if (tempAtual < 72) PWM1_Set_Duty(255);
        // Temperatura est� em uma margem est�vel, reduz o forno para 50%
        else if (tempAtual < 75) PWM1_Set_Duty(127);
        // Temperatura passou de uma margem segura, reduz o forno para 25%
        else if (tempAtual < 80) PWM1_Set_Duty(64);
        // Temperatura muito alta, desliga por completo
        else PWM1_Set_Duty(0);

        //I2C_Start();
        //I2C_Write("T. atual:");
        //I2C_Write(strTemp);
        //I2C1_Stop();
      }
      
      // Reinicia o Timer1
      TMR1H = 0;
      TMR1L = 0;
      TMR1ON_bit = 1;    // Volta o Timer1
}