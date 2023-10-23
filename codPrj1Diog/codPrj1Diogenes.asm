
_leituraAD:

;codPrj1Diogenes.c,30 :: 		void leituraAD() {
;codPrj1Diogenes.c,32 :: 		ADCON0.ADON = 1;
	BSF         ADCON0+0, 0 
;codPrj1Diogenes.c,34 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;codPrj1Diogenes.c,35 :: 		PIE1.ADIE = 1;
	BSF         PIE1+0, 6 
;codPrj1Diogenes.c,37 :: 		Delay_ms(50);
	MOVLW       130
	MOVWF       R12, 0
	MOVLW       221
	MOVWF       R13, 0
L_leituraAD0:
	DECFSZ      R13, 1, 1
	BRA         L_leituraAD0
	DECFSZ      R12, 1, 1
	BRA         L_leituraAD0
	NOP
	NOP
;codPrj1Diogenes.c,39 :: 		ADCON0.GO_DONE = 1;
	BSF         ADCON0+0, 1 
;codPrj1Diogenes.c,41 :: 		while (ADCON0.GO_DONE!=0);
L_leituraAD1:
	BTFSS       ADCON0+0, 1 
	GOTO        L_leituraAD2
	GOTO        L_leituraAD1
L_leituraAD2:
;codPrj1Diogenes.c,42 :: 		while (PIR1.ADIF!=1) ;
L_leituraAD3:
	BTFSC       PIR1+0, 6 
	GOTO        L_leituraAD4
	GOTO        L_leituraAD3
L_leituraAD4:
;codPrj1Diogenes.c,44 :: 		tempAtual = ADRES;
	MOVF        ADRES+0, 0 
	MOVWF       R0 
	MOVF        ADRES+1, 0 
	MOVWF       R1 
	CALL        _word2double+0, 0
	MOVF        R0, 0 
	MOVWF       _tempAtual+0 
	MOVF        R1, 0 
	MOVWF       _tempAtual+1 
	MOVF        R2, 0 
	MOVWF       _tempAtual+2 
	MOVF        R3, 0 
	MOVWF       _tempAtual+3 
;codPrj1Diogenes.c,45 :: 		}
L_end_leituraAD:
	RETURN      0
; end of _leituraAD

_main:

;codPrj1Diogenes.c,47 :: 		void main() {
;codPrj1Diogenes.c,48 :: 		int adc = 0, y = 1;
;codPrj1Diogenes.c,50 :: 		tempIdeal = .725;
	MOVLW       154
	MOVWF       _tempIdeal+0 
	MOVLW       153
	MOVWF       _tempIdeal+1 
	MOVLW       57
	MOVWF       _tempIdeal+2 
	MOVLW       126
	MOVWF       _tempIdeal+3 
;codPrj1Diogenes.c,53 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;codPrj1Diogenes.c,57 :: 		INTCON = 0b11000000;
	MOVLW       192
	MOVWF       INTCON+0 
;codPrj1Diogenes.c,58 :: 		INTCON2 = 0b10110000;
	MOVLW       176
	MOVWF       INTCON2+0 
;codPrj1Diogenes.c,59 :: 		INTCON3 = 0b00000000;
	CLRF        INTCON3+0 
;codPrj1Diogenes.c,62 :: 		T1CON.TMR1ON = 0;   // Desliga o Timer1 durante a configuração
	BCF         T1CON+0, 0 
;codPrj1Diogenes.c,63 :: 		T1CON.T1CKPS1 = 1;  // Define o pré-escalonamento 1:8
	BSF         T1CON+0, 5 
;codPrj1Diogenes.c,64 :: 		T1CON.T1CKPS0 = 1;  // (Isso define o pré-escalonamento como 8)
	BSF         T1CON+0, 4 
;codPrj1Diogenes.c,65 :: 		TMR1H = 0x3C;       // Valor inicial alto (MSB) do contador (65536-15624)
	MOVLW       60
	MOVWF       TMR1H+0 
;codPrj1Diogenes.c,66 :: 		TMR1L = 0x24;       // Valor inicial baixo (LSB) do contador (65536-15624)
	MOVLW       36
	MOVWF       TMR1L+0 
;codPrj1Diogenes.c,67 :: 		T1CON.TMR1ON = 1;   // Liga o Timer1
	BSF         T1CON+0, 0 
;codPrj1Diogenes.c,70 :: 		ADCON1 = 0x0F;
	MOVLW       15
	MOVWF       ADCON1+0 
;codPrj1Diogenes.c,71 :: 		ADCON0 = 0b00000000;
	CLRF        ADCON0+0 
;codPrj1Diogenes.c,72 :: 		ADCON1 = 0b00000110;
	MOVLW       6
	MOVWF       ADCON1+0 
;codPrj1Diogenes.c,73 :: 		ADCON2 = 0b10010000;
	MOVLW       144
	MOVWF       ADCON2+0 
;codPrj1Diogenes.c,74 :: 		leituraAD();
	CALL        _leituraAD+0, 0
;codPrj1Diogenes.c,78 :: 		while(1){
L_main5:
;codPrj1Diogenes.c,79 :: 		Delay_ms(150);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       134
	MOVWF       R12, 0
	MOVLW       153
	MOVWF       R13, 0
L_main7:
	DECFSZ      R13, 1, 1
	BRA         L_main7
	DECFSZ      R12, 1, 1
	BRA         L_main7
	DECFSZ      R11, 1, 1
	BRA         L_main7
;codPrj1Diogenes.c,81 :: 		}
	GOTO        L_main5
;codPrj1Diogenes.c,82 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_interrupt_low:
	MOVWF       ___Low_saveWREG+0 
	MOVF        STATUS+0, 0 
	MOVWF       ___Low_saveSTATUS+0 
	MOVF        BSR+0, 0 
	MOVWF       ___Low_saveBSR+0 

;codPrj1Diogenes.c,84 :: 		void interrupt_low(){
;codPrj1Diogenes.c,95 :: 		}
L_interrupt_low8:
;codPrj1Diogenes.c,96 :: 		}
L_end_interrupt_low:
L__interrupt_low12:
	MOVF        ___Low_saveBSR+0, 0 
	MOVWF       BSR+0 
	MOVF        ___Low_saveSTATUS+0, 0 
	MOVWF       STATUS+0 
	SWAPF       ___Low_saveWREG+0, 1 
	SWAPF       ___Low_saveWREG+0, 0 
	RETFIE      0
; end of _interrupt_low
