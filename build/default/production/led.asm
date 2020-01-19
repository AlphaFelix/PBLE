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
	global	_ledInit
	global	_ledOn
	global	_ledOff
	global	_ledBlink

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern	_getCount

;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
STATUS	equ	0xfd8
WREG	equ	0xfe8
FSR1L	equ	0xfe1
FSR2L	equ	0xfd9
INDF0	equ	0xfef
POSTDEC1	equ	0xfe5
PREINC1	equ	0xfe4
PLUSW2	equ	0xfdb
PRODL	equ	0xff3


; Internal registers
.registers	udata_ovr	0x0000
r0x00	res	1
r0x01	res	1
r0x02	res	1

udata_led_0	udata
_time0	res	2

udata_led_1	udata
_time1	res	2

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_led__ledBlink	code
_ledBlink:
;	.line	22; led.c	void ledBlink(char x){   
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	24; led.c	if(getCount() == 0)
	CALL	_getCount
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVF	r0x01, W
	IORWF	r0x02, W
	BNZ	_00130_DS_
;	.line	25; led.c	bitFlp(PORTB,((x%2)+5));    
	LFSR	0x00, 0xf81
	MOVFF	INDF0, r0x01
	MOVLW	0x01
	ANDWF	r0x00, F
	MOVLW	0x05
	ADDWF	r0x00, F
	MOVLW	0x01
	MOVWF	r0x02
	MOVF	r0x00, W
	BZ	_00136_DS_
	NEGF	WREG
	BCF	STATUS, 0
_00137_DS_:
	RLCF	r0x02, F
	ADDLW	0x01
	BNC	_00137_DS_
_00136_DS_:
	MOVF	r0x02, W
	XORWF	r0x01, F
	LFSR	0x00, 0xf81
	MOVFF	r0x01, INDF0
_00130_DS_:
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_led__ledOff	code
_ledOff:
;	.line	18; led.c	void ledOff(char x){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	19; led.c	bitClr(PORTB,((x%2)+5));      
	LFSR	0x00, 0xf81
	MOVFF	INDF0, r0x01
	MOVLW	0x01
	ANDWF	r0x00, F
	MOVLW	0x05
	ADDWF	r0x00, F
	MOVLW	0x01
	MOVWF	r0x02
	MOVF	r0x00, W
	BZ	_00122_DS_
	NEGF	WREG
	BCF	STATUS, 0
_00123_DS_:
	RLCF	r0x02, F
	ADDLW	0x01
	BNC	_00123_DS_
_00122_DS_:
	COMF	r0x02, W
	MOVWF	r0x00
	MOVF	r0x00, W
	ANDWF	r0x01, F
	LFSR	0x00, 0xf81
	MOVFF	r0x01, INDF0
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_led__ledOn	code
_ledOn:
;	.line	14; led.c	void ledOn(char x){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	15; led.c	bitSet(PORTB,((x%2)+5));   
	LFSR	0x00, 0xf81
	MOVFF	INDF0, r0x01
	MOVLW	0x01
	ANDWF	r0x00, F
	MOVLW	0x05
	ADDWF	r0x00, F
	MOVLW	0x01
	MOVWF	r0x02
	MOVF	r0x00, W
	BZ	_00113_DS_
	NEGF	WREG
	BCF	STATUS, 0
_00114_DS_:
	RLCF	r0x02, F
	ADDLW	0x01
	BNC	_00114_DS_
_00113_DS_:
	MOVF	r0x02, W
	IORWF	r0x01, F
	LFSR	0x00, 0xf81
	MOVFF	r0x01, INDF0
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_led__ledInit	code
_ledInit:
;	.line	7; led.c	void ledInit(void){    
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
;	.line	8; led.c	bitClr(TRISB,5);
	LFSR	0x00, 0xf93
	MOVFF	INDF0, r0x00
	BCF	r0x00, 5
	LFSR	0x00, 0xf93
	MOVFF	r0x00, INDF0
;	.line	9; led.c	bitClr(TRISB,6);
	LFSR	0x00, 0xf93
	MOVFF	INDF0, r0x00
	BCF	r0x00, 6
	LFSR	0x00, 0xf93
	MOVFF	r0x00, INDF0
;	.line	10; led.c	bitClr(PORTB,5);
	LFSR	0x00, 0xf81
	MOVFF	INDF0, r0x00
	BCF	r0x00, 5
	LFSR	0x00, 0xf81
	MOVFF	r0x00, INDF0
;	.line	11; led.c	bitClr(PORTB,6);    
	LFSR	0x00, 0xf81
	MOVFF	INDF0, r0x00
	BCF	r0x00, 6
	LFSR	0x00, 0xf81
	MOVFF	r0x00, INDF0
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	



; Statistics:
; code size:	  384 (0x0180) bytes ( 0.29%)
;           	  192 (0x00c0) words
; udata size:	    4 (0x0004) bytes ( 0.22%)
; access size:	    3 (0x0003) bytes


	end
