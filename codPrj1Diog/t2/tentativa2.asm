
_main:

;tentativa2.c,37 :: 		void main() {
;tentativa2.c,38 :: 		strIni = "Temp atual:";
	MOVLW       ?lstr_1_tentativa2+0
	MOVWF       _strIni+0 
;tentativa2.c,41 :: 		TRISA = 0x01;
	MOVLW       1
	MOVWF       TRISA+0 
;tentativa2.c,42 :: 		TRISB = 0x03;
	MOVLW       3
	MOVWF       TRISB+0 
;tentativa2.c,43 :: 		TRISD = 0x00;
	CLRF        TRISD+0 
;tentativa2.c,46 :: 		ADC_Init();
	CALL        _ADC_Init+0, 0
;tentativa2.c,47 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;tentativa2.c,50 :: 		IPEN_bit = 0;  // Sem prioridades
	BCF         IPEN_bit+0, BitPos(IPEN_bit+0) 
;tentativa2.c,51 :: 		RBPU_bit = 0;  // Pull-ups de RB ligados
	BCF         RBPU_bit+0, BitPos(RBPU_bit+0) 
;tentativa2.c,52 :: 		GIE_bit = 1;   // Chave geral das interrupções ligada
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;tentativa2.c,53 :: 		PEIE_bit = 1;  // Chave das interrupções de periféricos ligada
	BSF         PEIE_bit+0, BitPos(PEIE_bit+0) 
;tentativa2.c,54 :: 		TMR1IE_bit = 1;// Interrupção de Timer1 ligada
	BSF         TMR1IE_bit+0, BitPos(TMR1IE_bit+0) 
;tentativa2.c,57 :: 		TMR1IF_bit = 1;
	BSF         TMR1IF_bit+0, BitPos(TMR1IF_bit+0) 
;tentativa2.c,58 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_interrupt:

;tentativa2.c,60 :: 		void interrupt(){
;tentativa2.c,61 :: 		TMR1ON_bit = 0;    // Para o Timer1
	BCF         TMR1ON_bit+0, BitPos(TMR1ON_bit+0) 
;tentativa2.c,62 :: 		TMR1IF_bit = 0;    // Abaixa a flag do Timer1
	BCF         TMR1IF_bit+0, BitPos(TMR1IF_bit+0) 
;tentativa2.c,65 :: 		if (contagem) contagem--;
	MOVF        _contagem+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt0
	DECF        _contagem+0, 1 
	GOTO        L_interrupt1
L_interrupt0:
;tentativa2.c,68 :: 		contagem = 100;         // Reinicia a contagem
	MOVLW       100
	MOVWF       _contagem+0 
;tentativa2.c,69 :: 		ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
;tentativa2.c,70 :: 		tempAtual = ADRES/2.025; // Pega a temperatura do forno
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
;tentativa2.c,71 :: 		IntToStr(tempAtual, strTemp);
	MOVF        R0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _strTemp+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_strTemp+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;tentativa2.c,74 :: 		if (tempAtual < tempIdeal) LED = 1;
	MOVLW       0
	SUBWF       _tempAtual+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt10
	MOVLW       150
	SUBWF       _tempAtual+0, 0 
L__interrupt10:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt2
	BSF         RD2_bit+0, BitPos(RD2_bit+0) 
	GOTO        L_interrupt3
L_interrupt2:
;tentativa2.c,76 :: 		else if (tempAtual > tempMargem) LED = 0;
	MOVLW       0
	MOVWF       R0 
	MOVF        _tempAtual+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt11
	MOVF        _tempAtual+0, 0 
	SUBLW       152
L__interrupt11:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt4
	BCF         RD2_bit+0, BitPos(RD2_bit+0) 
L_interrupt4:
L_interrupt3:
;tentativa2.c,78 :: 		Lcd_Out(0,1,"T. atual:");
	CLRF        FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_tentativa2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_tentativa2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;tentativa2.c,79 :: 		Lcd_Out(0,10, strTemp);
	CLRF        FARG_Lcd_Out_row+0 
	MOVLW       10
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _strTemp+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_strTemp+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;tentativa2.c,81 :: 		if (LED) Lcd_Out(2,1,"Ligado   ");
	BTFSS       RD2_bit+0, BitPos(RD2_bit+0) 
	GOTO        L_interrupt5
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_tentativa2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_tentativa2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_interrupt6
L_interrupt5:
;tentativa2.c,82 :: 		else Lcd_Out(2,1,"Desligado");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr4_tentativa2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr4_tentativa2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
L_interrupt6:
;tentativa2.c,83 :: 		}
L_interrupt1:
;tentativa2.c,86 :: 		TMR1H = 0;
	CLRF        TMR1H+0 
;tentativa2.c,87 :: 		TMR1L = 0;
	CLRF        TMR1L+0 
;tentativa2.c,88 :: 		TMR1ON_bit = 1;    // Volta o Timer1
	BSF         TMR1ON_bit+0, BitPos(TMR1ON_bit+0) 
;tentativa2.c,89 :: 		}
L_end_interrupt:
L__interrupt9:
	RETFIE      1
; end of _interrupt
