
_ADRead:

;proj9Code.c,25 :: 		void ADRead() {
;proj9Code.c,26 :: 		Delay_us(4);
	NOP
	NOP
	NOP
	NOP
;proj9Code.c,27 :: 		GO_DONE_bit = 1;
	BSF         GO_DONE_bit+0, BitPos(GO_DONE_bit+0) 
;proj9Code.c,28 :: 		Delay_us(4);
	NOP
	NOP
	NOP
	NOP
;proj9Code.c,29 :: 		}
L_end_ADRead:
	RETURN      0
; end of _ADRead

_main:

;proj9Code.c,31 :: 		void main() {
;proj9Code.c,33 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;proj9Code.c,34 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;proj9Code.c,36 :: 		TRISC.B1 = 0;
	BCF         TRISC+0, 1 
;proj9Code.c,39 :: 		ADCON1 = 0b00001110;
	MOVLW       14
	MOVWF       ADCON1+0 
;proj9Code.c,40 :: 		ADCON0 = 0b00000000;
	CLRF        ADCON0+0 
;proj9Code.c,41 :: 		ADCON2 = 0b10010100;
	MOVLW       148
	MOVWF       ADCON2+0 
;proj9Code.c,42 :: 		ADON_bit = 1;        // Liga o módulo de conversão
	BSF         ADON_bit+0, BitPos(ADON_bit+0) 
;proj9Code.c,46 :: 		while (1) {
L_main0:
;proj9Code.c,47 :: 		ADRead();      // Chama a função de leitura AD
	CALL        _ADRead+0, 0
;proj9Code.c,48 :: 		numTensao = ADRES*5.0/1023;     // Converte para a tensão real com a proporção
	MOVF        ADRES+0, 0 
	MOVWF       R0 
	MOVF        ADRES+1, 0 
	MOVWF       R1 
	CALL        _word2double+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       129
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       192
	MOVWF       R5 
	MOVLW       127
	MOVWF       R6 
	MOVLW       136
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _numTensao+0 
	MOVF        R1, 0 
	MOVWF       _numTensao+1 
	MOVF        R2, 0 
	MOVWF       _numTensao+2 
	MOVF        R3, 0 
	MOVWF       _numTensao+3 
;proj9Code.c,49 :: 		sprintf(saida, "%.3f", numTensao); // Transforma o número em real em texto para saída
	MOVLW       _saida+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_saida+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_1_proj9Code+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_1_proj9Code+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_1_proj9Code+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        R0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        R1, 0 
	MOVWF       FARG_sprintf_wh+6 
	MOVF        R2, 0 
	MOVWF       FARG_sprintf_wh+7 
	MOVF        R3, 0 
	MOVWF       FARG_sprintf_wh+8 
	CALL        _sprintf+0, 0
;proj9Code.c,52 :: 		Lcd_Out(0,5,"TENSAO");
	CLRF        FARG_Lcd_Out_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_proj9Code+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_proj9Code+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;proj9Code.c,53 :: 		Lcd_Out(2,4,saida);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       4
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _saida+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_saida+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;proj9Code.c,54 :: 		Lcd_Out(2,9," Volts");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       9
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_proj9Code+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_proj9Code+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;proj9Code.c,57 :: 		LED = 1;
	BSF         PORTC+0, 1 
;proj9Code.c,58 :: 		Delay_ms(500);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main2:
	DECFSZ      R13, 1, 1
	BRA         L_main2
	DECFSZ      R12, 1, 1
	BRA         L_main2
	DECFSZ      R11, 1, 1
	BRA         L_main2
	NOP
	NOP
;proj9Code.c,59 :: 		LED = 0;
	BCF         PORTC+0, 1 
;proj9Code.c,60 :: 		Delay_ms(500);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main3:
	DECFSZ      R13, 1, 1
	BRA         L_main3
	DECFSZ      R12, 1, 1
	BRA         L_main3
	DECFSZ      R11, 1, 1
	BRA         L_main3
	NOP
	NOP
;proj9Code.c,61 :: 		}
	GOTO        L_main0
;proj9Code.c,62 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
