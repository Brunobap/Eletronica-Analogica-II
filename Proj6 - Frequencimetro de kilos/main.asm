;*******************************************************************************
;                                                                              *
;    Filename:   Base16f628A.asm                                               *
;    Date:      Outubro-23                                                      *
;    File Version:    1                                                        *
;    Author:          RONY MARK                                                *
;    Company:         IFSULDEMINAS                                             *
;    Description:    Arquivo Base para o 16f628A
;*******************************************************************************

;*******************************************************************************

; TODO INSERT INCLUDE CODE HERE
    #include "p16f628a.inc"

; TODO INSERT CONFIG HERE
; CONFIG

 __CONFIG _FOSC_INTOSCIO & _WDTE_OFF & _PWRTE_ON & _MCLRE_OFF & _BOREN_ON & _LVP_OFF & _CPD_OFF & _CP_OFF

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                    PAGINA��O DE MEM�RIA                         *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;DEFINI��O DE COMANDOS DE USU�RIO PARA ALTERA��O DA P�GINA DE MEM�RIA
#DEFINE	BANK0	BCF STATUS,RP0	;SETA BANK 0 DE MEM�RIA
#DEFINE	BANK1	BSF STATUS,RP0	;SETA BANK 1 DE MAM�RIA

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                         VARI�VEIS                               *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; DEFINI��O DOS NOMES E ENDERE�OS DE TODAS AS VARI�VEIS UTILIZADAS 
; PELO SISTEMA
	CBLOCK	0x20	;ENDERE�O INICIAL DA MEM�RIA DE
					;USU�RIO
		W_TEMP		;REGISTRADORES TEMPOR�RIOS PARA USO
		STATUS_TEMP	;JUNTO �S INTERRUP��ES
						
	ENDC			;FIM DO BLOCO DE MEM�RIA

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                        CONTROLES INTERNOS                       *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; DEFINI��O DE TODOS OS FLAGS UTILIZADOS PELO SISTEMA

	
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                         CONSTANTES                              *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; DEFINI��O DE TODAS AS CONSTANTES UTILIZADAS PELO SISTEMA
	

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                           ENTRADAS                              *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; DEFINI��O DE TODOS OS PINOS QUE SER�O UTILIZADOS COMO ENTRADA
; RECOMENDAMOS TAMB�M COMENTAR O SIGNIFICADO DE SEUS ESTADOS (0 E 1)

							
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                           SA�DAS                                *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; DEFINI��O DE TODOS OS PINOS QUE SER�O UTILIZADOS COMO SA�DA
; RECOMENDAMOS TAMB�M COMENTAR O SIGNIFICADO DE SEUS ESTADOS (0 E 1)

	#DEFINE		LED			PORTB,1
			
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                       VETOR DE RESET                            *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

	ORG	0x00			;ENDERE�O INICIAL DE PROCESSAMENTO
	GOTO	INICIO
	
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                    IN�CIO DA INTERRUP��O                        *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; ENDERE�O DE DESVIO DAS INTERRUP��ES. A PRIMEIRA TAREFA � SALVAR OS
; VALORES DE "W" E "STATUS" PARA RECUPERA��O FUTURA

	ORG	0x04			;ENDERE�O INICIAL DA INTERRUP��O
	MOVWF	W_TEMP		;COPIA W PARA W_TEMP
	SWAPF	STATUS,W
	MOVWF	STATUS_TEMP	;COPIA STATUS PARA STATUS_TEMP

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                    ROTINA DE INTERRUP��O                        *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; AQUI SER� ESCRITA AS ROTINAS DE RECONHECIMENTO E TRATAMENTO DAS
; INTERRUP��ES

	MOVLW	TMR1L
	MOVWF	PORTA			;CARREGAR O CONTADOR (TMR1, parte baixa) PARA SA�DA
	BCF		LED				;ACABOU A CONTAGEM, APAGA O LED
	BCF		PIR1,TMR2IF		;LIMPA A FLAG DELE
	MOVLW	.255
	MOVWF	TMR2			;CARREGA O PRESET DE TIMER2
	MOVLW	.0
	MOVWF	TMR1L		
	MOVWF	TMR1H			;REINICIA O CONTADOR
	BSF		LED				;RECOME�OU A CONTAGEM, ACENDE O LED
			
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                 ROTINA DE SA�DA DA INTERRUP��O                  *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; OS VALORES DE "W" E "STATUS" DEVEM SER RECUPERADOS ANTES DE 
; RETORNAR DA INTERRUP��O

SAI_INT
	SWAPF	STATUS_TEMP,W
	MOVWF	STATUS		;MOVE STATUS_TEMP PARA STATUS
	SWAPF	W_TEMP,F
	SWAPF	W_TEMP,W	;MOVE W_TEMP PARA W
	RETFIE

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*	            	 ROTINAS E SUBROTINAS                      *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; CADA ROTINA OU SUBROTINA DEVE POSSUIR A DESCRI��O DE FUNCIONAMENTO
; E UM NOME COERENTE �S SUAS FUN��ES.



;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     INICIO DO PROGRAMA                          *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	
INICIO
	BANK1				;ALTERA PARA O BANCO 1
	MOVLW	B'00001011'
	MOVWF	PCON		;DEFINE OSCILADOR INTERNO = 4MHz
	
	MOVLW	B'00000000'
	MOVWF	TRISA		;DEFINE ENTRADAS E SA�DAS DO PORTA
						;RA0-3 S�O AS SA�DAS DO CONTADOR
	MOVLW	B'01000000'
	MOVWF	TRISB		;DEFINE ENTRADAS E SA�DAS DO PORTB
						;RB6 � A ENTRADA DE CLOCK PARA CONTAGEM
	MOVLW	B'00000000'
	MOVWF	OPTION_REG	;DEFINE OP��ES DE OPERA��O 
						;TODAS AS OP��ES DESABILITADAS, MENOS OS PULLUPs
	MOVLW	B'11000000'
	MOVWF	INTCON		;DEFINE OP��ES DE INTERRUP��O 
						;S� INTERRUP��ES DE PERIF�RICOS, PEIE
	MOVLW	B'00000010'
	MOVWF	PIE1		;DEFINE OP��ES DE INTERRUP��O 2
						;S� INTERRUP��O DE TIMER2 (timer do milisegundo) 
	MOVLW	B'00000000'
	MOVWF	VRCON		;DEFINE M�DULO TENS�O DE REFER�NCIA
						;TUDO DESABILITADO, N�O � USADO
	
	BANK0				;RETORNA PARA O BANCO
	MOVLW	B'00000011'
	MOVWF	T1CON		;DEFINE TMR1 
						;PRESCALER 1:1, CLOCK EXTERNO (RB6), COME�A LIGADO
	MOVLW	B'00001101'
	MOVWF	T2CON		;DEFINE TMR2
						;POSTSCALER 1:2, COME�A LIGADO, PRESCALER 1:4
						;ESCALA FINAL = 1:(2*4) --> 1:8
	
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     INICIALIZA��O DAS VARI�VEIS                 *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *


	MOVLW	.0
	MOVWF	PORTB		;INICIALIZA RB0-7 COM 0


;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     ROTINA PRINCIPAL                            *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
MAIN
	GOTO MAIN

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                       FIM DO PROGRAMA                           *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

	END