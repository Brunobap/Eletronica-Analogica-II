
_main:

;tentativa2.c,34 :: 		void main() {
;tentativa2.c,36 :: 		estado = 1;
	MOVLW       1
	MOVWF       _estado+0 
;tentativa2.c,39 :: 		tempIdeal = 150;
	MOVLW       150
	MOVWF       _tempIdeal+0 
	MOVLW       0
	MOVWF       _tempIdeal+1 
;tentativa2.c,40 :: 		tempMargem = 152;
	MOVLW       152
	MOVWF       _tempMargem+0 
	MOVLW       0
	MOVWF       _tempMargem+1 
;tentativa2.c,43 :: 		TRISA = 0x01;
	MOVLW       1
	MOVWF       TRISA+0 
;tentativa2.c,44 :: 		TRISB = 0x03;
	MOVLW       3
	MOVWF       TRISB+0 
;tentativa2.c,45 :: 		TRISD = 0x00;
	CLRF        TRISD+0 
;tentativa2.c,48 :: 		ADC_Init();
	CALL        _ADC_Init+0, 0
;tentativa2.c,49 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;tentativa2.c,52 :: 		IPEN_bit = 0;  // Sem prioridades
	BCF         IPEN_bit+0, BitPos(IPEN_bit+0) 
;tentativa2.c,53 :: 		RBPU_bit = 0;  // Pull-ups de RB ligados
	BCF         RBPU_bit+0, BitPos(RBPU_bit+0) 
;tentativa2.c,54 :: 		GIE_bit = 1;   // Chave geral das interrupções ligada
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;tentativa2.c,55 :: 		PEIE_bit = 1;  // Chave das interrupções de periféricos ligada
	BSF         PEIE_bit+0, BitPos(PEIE_bit+0) 
;tentativa2.c,56 :: 		TMR1IE_bit = 1;// Interrupção de Timer1 ligada
	BSF         TMR1IE_bit+0, BitPos(TMR1IE_bit+0) 
;tentativa2.c,57 :: 		INT0IE_bit = 1;// Interrupção de INT0 ligada
	BSF         INT0IE_bit+0, BitPos(INT0IE_bit+0) 
;tentativa2.c,58 :: 		INT1IE_bit = 1;// Interrupção de INT1 ligada
	BSF         INT1IE_bit+0, BitPos(INT1IE_bit+0) 
;tentativa2.c,63 :: 		TMR1IF_bit = 1;
	BSF         TMR1IF_bit+0, BitPos(TMR1IF_bit+0) 
;tentativa2.c,64 :: 		INT0IF_bit = 1;
	BSF         INT0IF_bit+0, BitPos(INT0IF_bit+0) 
;tentativa2.c,65 :: 		INT1IF_bit = 1;
	BSF         INT1IF_bit+0, BitPos(INT1IF_bit+0) 
;tentativa2.c,66 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_interrupt:

;tentativa2.c,68 :: 		void interrupt(){
;tentativa2.c,70 :: 		if (TMR1IF_bit){
	BTFSS       TMR1IF_bit+0, BitPos(TMR1IF_bit+0) 
	GOTO        L_interrupt0
;tentativa2.c,71 :: 		TMR1ON_bit = 0;    // Para o Timer1
	BCF         TMR1ON_bit+0, BitPos(TMR1ON_bit+0) 
;tentativa2.c,72 :: 		TMR1IF_bit = 0;    // Abaixa a flag do Timer1
	BCF         TMR1IF_bit+0, BitPos(TMR1IF_bit+0) 
;tentativa2.c,75 :: 		if (contagem) contagem--;
	MOVF        _contagem+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt1
	DECF        _contagem+0, 1 
	GOTO        L_interrupt2
L_interrupt1:
;tentativa2.c,78 :: 		contagem = 100;         // Reinicia a contagem
	MOVLW       100
	MOVWF       _contagem+0 
;tentativa2.c,79 :: 		tempAtual = ADC_Get_Sample(0); // Pega a temperatura do forno
	CLRF        FARG_ADC_Get_Sample_channel+0 
	CALL        _ADC_Get_Sample+0, 0
	MOVF        R0, 0 
	MOVWF       _tempAtual+0 
	MOVF        R1, 0 
	MOVWF       _tempAtual+1 
;tentativa2.c,81 :: 		if (tempAtual < tempIdeal) LED = 1;
	MOVF        _tempIdeal+1, 0 
	SUBWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt16
	MOVF        _tempIdeal+0, 0 
	SUBWF       R0, 0 
L__interrupt16:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt3
	BSF         RD2_bit+0, BitPos(RD2_bit+0) 
	GOTO        L_interrupt4
L_interrupt3:
;tentativa2.c,83 :: 		else if (tempAtual > tempMargem) LED = 0;
	MOVF        _tempAtual+1, 0 
	SUBWF       _tempMargem+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt17
	MOVF        _tempAtual+0, 0 
	SUBWF       _tempMargem+0, 0 
L__interrupt17:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt5
	BCF         RD2_bit+0, BitPos(RD2_bit+0) 
L_interrupt5:
L_interrupt4:
;tentativa2.c,84 :: 		}
L_interrupt2:
;tentativa2.c,86 :: 		TMR1H = 0;
	CLRF        TMR1H+0 
;tentativa2.c,87 :: 		TMR1L = 0;
	CLRF        TMR1L+0 
;tentativa2.c,88 :: 		TMR1ON_bit = 1;    // Para o Timer1
	BSF         TMR1ON_bit+0, BitPos(TMR1ON_bit+0) 
;tentativa2.c,91 :: 		} else if (INT0IF_bit){
	GOTO        L_interrupt6
L_interrupt0:
	BTFSS       INT0IF_bit+0, BitPos(INT0IF_bit+0) 
	GOTO        L_interrupt7
;tentativa2.c,92 :: 		estado = -estado;    // Inverte o estado da máquina
	MOVF        _estado+0, 0 
	SUBLW       0
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       _estado+0 
;tentativa2.c,93 :: 		if (estado > 0) Lcd_Out(2,1,"Ligado");
	MOVLW       128
	XORLW       0
	MOVWF       R0 
	MOVLW       128
	XORWF       R1, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt8
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_tentativa2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_tentativa2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_interrupt9
L_interrupt8:
;tentativa2.c,94 :: 		else Lcd_Out(2,1,"Desligado");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_tentativa2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_tentativa2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
L_interrupt9:
;tentativa2.c,95 :: 		INT0IF_bit = 0;      // Abaixa a flag do INT0
	BCF         INT0IF_bit+0, BitPos(INT0IF_bit+0) 
;tentativa2.c,98 :: 		} else {
	GOTO        L_interrupt10
L_interrupt7:
;tentativa2.c,100 :: 		if (tempIdeal==150) {
	MOVLW       0
	XORWF       _tempIdeal+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt18
	MOVLW       150
	XORWF       _tempIdeal+0, 0 
L__interrupt18:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt11
;tentativa2.c,101 :: 		tempIdeal = 164; // Muda pra 80°C
	MOVLW       164
	MOVWF       _tempIdeal+0 
	MOVLW       0
	MOVWF       _tempIdeal+1 
;tentativa2.c,102 :: 		tempMargem = 168;// Muda pra 82°C
	MOVLW       168
	MOVWF       _tempMargem+0 
	MOVLW       0
	MOVWF       _tempMargem+1 
;tentativa2.c,103 :: 		Lcd_Out(2,11,"80oC");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       11
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_tentativa2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_tentativa2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;tentativa2.c,106 :: 		} else {
	GOTO        L_interrupt12
L_interrupt11:
;tentativa2.c,107 :: 		tempIdeal = 150; // Muda pra 80°C
	MOVLW       150
	MOVWF       _tempIdeal+0 
	MOVLW       0
	MOVWF       _tempIdeal+1 
;tentativa2.c,108 :: 		tempMargem = 152;// Muda pra 82°C
	MOVLW       152
	MOVWF       _tempMargem+0 
	MOVLW       0
	MOVWF       _tempMargem+1 
;tentativa2.c,109 :: 		Lcd_Out(2,11,"72oC");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       11
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr4_tentativa2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr4_tentativa2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;tentativa2.c,110 :: 		}
L_interrupt12:
;tentativa2.c,112 :: 		INT1IF_bit = 0;      // Abaixa a flag do INT1
	BCF         INT1IF_bit+0, BitPos(INT1IF_bit+0) 
;tentativa2.c,113 :: 		}
L_interrupt10:
L_interrupt6:
;tentativa2.c,114 :: 		}
L_end_interrupt:
L__interrupt15:
	RETFIE      1
; end of _interrupt
