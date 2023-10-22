
_main:

;prj5.c,19 :: 		void main() {
;prj5.c,20 :: 		TRISA = 0x00;
	CLRF       TRISA+0
;prj5.c,21 :: 		TRISB = 0x05;
	MOVLW      5
	MOVWF      TRISB+0
;prj5.c,23 :: 		OPTION_REG = 0b00010001;
	MOVLW      17
	MOVWF      OPTION_REG+0
;prj5.c,24 :: 		INTCON = 0b10110000;
	MOVLW      176
	MOVWF      INTCON+0
;prj5.c,26 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;prj5.c,27 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;prj5.c,30 :: 		while(1){
L_main0:
;prj5.c,31 :: 		PORTA = CONTADOR;
	MOVF       _CONTADOR+0, 0
	MOVWF      PORTA+0
;prj5.c,32 :: 		FILTRO = T_FILTRO;
	MOVLW      230
	MOVWF      _FILTRO+0
	CLRF       _FILTRO+1
;prj5.c,33 :: 		while (BTN_CNT == 0 && FILTRO > 0) {
L_main2:
	BTFSC      PORTB+0, 2
	GOTO       L_main3
	MOVF       _FILTRO+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main32
	MOVF       _FILTRO+0, 0
	SUBLW      0
L__main32:
	BTFSC      STATUS+0, 0
	GOTO       L_main3
L__main30:
;prj5.c,34 :: 		FILTRO--;
	MOVLW      1
	SUBWF      _FILTRO+0, 1
	BTFSS      STATUS+0, 0
	DECF       _FILTRO+1, 1
;prj5.c,35 :: 		}
	GOTO       L_main2
L_main3:
;prj5.c,36 :: 		if (BTN_CNT == 0 && FILTRO == 0) {
	BTFSC      PORTB+0, 2
	GOTO       L_main8
	MOVLW      0
	XORWF      _FILTRO+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main33
	MOVLW      0
	XORWF      _FILTRO+0, 0
L__main33:
	BTFSS      STATUS+0, 2
	GOTO       L_main8
L__main29:
;prj5.c,37 :: 		if (CONTROLE) {
	MOVF       _CONTROLE+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main9
;prj5.c,39 :: 		CONTADOR--;
	MOVLW      1
	SUBWF      _CONTADOR+0, 1
	BTFSS      STATUS+0, 0
	DECF       _CONTADOR+1, 1
;prj5.c,40 :: 		if (CONTADOR == 1) CONTROLE = false;
	MOVLW      0
	XORWF      _CONTADOR+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main34
	MOVLW      1
	XORWF      _CONTADOR+0, 0
L__main34:
	BTFSS      STATUS+0, 2
	GOTO       L_main10
	CLRF       _CONTROLE+0
L_main10:
;prj5.c,41 :: 		} else {
	GOTO       L_main11
L_main9:
;prj5.c,43 :: 		CONTADOR++;
	INCF       _CONTADOR+0, 1
	BTFSC      STATUS+0, 2
	INCF       _CONTADOR+1, 1
;prj5.c,44 :: 		if (CONTADOR == 9) CONTROLE = true;
	MOVLW      0
	XORWF      _CONTADOR+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main35
	MOVLW      9
	XORWF      _CONTADOR+0, 0
L__main35:
	BTFSS      STATUS+0, 2
	GOTO       L_main12
	MOVLW      1
	MOVWF      _CONTROLE+0
L_main12:
;prj5.c,45 :: 		}
L_main11:
;prj5.c,46 :: 		PORTA = CONTADOR;
	MOVF       _CONTADOR+0, 0
	MOVWF      PORTA+0
;prj5.c,47 :: 		while (BTN_CNT == 0);
L_main13:
	BTFSC      PORTB+0, 2
	GOTO       L_main14
	GOTO       L_main13
L_main14:
;prj5.c,48 :: 		}
L_main8:
;prj5.c,49 :: 		}
	GOTO       L_main0
;prj5.c,50 :: 		}
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

