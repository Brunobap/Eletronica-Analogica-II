
_main:

;cod2proj.c,1 :: 		void main() {
;cod2proj.c,2 :: 		RCON = 0;
	CLRF        RCON+0 
;cod2proj.c,4 :: 		INTCON = 0b11000000;
	MOVLW       192
	MOVWF       INTCON+0 
;cod2proj.c,5 :: 		INTCON2 = 0b00;
	CLRF        INTCON2+0 
;cod2proj.c,6 :: 		INTCON3 = 0;
	CLRF        INTCON3+0 
;cod2proj.c,8 :: 		PIE1 = 0;
	CLRF        PIE1+0 
;cod2proj.c,9 :: 		PIE2 = 0;
	CLRF        PIE2+0 
;cod2proj.c,11 :: 		IPR1 = 0;
	CLRF        IPR1+0 
;cod2proj.c,12 :: 		IPR2 = 0;
	CLRF        IPR2+0 
;cod2proj.c,13 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
