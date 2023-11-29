
_main:

;tentativa2.c,13 :: 		void main() {
;tentativa2.c,15 :: 		TRISA = 0x01;
	MOVLW       1
	MOVWF       TRISA+0 
;tentativa2.c,16 :: 		TRISB = 0x00;
	CLRF        TRISB+0 
;tentativa2.c,17 :: 		TRISC = 0x00;
	CLRF        TRISC+0 
;tentativa2.c,18 :: 		TRISD = 0x00;
	CLRF        TRISD+0 
;tentativa2.c,19 :: 		RBPU_bit = 0;
	BCF         RBPU_bit+0, BitPos(RBPU_bit+0) 
;tentativa2.c,22 :: 		ADC_Init();
	CALL        _ADC_Init+0, 0
;tentativa2.c,23 :: 		PWM1_Init(2500);
	BSF         T2CON+0, 0, 0
	BCF         T2CON+0, 1, 0
	MOVLW       99
	MOVWF       PR2+0, 0
	CALL        _PWM1_Init+0, 0
;tentativa2.c,24 :: 		PWM1_Start();
	CALL        _PWM1_Start+0, 0
;tentativa2.c,27 :: 		IPEN_bit = 0;  // Sem prioridades
	BCF         IPEN_bit+0, BitPos(IPEN_bit+0) 
;tentativa2.c,28 :: 		RBPU_bit = 0;  // Pull-ups de RB ligados
	BCF         RBPU_bit+0, BitPos(RBPU_bit+0) 
;tentativa2.c,29 :: 		GIE_bit = 1;   // Chave geral das interrupções ligada
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;tentativa2.c,30 :: 		PEIE_bit = 1;  // Chave das interrupções de periféricos ligada
	BSF         PEIE_bit+0, BitPos(PEIE_bit+0) 
;tentativa2.c,31 :: 		TMR1IE_bit = 1;// Interrupção de Timer1 ligada
	BSF         TMR1IE_bit+0, BitPos(TMR1IE_bit+0) 
;tentativa2.c,33 :: 		I2C1_Init(100000);         // initialize I2C communication
	MOVLW       10
	MOVWF       SSPADD+0 
	CALL        _I2C1_Init+0, 0
;tentativa2.c,34 :: 		I2C1_Start();              // issue I2C start signal
	CALL        _I2C1_Start+0, 0
;tentativa2.c,35 :: 		I2C1_Wr(0x02);             // send byte via I2C  (device address + W)
	MOVLW       2
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;tentativa2.c,36 :: 		I2C1_Wr(2);                // send byte (address of EEPROM location)
	MOVLW       2
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;tentativa2.c,37 :: 		I2C1_Wr(0x0A);             // send data (data to be written)
	MOVLW       10
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;tentativa2.c,38 :: 		I2C1_Stop();               // issue I2C stop signal
	CALL        _I2C1_Stop+0, 0
;tentativa2.c,50 :: 		TMR1IF_bit = 1;
	BSF         TMR1IF_bit+0, BitPos(TMR1IF_bit+0) 
;tentativa2.c,51 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_interrupt:

;tentativa2.c,53 :: 		void interrupt(){
;tentativa2.c,54 :: 		TMR1ON_bit = 0;    // Para o Timer1
	BCF         TMR1ON_bit+0, BitPos(TMR1ON_bit+0) 
;tentativa2.c,55 :: 		TMR1IF_bit = 0;    // Abaixa a flag do Timer1
	BCF         TMR1IF_bit+0, BitPos(TMR1IF_bit+0) 
;tentativa2.c,58 :: 		if (contagem) contagem--;
	MOVF        _contagem+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt0
	DECF        _contagem+0, 1 
	GOTO        L_interrupt1
L_interrupt0:
;tentativa2.c,61 :: 		contagem = 100;         // Reinicia a contagem
	MOVLW       100
	MOVWF       _contagem+0 
;tentativa2.c,62 :: 		ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
;tentativa2.c,63 :: 		tempAtual = ADRES/2.025; // Pega a temperatura do forno
	MOVF        ADRES+0, 0 
	MOVWF       R0 
	MOVF        ADRES+1, 0 
	MOVWF       R1 
	CALL        _word2double+0, 0
	MOVLW       154
	MOVWF       R4 
	MOVLW       153
	MOVWF       R5 
	MOVLW       1
	MOVWF       R6 
	MOVLW       128
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	CALL        _double2word+0, 0
	MOVF        R0, 0 
	MOVWF       _tempAtual+0 
	MOVF        R1, 0 
	MOVWF       _tempAtual+1 
;tentativa2.c,64 :: 		IntToStr(tempAtual, strTemp);
	MOVF        R0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _strTemp+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_strTemp+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;tentativa2.c,67 :: 		if (tempAtual < 72) PWM1_Set_Duty(255);
	MOVLW       0
	SUBWF       _tempAtual+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt11
	MOVLW       72
	SUBWF       _tempAtual+0, 0 
L__interrupt11:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt2
	MOVLW       255
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
	GOTO        L_interrupt3
L_interrupt2:
;tentativa2.c,69 :: 		else if (tempAtual < 75) PWM1_Set_Duty(127);
	MOVLW       0
	SUBWF       _tempAtual+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt12
	MOVLW       75
	SUBWF       _tempAtual+0, 0 
L__interrupt12:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt4
	MOVLW       127
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
	GOTO        L_interrupt5
L_interrupt4:
;tentativa2.c,71 :: 		else if (tempAtual < 80) PWM1_Set_Duty(64);
	MOVLW       0
	SUBWF       _tempAtual+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt13
	MOVLW       80
	SUBWF       _tempAtual+0, 0 
L__interrupt13:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt6
	MOVLW       64
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
	GOTO        L_interrupt7
L_interrupt6:
;tentativa2.c,73 :: 		else PWM1_Set_Duty(0);
	CLRF        FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
L_interrupt7:
L_interrupt5:
L_interrupt3:
;tentativa2.c,79 :: 		}
L_interrupt1:
;tentativa2.c,82 :: 		TMR1H = 0;
	CLRF        TMR1H+0 
;tentativa2.c,83 :: 		TMR1L = 0;
	CLRF        TMR1L+0 
;tentativa2.c,84 :: 		TMR1ON_bit = 1;    // Volta o Timer1
	BSF         TMR1ON_bit+0, BitPos(TMR1ON_bit+0) 
;tentativa2.c,85 :: 		}
L_end_interrupt:
L__interrupt10:
	RETFIE      1
; end of _interrupt