;prj5.c,52 :: 		void interrupt() {
;prj5.c,53 :: 		if (INTCON.B2) {
	BTFSS      INTCON+0, 2
	GOTO       L_interrupt15
;prj5.c,55 :: 		INTCON.B2 = 0;
	BCF        INTCON+0, 2
;prj5.c,56 :: 		switch (CONTADOR) {
	GOTO       L_interrupt16
;prj5.c,57 :: 		case 1:
L_interrupt18:
;prj5.c,58 :: 		TMR0 = 14;
	MOVLW      14
	MOVWF      TMR0+0
;prj5.c,59 :: 		break;
	GOTO       L_interrupt17
;prj5.c,60 :: 		case 2:
L_interrupt19:
;prj5.c,61 :: 		Delay_us(1);
	NOP
	NOP
;prj5.c,62 :: 		TMR0 = 141;
	MOVLW      141
	MOVWF      TMR0+0
;prj5.c,63 :: 		break;
	GOTO       L_interrupt17
;prj5.c,64 :: 		case 3:
L_interrupt20:
;prj5.c,65 :: 		TMR0 = 184;
	MOVLW      184
	MOVWF      TMR0+0
;prj5.c,66 :: 		break;
	GOTO       L_interrupt17
;prj5.c,67 :: 		case 4:
L_interrupt21:
;prj5.c,68 :: 		TMR0 = 207;
	MOVLW      207
	MOVWF      TMR0+0
;prj5.c,69 :: 		break;
	GOTO       L_interrupt17
;prj5.c,70 :: 		case 5:
L_interrupt22:
;prj5.c,71 :: 		TMR0 = 222;
	MOVLW      222
	MOVWF      TMR0+0
;prj5.c,72 :: 		break;
	GOTO       L_interrupt17
;prj5.c,73 :: 		case 6:
L_interrupt23:
;prj5.c,74 :: 		Delay_us(1);
	NOP
	NOP
;prj5.c,75 :: 		Delay_us(1);
	NOP
	NOP
;prj5.c,76 :: 		TMR0 = 233;
	MOVLW      233
	MOVWF      TMR0+0
;prj5.c,77 :: 		break;
	GOTO       L_interrupt17
;prj5.c,78 :: 		case 7:
L_interrupt24:
;prj5.c,79 :: 		Delay_us(1);
	NOP
	NOP
;prj5.c,80 :: 		TMR0 = 240;
	MOVLW      240
	MOVWF      TMR0+0
;prj5.c,81 :: 		break;
	GOTO       L_interrupt17
;prj5.c,82 :: 		case 8:
L_interrupt25:
;prj5.c,83 :: 		Delay_us(1);
	NOP
	NOP
;prj5.c,84 :: 		TMR0 = 247;
	MOVLW      247
	MOVWF      TMR0+0
;prj5.c,85 :: 		break;
	GOTO       L_interrupt17
;prj5.c,87 :: 		default:
L_interrupt26:
;prj5.c,88 :: 		Delay_us(1);
	NOP
	NOP
;prj5.c,89 :: 		TMR0 = 250;
	MOVLW      250
	MOVWF      TMR0+0
;prj5.c,90 :: 		}
	GOTO       L_interrupt17
L_interrupt16:
	MOVLW      0
	XORWF      _CONTADOR+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt38
	MOVLW      1
	XORWF      _CONTADOR+0, 0
L__interrupt38:
	BTFSC      STATUS+0, 2
	GOTO       L_interrupt18
	MOVLW      0
	XORWF      _CONTADOR+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt39
	MOVLW      2
	XORWF      _CONTADOR+0, 0
L__interrupt39:
	BTFSC      STATUS+0, 2
	GOTO       L_interrupt19
	MOVLW      0
	XORWF      _CONTADOR+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt40
	MOVLW      3
	XORWF      _CONTADOR+0, 0
L__interrupt40:
	BTFSC      STATUS+0, 2
	GOTO       L_interrupt20
	MOVLW      0
	XORWF      _CONTADOR+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt41
	MOVLW      4
	XORWF      _CONTADOR+0, 0
L__interrupt41:
	BTFSC      STATUS+0, 2
	GOTO       L_interrupt21
	MOVLW      0
	XORWF      _CONTADOR+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt42
	MOVLW      5
	XORWF      _CONTADOR+0, 0
L__interrupt42:
	BTFSC      STATUS+0, 2
	GOTO       L_interrupt22
	MOVLW      0
	XORWF      _CONTADOR+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt43
	MOVLW      6
	XORWF      _CONTADOR+0, 0
L__interrupt43:
	BTFSC      STATUS+0, 2
	GOTO       L_interrupt23
	MOVLW      0
	XORWF      _CONTADOR+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt44
	MOVLW      7
	XORWF      _CONTADOR+0, 0
L__interrupt44:
	BTFSC      STATUS+0, 2
	GOTO       L_interrupt24
	MOVLW      0
	XORWF      _CONTADOR+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt45
	MOVLW      8
	XORWF      _CONTADOR+0, 0
L__interrupt45:
	BTFSC      STATUS+0, 2
	GOTO       L_interrupt25
	GOTO       L_interrupt26
L_interrupt17:
;prj5.c,91 :: 		OUT_ONDA = !OUT_ONDA;
	MOVLW      128
	XORWF      PORTB+0, 1
;prj5.c,93 :: 		} else if (INTCON.B1) {
	GOTO       L_interrupt27
L_interrupt15:
	BTFSS      INTCON+0, 1
	GOTO       L_interrupt28
;prj5.c,95 :: 		INTCON.B1 = 0;
	BCF        INTCON+0, 1
;prj5.c,96 :: 		OUT_LED = !OUT_LED;
	MOVLW      2
	XORWF      PORTB+0, 1
;prj5.c,97 :: 		}
L_interrupt28:
L_interrupt27:
;prj5.c,98 :: 		}
L_end_interrupt:
L__interrupt37:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt
