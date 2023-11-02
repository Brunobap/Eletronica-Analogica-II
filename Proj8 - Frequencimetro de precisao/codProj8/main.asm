
_main:

;main.c,30 :: 		void main() {
;main.c,32 :: 		PCON = 0b00001011;
	MOVLW      11
	MOVWF      PCON+0
;main.c,33 :: 		TRISB = 0b01000000;
	MOVLW      64
	MOVWF      TRISB+0
;main.c,34 :: 		INTCON = 0b11000000;
	MOVLW      192
	MOVWF      INTCON+0
;main.c,35 :: 		PIE1 = 0b00000010;
	MOVLW      2
	MOVWF      PIE1+0
;main.c,36 :: 		CMCON = 0b00000111;
	MOVLW      7
	MOVWF      CMCON+0
;main.c,37 :: 		T1CON = 0b00000011;
	MOVLW      3
	MOVWF      T1CON+0
;main.c,40 :: 		T2CON = 0b01111111;
	MOVLW      127
	MOVWF      T2CON+0
;main.c,43 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;main.c,44 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;main.c,46 :: 		void interrupt() {
;main.c,47 :: 		valHi = TMR1H;
	MOVF       TMR1H+0, 0
	MOVWF      _valHi+0
	CLRF       _valHi+1
;main.c,48 :: 		valLo = TMR1L;
	MOVF       TMR1L+0, 0
	MOVWF      _valLo+0
	CLRF       _valLo+1
;main.c,50 :: 		if (reps) reps--;        // Se reps != 0, tira 1 dela
	MOVF       _reps+0, 0
	IORWF      _reps+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_interrupt0
	MOVLW      1
	SUBWF      _reps+0, 1
	BTFSS      STATUS+0, 0
	DECF       _reps+1, 1
	GOTO       L_interrupt1
L_interrupt0:
;main.c,52 :: 		TMR1ON_bit = 0;        // Para a contagem do Timer1
	BCF        TMR1ON_bit+0, BitPos(TMR1ON_bit+0)
;main.c,53 :: 		LED = !LED;            // Altera o LED, para mostrar o tempo da contagem
	MOVLW
	XORWF      RB1_bit+0, 1
;main.c,55 :: 		intFreq = valHi*256+valLo;
	MOVF       _valHi+0, 0
	MOVWF      _intFreq+1
	CLRF       _intFreq+0
	MOVF       _valLo+0, 0
	ADDWF      _intFreq+0, 1
	MOVF       _valLo+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _intFreq+1, 1
;main.c,57 :: 		Lcd_Out(0,3,"FREQUENCIA:");// Escreve as palavras constantes no LCD
	CLRF       FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_main+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;main.c,58 :: 		Lcd_Out(2,10,"Hz");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      10
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_main+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;main.c,60 :: 		IntToStr(intFreq,strFreq);  // Transforma o valor do Timer1 em String
	MOVF       _intFreq+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       _intFreq+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _strFreq+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;main.c,61 :: 		Lcd_Out(2,3,strFreq);           // Escreve a frequência no display
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _strFreq+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;main.c,63 :: 		TMR1H = 0;        // Reinicia o contador do Timer1
	CLRF       TMR1H+0
;main.c,64 :: 		TMR1L = 0;
	CLRF       TMR1L+0
;main.c,66 :: 		reps = 15;        // Reinicia o número de repetições da interrupção
	MOVLW      15
	MOVWF      _reps+0
	MOVLW      0
	MOVWF      _reps+1
;main.c,67 :: 		TMR1ON_bit = 1;  // Volta a conatgem do Timer1
	BSF        TMR1ON_bit+0, BitPos(TMR1ON_bit+0)
;main.c,68 :: 		}
L_interrupt1:
;main.c,70 :: 		TMR2IF_bit = 0;  // Abaixa a flag da interrupção
	BCF        TMR2IF_bit+0, BitPos(TMR2IF_bit+0)
;main.c,71 :: 		TMR2 = 190;     // Carrega o preset do Timer2
	MOVLW      190
	MOVWF      TMR2+0
;main.c,72 :: 		}
L_end_interrupt:
L__interrupt4:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt
