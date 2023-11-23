
_ADRead:

;proj9Code.c,23 :: 		void ADRead() {
;proj9Code.c,24 :: 		Delay_us(4);
	NOP
	NOP
	NOP
	NOP
;proj9Code.c,25 :: 		ADON_bit = 1;
	BSF         ADON_bit+0, BitPos(ADON_bit+0) 
;proj9Code.c,26 :: 		GO_DONE_bit = 1;
	BSF         GO_DONE_bit+0, BitPos(GO_DONE_bit+0) 
;proj9Code.c,27 :: 		Delay_us(4);
	NOP
	NOP
	NOP
	NOP
;proj9Code.c,28 :: 		ADLow = ADRESL;
	MOVF        ADRESL+0, 0 
	MOVWF       _ADLow+0 
	MOVLW       0
	MOVWF       _ADLow+1 
;proj9Code.c,29 :: 		ADHigh = ADRESH;
	MOVF        ADRESH+0, 0 
	MOVWF       _ADHigh+0 
	MOVLW       0
	MOVWF       _ADHigh+1 
;proj9Code.c,30 :: 		}
L_end_ADRead:
	RETURN      0
; end of _ADRead

_main:

;proj9Code.c,32 :: 		void main() {
;proj9Code.c,33 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;proj9Code.c,34 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;proj9Code.c,36 :: 		PWM2_Init(1000);
	BSF         T2CON+0, 0, 0
	BCF         T2CON+0, 1, 0
	MOVLW       249
	MOVWF       PR2+0, 0
	CALL        _PWM2_Init+0, 0
;proj9Code.c,37 :: 		PWM2_Set_Duty(128);
	MOVLW       128
	MOVWF       FARG_PWM2_Set_Duty_new_duty+0 
	CALL        _PWM2_Set_Duty+0, 0
;proj9Code.c,38 :: 		PWM2_Start();
	CALL        _PWM2_Start+0, 0
;proj9Code.c,41 :: 		ADCON1 = 0b00001110;
	MOVLW       14
	MOVWF       ADCON1+0 
;proj9Code.c,42 :: 		ADCON0 = 0b00000000;
	CLRF        ADCON0+0 
;proj9Code.c,43 :: 		ADCON2 = 0b10010100;
	MOVLW       148
	MOVWF       ADCON2+0 
;proj9Code.c,45 :: 		while (1) {
L_main0:
;proj9Code.c,46 :: 		Delay_ms(500);
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
;proj9Code.c,47 :: 		ADRead();
	CALL        _ADRead+0, 0
;proj9Code.c,48 :: 		ADComp = ADLow + 256*ADHigh;
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
;proj9Code.c,49 :: 		numTensao = ADComp/204.6667;
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
;proj9Code.c,50 :: 		FloatToStr_FixLen(numTensao, saida, 6);
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
;proj9Code.c,51 :: 		Lcd_Out(0,5,"TENSAO");
	CLRF        FARG_Lcd_Out_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_proj9Code+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_proj9Code+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;proj9Code.c,52 :: 		Lcd_Out(2,4,saida);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       4
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _saida+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_saida+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;proj9Code.c,53 :: 		Lcd_Out(2,9," Volts");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       9
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_proj9Code+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_proj9Code+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;proj9Code.c,54 :: 		}
	GOTO        L_main0
;proj9Code.c,55 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
