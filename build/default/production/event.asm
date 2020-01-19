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
	global	_eventInit
	global	_eventRead

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern	_kpRead
	extern	_kpInit
	extern	_serialInit
	extern	_serialProtocol

;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
STATUS	equ	0xfd8
WREG	equ	0xfe8
FSR1L	equ	0xfe1
FSR2L	equ	0xfd9
POSTDEC1	equ	0xfe5
PREINC1	equ	0xfe4
PRODL	equ	0xff3


; Internal registers
.registers	udata_ovr	0x0000
r0x00	res	1
r0x01	res	1
r0x02	res	1
r0x03	res	1
r0x04	res	1
r0x05	res	1

udata_event_0	udata
_key_ant	res	1

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_event__eventRead	code
_eventRead:
;	.line	14; event.c	unsigned int eventRead(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
;	.line	16; event.c	int ev = EV_NOEVENT;
	MOVLW	0x06
	MOVWF	r0x00
	CLRF	r0x01
;	.line	17; event.c	key = kpRead();
	CALL	_kpRead
	MOVWF	r0x02
	CLRF	r0x03
;	.line	18; event.c	serial = serialProtocol();
	CALL	_serialProtocol
	MOVWF	r0x04
	CLRF	r0x05
;	.line	19; event.c	if ((key != 0) || (serial !=0)) {
	MOVF	r0x02, W
	IORWF	r0x03, W
	BNZ	_00122_DS_
	MOVF	r0x04, W
	IORWF	r0x05, W
	BZ	_00123_DS_
_00122_DS_:
;	.line	20; event.c	if ((key == 1)|| (serial == 'A')) {
	MOVF	r0x02, W
	XORLW	0x01
	BNZ	_00143_DS_
	MOVF	r0x03, W
	BZ	_00110_DS_
_00143_DS_:
	MOVF	r0x04, W
	XORLW	0x41
	BNZ	_00111_DS_
	MOVF	r0x05, W
	BZ	_00110_DS_
_00144_DS_:
	BRA	_00111_DS_
_00110_DS_:
;	.line	21; event.c	ev = EV_LEFT;
	MOVLW	0x02
	MOVWF	r0x00
	CLRF	r0x01
_00111_DS_:
;	.line	24; event.c	if ((key == 2)||(serial== 'S')) {
	MOVF	r0x02, W
	XORLW	0x02
	BNZ	_00147_DS_
	MOVF	r0x03, W
	BZ	_00113_DS_
_00147_DS_:
	MOVF	r0x04, W
	XORLW	0x53
	BNZ	_00114_DS_
	MOVF	r0x05, W
	BZ	_00113_DS_
_00148_DS_:
	BRA	_00114_DS_
_00113_DS_:
;	.line	25; event.c	ev = EV_ENTER;
	MOVLW	0x04
	MOVWF	r0x00
	CLRF	r0x01
_00114_DS_:
;	.line	28; event.c	if ((key == 3)||(serial=='D')) {
	MOVF	r0x02, W
	XORLW	0x03
	BNZ	_00151_DS_
	MOVF	r0x03, W
	BZ	_00116_DS_
_00151_DS_:
	MOVF	r0x04, W
	XORLW	0x44
	BNZ	_00117_DS_
	MOVF	r0x05, W
	BZ	_00116_DS_
_00152_DS_:
	BRA	_00117_DS_
_00116_DS_:
;	.line	29; event.c	ev = EV_RIGHT;
	MOVLW	0x03
	MOVWF	r0x00
	CLRF	r0x01
_00117_DS_:
;	.line	32; event.c	if ((key == 4)||(serial=='@')) {
	MOVF	r0x02, W
	XORLW	0x04
	BNZ	_00155_DS_
	MOVF	r0x03, W
	BZ	_00119_DS_
_00155_DS_:
	MOVF	r0x04, W
	XORLW	0x40
	BNZ	_00123_DS_
	MOVF	r0x05, W
	BZ	_00119_DS_
_00156_DS_:
	BRA	_00123_DS_
_00119_DS_:
;	.line	33; event.c	ev = EV_RESET;
	MOVLW	0x05
	MOVWF	r0x00
	CLRF	r0x01
_00123_DS_:
;	.line	37; event.c	key_ant = key; 
	MOVF	r0x02, W
	BANKSEL	_key_ant
	MOVWF	_key_ant, B
;	.line	38; event.c	return ev;
	MOVFF	r0x01, PRODL
	MOVF	r0x00, W
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_event__eventInit	code
_eventInit:
;	.line	8; event.c	void eventInit(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	9; event.c	kpInit();
	CALL	_kpInit
;	.line	10; event.c	serialInit();
	CALL	_serialInit
	BANKSEL	_key_ant
;	.line	11; event.c	key_ant = 0;    
	CLRF	_key_ant, B
	MOVFF	PREINC1, FSR2L
	RETURN	



; Statistics:
; code size:	  246 (0x00f6) bytes ( 0.19%)
;           	  123 (0x007b) words
; udata size:	    1 (0x0001) bytes ( 0.06%)
; access size:	    6 (0x0006) bytes


	end
