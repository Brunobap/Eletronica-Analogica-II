#line 1 "E:/Laboratorio/--Gits--/Eletronica-Analogica-II---Microcontroladores/Micro  proj2/codPrj1Diog/t2/tentativa2.c"


unsigned int tempAtual;

short contagem;
unsigned char * strTemp[7], strIni;






void main() {

 TRISA = 0x01;
 TRISB = 0x00;
 TRISC = 0x00;
 TRISD = 0x00;
 RBPU_bit = 0;


 ADC_Init();
 PWM1_Init(2500);
 PWM1_Start();


 IPEN_bit = 0;
 RBPU_bit = 0;
 GIE_bit = 1;
 PEIE_bit = 1;
 TMR1IE_bit = 1;

 I2C1_Init(100000);
 I2C1_Start();
 I2C1_Wr(0x02);
 I2C1_Wr(2);
 I2C1_Wr(0x0A);
 I2C1_Stop();
#line 50 "E:/Laboratorio/--Gits--/Eletronica-Analogica-II---Microcontroladores/Micro  proj2/codPrj1Diog/t2/tentativa2.c"
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


 if (tempAtual < 72) PWM1_Set_Duty(255);

 else if (tempAtual < 75) PWM1_Set_Duty(127);

 else if (tempAtual < 80) PWM1_Set_Duty(64);

 else PWM1_Set_Duty(0);





 }


 TMR1H = 0;
 TMR1L = 0;
 TMR1ON_bit = 1;
}
