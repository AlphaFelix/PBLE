;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.6.0 #9615 (MINGW64)
;--------------------------------------------------------
; PIC16 port for the Microchip 16-bit core micros
;--------------------------------------------------------
	list	p=18f4550
	radix	dec


;--------------------------------------------------------
; public variables in this module
;--------------------------------------------------------
	global	_dacI2c

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern	_i2cStart
	extern	_i2cStop
	extern	_i2cSend

;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
FSR1L	equ	0xfe1
FSR2L	equ	0xfd9
POSTINC1	equ	0xfe6
POSTDEC1	equ	0xfe5
PREINC1	equ	0xfe4
PLUSW2	equ	0xfdb


; Internal registers
.registers	udata_ovr	0x0000
r0x00	res	1
r0x01	res	1
r0x02	res	1
r0x03	res	1

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_dac__dacI2c	code
_dacI2c:
;	.line	3; dac.c	void dacI2c(unsigned int sample){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
;	.line	4; dac.c	i2cStart();    
	CALL	_i2cStart
;	.line	5; dac.c	i2cSend(0xC0);
	MOVLW	0xc0
	MOVWF	POSTDEC1
	CALL	_i2cSend
	MOVF	POSTINC1, F
;	.line	6; dac.c	i2cSend(0x40);
	MOVLW	0x40
	MOVWF	POSTDEC1
	CALL	_i2cSend
	MOVF	POSTINC1, F
;	.line	7; dac.c	i2cSend((sample & 0xFF0) >> 4);
	MOVLW	0xf0
	ANDWF	r0x00, W
	MOVWF	r0x02
	MOVLW	0x0f
	ANDWF	r0x01, W
	MOVWF	r0x03
	MOVLW	0xf0
	ANDWF	r0x02, F
	SWAPF	r0x02, F
	SWAPF	r0x03, F
	ANDWF	r0x03, W
	XORWF	r0x03, F
	ADDWF	r0x02, F
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	_i2cSend
	MOVF	POSTINC1, F
;	.line	8; dac.c	i2cSend((sample & 0xF) << 4);
	MOVLW	0x0f
	ANDWF	r0x00, F
	CLRF	r0x01
	SWAPF	r0x00, W
	ANDLW	0xf0
	MOVWF	r0x01
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_i2cSend
	MOVF	POSTINC1, F
;	.line	9; dac.c	i2cStop();
	CALL	_i2cStop
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	



; Statistics:
; code size:	  144 (0x0090) bytes ( 0.11%)
;           	   72 (0x0048) words
; udata size:	    0 (0x0000) bytes ( 0.00%)
; access size:	    4 (0x0004) bytes


	end
