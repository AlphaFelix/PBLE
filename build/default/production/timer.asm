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
	global	_timerEnded
	global	_timerWait
	global	_countTime
	global	_getCount
	global	_timerReset
	global	_timerInit
	global	_timer

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern	__mulint

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
r0x03	res	1
r0x04	res	1
r0x05	res	1

udata_timer_0	udata
_timer	res	2

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_timer__timerInit	code
_timerInit:
;	.line	60; timer.c	void timerInit(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
;	.line	61; timer.c	T0CON = 0b00001000; //configura timer 0 sem prescaler
	LFSR	0x00, 0xfd5
	MOVLW	0x08
	MOVWF	INDF0
;	.line	62; timer.c	bitSet(T0CON, 7); //liga o timer 0
	LFSR	0x00, 0xfd5
	MOVFF	INDF0, r0x00
	BSF	r0x00, 7
	LFSR	0x00, 0xfd5
	MOVFF	r0x00, INDF0
;	.line	63; timer.c	timer = 5;
	MOVLW	0x05
	BANKSEL	_timer
	MOVWF	_timer, B
	BANKSEL	(_timer + 1)
	CLRF	(_timer + 1), B
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_timer__timerReset	code
_timerReset:
;	.line	47; timer.c	void timerReset(unsigned int tempo) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
;	.line	49; timer.c	unsigned ciclos = tempo * 2;
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x02
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVLW	0x04
	ADDWF	FSR1L, F
;	.line	51; timer.c	ciclos = 65535 - ciclos;
	MOVFF	r0x00, r0x02
	MOVFF	r0x01, r0x03
	CLRF	r0x04
	CLRF	r0x05
	MOVF	r0x02, W
	SUBLW	0xff
	MOVWF	r0x02
	MOVLW	0xff
	SUBFWB	r0x03, F
	MOVLW	0x00
	SUBFWB	r0x04, F
	MOVLW	0x00
	SUBFWB	r0x05, F
	MOVF	r0x02, W
	MOVWF	r0x00
	MOVF	r0x03, W
	MOVWF	r0x01
;	.line	53; timer.c	ciclos -= 14; //subtrai tempo de overhead(experimental)
	MOVLW	0xf2
	ADDWF	r0x00, F
	BTFSS	STATUS, 0
	DECF	r0x01, F
;	.line	54; timer.c	TMR0H = (ciclos >> 8); //salva a parte alta
	MOVF	r0x01, W
	MOVWF	r0x02
	CLRF	r0x03
	LFSR	0x00, 0xfd7
	MOVFF	r0x02, INDF0
;	.line	55; timer.c	TMR0L = (ciclos & 0x00FF); // salva a parte baixa
	CLRF	r0x01
	LFSR	0x00, 0xfd6
	MOVFF	r0x00, INDF0
;	.line	57; timer.c	bitClr(INTCON, 2); //limpa a flag de overflow
	LFSR	0x00, 0xff2
	MOVFF	INDF0, r0x00
	BCF	r0x00, 2
	LFSR	0x00, 0xff2
	MOVFF	r0x00, INDF0
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_timer__getCount	code
_getCount:
;	.line	41; timer.c	int getCount(void){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	42; timer.c	return timer;
	MOVFF	(_timer + 1), PRODL
	BANKSEL	_timer
	MOVF	_timer, W, B
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_timer__countTime	code
_countTime:
;	.line	33; timer.c	void countTime(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	BANKSEL	_timer
;	.line	35; timer.c	if(timer > 0)
	MOVF	_timer, W, B
	BANKSEL	(_timer + 1)
	IORWF	(_timer + 1), W, B
	BZ	_00124_DS_
;	.line	36; timer.c	timer--;
	MOVLW	0xff
	BANKSEL	_timer
	ADDWF	_timer, F, B
	BANKSEL	(_timer + 1)
	ADDWFC	(_timer + 1), F, B
	BRA	_00126_DS_
_00124_DS_:
;	.line	38; timer.c	timer = 3;
	MOVLW	0x03
	BANKSEL	_timer
	MOVWF	_timer, B
	BANKSEL	(_timer + 1)
	CLRF	(_timer + 1), B
_00126_DS_:
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_timer__timerWait	code
_timerWait:
;	.line	29; timer.c	void timerWait(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
_00110_DS_:
;	.line	30; timer.c	while (!bitTst(INTCON, 2));
	LFSR	0x00, 0xff2
	MOVFF	INDF0, r0x00
	BTFSS	r0x00, 2
	BRA	_00110_DS_
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_timer__timerEnded	code
_timerEnded:
;	.line	25; timer.c	char timerEnded(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
;	.line	26; timer.c	return bitTst(INTCON, 2);
	LFSR	0x00, 0xff2
	MOVFF	INDF0, r0x00
	MOVLW	0x04
	ANDWF	r0x00, F
	MOVF	r0x00, W
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	



; Statistics:
; code size:	  388 (0x0184) bytes ( 0.30%)
;           	  194 (0x00c2) words
; udata size:	    2 (0x0002) bytes ( 0.11%)
; access size:	    6 (0x0006) bytes


	end
