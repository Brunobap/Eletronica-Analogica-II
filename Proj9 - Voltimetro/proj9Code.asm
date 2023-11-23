
_ADRead:

;proj9Code.c,23 :: 		void ADRead() {
;proj9Code.c,24 :: 		Delay_us(4);
	NOP
	NOP
	NOP
	NOP
;proj9Code.c,25 :: 		GO_DONE_bit = 1;
	BSF         GO_DONE_bit+0, BitPos(GO_DONE_bit+0) 
;proj9Code.c,26 :: 		Delay_us(4);
	NOP
	NOP
	NOP
	NOP
;proj9Code.c,27 :: 		ADLow = ADRESL;
	MOVF        ADRESL+0, 0 
	MOVWF       _ADLow+0 
	MOVLW       0
	MOVWF       _ADLow+1 
;proj9Code.c,28 :: 		ADHigh = ADRESH;
	MOVF        ADRESH+0, 0 
	MOVWF       _ADHigh+0 
	MOVLW       0
	MOVWF       _ADHigh+1 
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
;proj9Code.c,37 :: 		ADCON1 = 0b00001110;
	MOVLW       14
	MOVWF       ADCON1+0 
;proj9Code.c,38 :: 		ADCON0 = 0b00000000;
	CLRF        ADCON0+0 
;proj9Code.c,39 :: 		ADCON2 = 0b10010100;
	MOVLW       148
	MOVWF       ADCON2+0 
;proj9Code.c,40 :: 		ADON_bit = 1;        // Liga o módulo de conversão
	BSF         ADON_bit+0, BitPos(ADON_bit+0) 
;proj9Code.c,42 :: 		while (1) {
L_main0:
;proj9Code.c,43 :: 		ADRead();      // Chama a função de leitura AD
	CALL        _ADRead+0, 0
;proj9Code.c,44 :: 		ADComp = ADLow + 256*ADHigh;     // Calcula o número inteiro lido da conversão
	MOVF        _ADHigh+0, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        R0, 0 
	ADDWF       _ADLow+0, 0 
	MOVWF       _ADComp+0 
	MOVF        R1, 0 
	ADDWFC      _ADLow+1, 0 
	MOVWF       _ADComp+1 
	MOVLW       0
	MOVWF       _ADComp+2 
	MOVWF       _ADComp+3 
;proj9Code.c,45 :: 		numTensao = ADComp/204.6667;     // Converte para a tensão real com a proporção
	MOVF        _ADComp+0, 0 
	MOVWF       R0 
	MOVF        _ADComp+1, 0 
	MOVWF       R1 
	MOVF        _ADComp+2, 0 
	MOVWF       R2 
	MOVF        _ADComp+3, 0 
	MOVWF       R3 
	CALL        _longword2double+0, 0
	MOVLW       173
	MOVWF       R4 
	MOVLW       170
	MOVWF       R5 
	MOVLW       76
	MOVWF       R6 
	MOVLW       134
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
;proj9Code.c,46 :: 		FloatToStr_FixLen(numTensao, saida, 6); // Transforma o número em real em texto para saída
	MOVF        R0, 0 
	MOVWF       FARG_FloatToStr_FixLen_fnum+0 
	MOVF        R1, 0 
	MOVWF       FARG_FloatToStr_FixLen_fnum+1 
	MOVF        R2, 0 
	MOVWF       FARG_FloatToStr_FixLen_fnum+2 
	MOVF        R3, 0 
	MOVWF       FARG_FloatToStr_FixLen_fnum+3 
	MOVLW       _saida+0
	MOVWF       FARG_FloatToStr_FixLen_str+0 
	MOVLW       hi_addr(_saida+0)
	MOVWF       FARG_FloatToStr_FixLen_str+1 
	MOVLW       6
	MOVWF       FARG_FloatToStr_FixLen_len+0 
	CALL        _FloatToStr_FixLen+0, 0
;proj9Code.c,49 :: 		Lcd_Out(0,5,"TENSAO");
	CLRF        FARG_Lcd_Out_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_proj9Code+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_proj9Code+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;proj9Code.c,50 :: 		Lcd_Out(2,4,saida);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       4
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _saida+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_saida+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;proj9Code.c,51 :: 		Lcd_Out(2,9," Volts");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       9
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_proj9Code+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_proj9Code+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;proj9Code.c,54 :: 		PORTC = 0xFF;
	MOVLW       255
	MOVWF       PORTC+0 
;proj9Code.c,55 :: 		Delay_ms(500);
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
;proj9Code.c,56 :: 		PORTC = 0x00;
	CLRF        PORTC+0 
;proj9Code.c,57 :: 		Delay_ms(500);
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
;proj9Code.c,58 :: 		}
	GOTO        L_main0
;proj9Code.c,59 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
