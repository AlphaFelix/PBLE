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
	global	_smInit
	global	_smLoop

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern	_varInit
	extern	_getState
	extern	_setState
	extern	_getStateRst
	extern	_setStateRst
	extern	_getTime
	extern	_setTime
	extern	_getAlarmLow
	extern	_setAlarmLow
	extern	_getAlarmHigh
	extern	_setAlarmHigh
	extern	_getIdiom
	extern	_setIdiom
	extern	_eventRead
	extern	_outputPrint
	extern	_outputSerial

;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
STATUS	equ	0xfd8
PCL	equ	0xff9
PCLATH	equ	0xffa
PCLATU	equ	0xffb
WREG	equ	0xfe8
FSR1L	equ	0xfe1
FSR2L	equ	0xfd9
POSTINC1	equ	0xfe6
POSTDEC1	equ	0xfe5
PREINC1	equ	0xfe4
PRODL	equ	0xff3


; Internal registers
.registers	udata_ovr	0x0000
r0x00	res	1
r0x01	res	1
r0x02	res	1

udata_stateMachine_0	udata
_stateRST	res	1

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_stateMachine__smLoop	code
_smLoop:
;	.line	12; stateMachine.c	void smLoop(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
;	.line	16; stateMachine.c	event = eventRead();
	CALL	_eventRead
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
;	.line	18; stateMachine.c	switch (getState()) {
	CALL	_getState
	MOVWF	r0x01
	MOVLW	0x0d
	SUBWF	r0x01, W
	BTFSC	STATUS, 0
	GOTO	_00221_DS_
	CLRF	PCLATH
	CLRF	PCLATU
	RLCF	r0x01, W
	RLCF	PCLATH, F
	RLCF	WREG, W
	RLCF	PCLATH, F
	ANDLW	0xfc
	ADDLW	LOW(_00376_DS_)
	MOVWF	POSTDEC1
	MOVLW	HIGH(_00376_DS_)
	ADDWFC	PCLATH, F
	MOVLW	UPPER(_00376_DS_)
	ADDWFC	PCLATU, F
	MOVF	PREINC1, W
	MOVWF	PCL
_00376_DS_:
	GOTO	_00110_DS_
	GOTO	_00119_DS_
	GOTO	_00128_DS_
	GOTO	_00137_DS_
	GOTO	_00146_DS_
	GOTO	_00155_DS_
	GOTO	_00164_DS_
	GOTO	_00173_DS_
	GOTO	_00182_DS_
	GOTO	_00191_DS_
	GOTO	_00200_DS_
	GOTO	_00209_DS_
	GOTO	_00216_DS_
_00110_DS_:
;	.line	21; stateMachine.c	if (event == EV_RIGHT) {
	MOVF	r0x00, W
	XORLW	0x03
	BNZ	_00112_DS_
;	.line	22; stateMachine.c	setState(STATE_ALARM_LOW_0);
	MOVLW	0x02
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00112_DS_:
;	.line	24; stateMachine.c	if (event == EV_LEFT) {
	MOVF	r0x00, W
	XORLW	0x02
	BNZ	_00114_DS_
;	.line	25; stateMachine.c	setState(STATE_DATE);
	MOVLW	0x0b
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00114_DS_:
;	.line	29; stateMachine.c	if (event == EV_ENTER) {
	MOVF	r0x00, W
	XORLW	0x04
	BNZ	_00116_DS_
;	.line	30; stateMachine.c	setState(STATE_SET_AH_0);
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00116_DS_:
;	.line	32; stateMachine.c	if (event == EV_RESET) {
	MOVF	r0x00, W
	XORLW	0x05
	BZ	_00384_DS_
	GOTO	_00222_DS_
_00384_DS_:
;	.line	33; stateMachine.c	setStateRst(STATE_ALARM_HIGH_0);
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_setStateRst
	MOVF	POSTINC1, F
;	.line	34; stateMachine.c	setState(STATE_RST);
	MOVLW	0x0c
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
;	.line	36; stateMachine.c	break; 
	GOTO	_00222_DS_
_00119_DS_:
;	.line	39; stateMachine.c	if (event == EV_RIGHT) {
	MOVF	r0x00, W
	XORLW	0x03
	BNZ	_00121_DS_
;	.line	40; stateMachine.c	setAlarmHigh(0, getAlarmHigh(0) + 1);
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_getAlarmHigh
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVF	POSTINC1, F
	INFSNZ	r0x01, F
	INCF	r0x02, F
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_setAlarmHigh
	MOVLW	0x03
	ADDWF	FSR1L, F
_00121_DS_:
;	.line	42; stateMachine.c	if (event == EV_LEFT) {
	MOVF	r0x00, W
	XORLW	0x02
	BNZ	_00123_DS_
;	.line	43; stateMachine.c	setAlarmHigh(0, getAlarmHigh(0) - 1);
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_getAlarmHigh
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVF	POSTINC1, F
	MOVLW	0xff
	ADDWF	r0x01, F
	ADDWFC	r0x02, F
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_setAlarmHigh
	MOVLW	0x03
	ADDWF	FSR1L, F
_00123_DS_:
;	.line	47; stateMachine.c	if (event == EV_ENTER) {
	MOVF	r0x00, W
	XORLW	0x04
	BNZ	_00125_DS_
;	.line	48; stateMachine.c	setState(STATE_ALARM_HIGH_0);
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00125_DS_:
;	.line	50; stateMachine.c	if (event == EV_RESET) {
	MOVF	r0x00, W
	XORLW	0x05
	BZ	_00392_DS_
	GOTO	_00222_DS_
_00392_DS_:
;	.line	51; stateMachine.c	setStateRst(STATE_SET_AH_0);
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_setStateRst
	MOVF	POSTINC1, F
;	.line	52; stateMachine.c	setState(STATE_RST);
	MOVLW	0x0c
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
;	.line	54; stateMachine.c	break;
	GOTO	_00222_DS_
_00128_DS_:
;	.line	58; stateMachine.c	if (event == EV_RIGHT) {
	MOVF	r0x00, W
	XORLW	0x03
	BNZ	_00130_DS_
;	.line	59; stateMachine.c	setState(STATE_ALARM_HIGH_1);
	MOVLW	0x04
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00130_DS_:
;	.line	61; stateMachine.c	if (event == EV_LEFT) {
	MOVF	r0x00, W
	XORLW	0x02
	BNZ	_00132_DS_
;	.line	62; stateMachine.c	setState(STATE_ALARM_HIGH_0);
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00132_DS_:
;	.line	66; stateMachine.c	if (event == EV_ENTER) {
	MOVF	r0x00, W
	XORLW	0x04
	BNZ	_00134_DS_
;	.line	67; stateMachine.c	setState(STATE_SET_AL_0);
	MOVLW	0x03
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00134_DS_:
;	.line	69; stateMachine.c	if (event == EV_RESET) {
	MOVF	r0x00, W
	XORLW	0x05
	BZ	_00400_DS_
	BRA	_00222_DS_
_00400_DS_:
;	.line	70; stateMachine.c	setStateRst(STATE_ALARM_LOW_0);
	MOVLW	0x02
	MOVWF	POSTDEC1
	CALL	_setStateRst
	MOVF	POSTINC1, F
;	.line	71; stateMachine.c	setState(STATE_RST);
	MOVLW	0x0c
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
;	.line	73; stateMachine.c	break;            
	BRA	_00222_DS_
_00137_DS_:
;	.line	76; stateMachine.c	if (event == EV_RIGHT) {
	MOVF	r0x00, W
	XORLW	0x03
	BNZ	_00139_DS_
;	.line	77; stateMachine.c	setAlarmLow(0, getAlarmLow(0) + 1);
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_getAlarmLow
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVF	POSTINC1, F
	INFSNZ	r0x01, F
	INCF	r0x02, F
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_setAlarmLow
	MOVLW	0x03
	ADDWF	FSR1L, F
_00139_DS_:
;	.line	79; stateMachine.c	if (event == EV_LEFT) {
	MOVF	r0x00, W
	XORLW	0x02
	BNZ	_00141_DS_
;	.line	80; stateMachine.c	setAlarmLow(0, getAlarmLow(0) - 1);
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_getAlarmLow
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVF	POSTINC1, F
	MOVLW	0xff
	ADDWF	r0x01, F
	ADDWFC	r0x02, F
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_setAlarmLow
	MOVLW	0x03
	ADDWF	FSR1L, F
_00141_DS_:
;	.line	84; stateMachine.c	if (event == EV_ENTER) {
	MOVF	r0x00, W
	XORLW	0x04
	BNZ	_00143_DS_
;	.line	85; stateMachine.c	setState(STATE_ALARM_LOW_0);
	MOVLW	0x02
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00143_DS_:
;	.line	87; stateMachine.c	if (event == EV_RESET) {
	MOVF	r0x00, W
	XORLW	0x05
	BZ	_00408_DS_
	BRA	_00222_DS_
_00408_DS_:
;	.line	88; stateMachine.c	setStateRst(STATE_SET_AL_0);
	MOVLW	0x03
	MOVWF	POSTDEC1
	CALL	_setStateRst
	MOVF	POSTINC1, F
;	.line	89; stateMachine.c	setState(STATE_RST);
	MOVLW	0x0c
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
;	.line	91; stateMachine.c	break;
	BRA	_00222_DS_
_00146_DS_:
;	.line	95; stateMachine.c	if (event == EV_RIGHT) {
	MOVF	r0x00, W
	XORLW	0x03
	BNZ	_00148_DS_
;	.line	96; stateMachine.c	setState(STATE_ALARM_LOW_1);
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00148_DS_:
;	.line	98; stateMachine.c	if (event == EV_LEFT) {
	MOVF	r0x00, W
	XORLW	0x02
	BNZ	_00150_DS_
;	.line	99; stateMachine.c	setState(STATE_ALARM_LOW_0);
	MOVLW	0x02
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00150_DS_:
;	.line	103; stateMachine.c	if (event == EV_ENTER) {
	MOVF	r0x00, W
	XORLW	0x04
	BNZ	_00152_DS_
;	.line	104; stateMachine.c	setState(STATE_SET_AH_1);
	MOVLW	0x05
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00152_DS_:
;	.line	106; stateMachine.c	if (event == EV_RESET) {
	MOVF	r0x00, W
	XORLW	0x05
	BZ	_00416_DS_
	BRA	_00222_DS_
_00416_DS_:
;	.line	107; stateMachine.c	setStateRst(STATE_ALARM_HIGH_1);
	MOVLW	0x04
	MOVWF	POSTDEC1
	CALL	_setStateRst
	MOVF	POSTINC1, F
;	.line	108; stateMachine.c	setState(STATE_RST);
	MOVLW	0x0c
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
;	.line	110; stateMachine.c	break; 
	BRA	_00222_DS_
_00155_DS_:
;	.line	113; stateMachine.c	if (event == EV_RIGHT) {
	MOVF	r0x00, W
	XORLW	0x03
	BNZ	_00157_DS_
;	.line	114; stateMachine.c	setAlarmHigh(1, getAlarmHigh(1) + 1);
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_getAlarmHigh
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVF	POSTINC1, F
	INFSNZ	r0x01, F
	INCF	r0x02, F
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_setAlarmHigh
	MOVLW	0x03
	ADDWF	FSR1L, F
_00157_DS_:
;	.line	116; stateMachine.c	if (event == EV_LEFT) {
	MOVF	r0x00, W
	XORLW	0x02
	BNZ	_00159_DS_
;	.line	117; stateMachine.c	setAlarmHigh(1, getAlarmHigh(1) - 1);
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_getAlarmHigh
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVF	POSTINC1, F
	MOVLW	0xff
	ADDWF	r0x01, F
	ADDWFC	r0x02, F
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_setAlarmHigh
	MOVLW	0x03
	ADDWF	FSR1L, F
_00159_DS_:
;	.line	121; stateMachine.c	if (event == EV_ENTER) {
	MOVF	r0x00, W
	XORLW	0x04
	BNZ	_00161_DS_
;	.line	122; stateMachine.c	setState(STATE_ALARM_HIGH_1);
	MOVLW	0x04
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00161_DS_:
;	.line	124; stateMachine.c	if (event == EV_RESET) {
	MOVF	r0x00, W
	XORLW	0x05
	BZ	_00424_DS_
	BRA	_00222_DS_
_00424_DS_:
;	.line	125; stateMachine.c	setStateRst(STATE_SET_AH_1);
	MOVLW	0x05
	MOVWF	POSTDEC1
	CALL	_setStateRst
	MOVF	POSTINC1, F
;	.line	126; stateMachine.c	setState(STATE_RST);
	MOVLW	0x0c
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
;	.line	128; stateMachine.c	break;
	BRA	_00222_DS_
_00164_DS_:
;	.line	132; stateMachine.c	if (event == EV_RIGHT) {
	MOVF	r0x00, W
	XORLW	0x03
	BNZ	_00166_DS_
;	.line	133; stateMachine.c	setState(STATE_TIME);
	MOVLW	0x08
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00166_DS_:
;	.line	135; stateMachine.c	if (event == EV_LEFT) {
	MOVF	r0x00, W
	XORLW	0x02
	BNZ	_00168_DS_
;	.line	136; stateMachine.c	setState(STATE_ALARM_HIGH_1);
	MOVLW	0x04
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00168_DS_:
;	.line	140; stateMachine.c	if (event == EV_ENTER) {
	MOVF	r0x00, W
	XORLW	0x04
	BNZ	_00170_DS_
;	.line	141; stateMachine.c	setState(STATE_SET_AL_1);
	MOVLW	0x07
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00170_DS_:
;	.line	143; stateMachine.c	if (event == EV_RESET) {
	MOVF	r0x00, W
	XORLW	0x05
	BZ	_00432_DS_
	BRA	_00222_DS_
_00432_DS_:
;	.line	144; stateMachine.c	setStateRst(STATE_ALARM_LOW_1);
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	_setStateRst
	MOVF	POSTINC1, F
;	.line	145; stateMachine.c	setState(STATE_RST);
	MOVLW	0x0c
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
;	.line	147; stateMachine.c	break;
	BRA	_00222_DS_
_00173_DS_:
;	.line	151; stateMachine.c	if (event == EV_RIGHT) {
	MOVF	r0x00, W
	XORLW	0x03
	BNZ	_00175_DS_
;	.line	152; stateMachine.c	setAlarmLow(1, getAlarmLow(1) + 1);
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_getAlarmLow
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVF	POSTINC1, F
	INFSNZ	r0x01, F
	INCF	r0x02, F
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_setAlarmLow
	MOVLW	0x03
	ADDWF	FSR1L, F
_00175_DS_:
;	.line	154; stateMachine.c	if (event == EV_LEFT) {
	MOVF	r0x00, W
	XORLW	0x02
	BNZ	_00177_DS_
;	.line	155; stateMachine.c	setAlarmLow(1, getAlarmLow(1) - 1);
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_getAlarmLow
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVF	POSTINC1, F
	MOVLW	0xff
	ADDWF	r0x01, F
	ADDWFC	r0x02, F
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_setAlarmLow
	MOVLW	0x03
	ADDWF	FSR1L, F
_00177_DS_:
;	.line	159; stateMachine.c	if (event == EV_ENTER) {
	MOVF	r0x00, W
	XORLW	0x04
	BNZ	_00179_DS_
;	.line	160; stateMachine.c	setState(STATE_ALARM_LOW_1);
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00179_DS_:
;	.line	162; stateMachine.c	if (event == EV_RESET) {
	MOVF	r0x00, W
	XORLW	0x05
	BZ	_00440_DS_
	BRA	_00222_DS_
_00440_DS_:
;	.line	163; stateMachine.c	setStateRst(STATE_SET_AL_1);
	MOVLW	0x07
	MOVWF	POSTDEC1
	CALL	_setStateRst
	MOVF	POSTINC1, F
;	.line	164; stateMachine.c	setState(STATE_RST);
	MOVLW	0x0c
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
;	.line	166; stateMachine.c	break;
	BRA	_00222_DS_
_00182_DS_:
;	.line	170; stateMachine.c	if (event == EV_RIGHT) {
	MOVF	r0x00, W
	XORLW	0x03
	BNZ	_00184_DS_
;	.line	171; stateMachine.c	setState(STATE_IDIOM);
	MOVLW	0x0a
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00184_DS_:
;	.line	173; stateMachine.c	if (event == EV_LEFT) {
	MOVF	r0x00, W
	XORLW	0x02
	BNZ	_00186_DS_
;	.line	174; stateMachine.c	setState(STATE_ALARM_LOW_1);
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00186_DS_:
;	.line	178; stateMachine.c	if (event == EV_ENTER) {
	MOVF	r0x00, W
	XORLW	0x04
	BNZ	_00188_DS_
;	.line	179; stateMachine.c	setState(STATE_SET_T);
	MOVLW	0x09
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00188_DS_:
;	.line	181; stateMachine.c	if (event == EV_RESET) {
	MOVF	r0x00, W
	XORLW	0x05
	BZ	_00448_DS_
	BRA	_00222_DS_
_00448_DS_:
;	.line	182; stateMachine.c	setStateRst(STATE_TIME);
	MOVLW	0x08
	MOVWF	POSTDEC1
	CALL	_setStateRst
	MOVF	POSTINC1, F
;	.line	183; stateMachine.c	setState(STATE_RST);
	MOVLW	0x0c
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
;	.line	185; stateMachine.c	break;    
	BRA	_00222_DS_
_00191_DS_:
;	.line	188; stateMachine.c	if (event == EV_RIGHT) {
	MOVF	r0x00, W
	XORLW	0x03
	BNZ	_00193_DS_
;	.line	189; stateMachine.c	setTime(getTime() + 1);
	CALL	_getTime
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	INFSNZ	r0x01, F
	INCF	r0x02, F
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_setTime
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
_00193_DS_:
;	.line	191; stateMachine.c	if (event == EV_LEFT) {
	MOVF	r0x00, W
	XORLW	0x02
	BNZ	_00195_DS_
;	.line	192; stateMachine.c	setTime(getTime() - 1);
	CALL	_getTime
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVLW	0xff
	ADDWF	r0x01, F
	ADDWFC	r0x02, F
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_setTime
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
_00195_DS_:
;	.line	196; stateMachine.c	if (event == EV_ENTER) {
	MOVF	r0x00, W
	XORLW	0x04
	BNZ	_00197_DS_
;	.line	197; stateMachine.c	setState(STATE_TIME);
	MOVLW	0x08
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00197_DS_:
;	.line	199; stateMachine.c	if (event == EV_RESET) {
	MOVF	r0x00, W
	XORLW	0x05
	BZ	_00456_DS_
	BRA	_00222_DS_
_00456_DS_:
;	.line	200; stateMachine.c	setStateRst(STATE_SET_T);
	MOVLW	0x09
	MOVWF	POSTDEC1
	CALL	_setStateRst
	MOVF	POSTINC1, F
;	.line	201; stateMachine.c	setState(STATE_RST);
	MOVLW	0x0c
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
;	.line	203; stateMachine.c	break;
	BRA	_00222_DS_
_00200_DS_:
;	.line	207; stateMachine.c	if (event == EV_RIGHT) {
	MOVF	r0x00, W
	XORLW	0x03
	BNZ	_00202_DS_
;	.line	208; stateMachine.c	setState(STATE_DATE);
	MOVLW	0x0b
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00202_DS_:
;	.line	210; stateMachine.c	if (event == EV_LEFT) {
	MOVF	r0x00, W
	XORLW	0x02
	BNZ	_00204_DS_
;	.line	211; stateMachine.c	setState(STATE_TIME);
	MOVLW	0x08
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00204_DS_:
;	.line	215; stateMachine.c	if (event == EV_ENTER) {
	MOVF	r0x00, W
	XORLW	0x04
	BNZ	_00206_DS_
;	.line	216; stateMachine.c	setIdiom(getIdiom() + 1);
	CALL	_getIdiom
	MOVWF	r0x01
	INCF	r0x01, F
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_setIdiom
	MOVF	POSTINC1, F
_00206_DS_:
;	.line	218; stateMachine.c	if (event == EV_RESET) {
	MOVF	r0x00, W
	XORLW	0x05
	BZ	_00464_DS_
	BRA	_00222_DS_
_00464_DS_:
;	.line	219; stateMachine.c	setStateRst(STATE_IDIOM);
	MOVLW	0x0a
	MOVWF	POSTDEC1
	CALL	_setStateRst
	MOVF	POSTINC1, F
;	.line	220; stateMachine.c	setState(STATE_RST);
	MOVLW	0x0c
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
;	.line	222; stateMachine.c	break; 
	BRA	_00222_DS_
_00209_DS_:
;	.line	225; stateMachine.c	if (event == EV_RIGHT) {
	MOVF	r0x00, W
	XORLW	0x03
	BNZ	_00211_DS_
;	.line	226; stateMachine.c	setState(STATE_ALARM_HIGH_0);
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00211_DS_:
;	.line	228; stateMachine.c	if (event == EV_LEFT) {
	MOVF	r0x00, W
	XORLW	0x02
	BNZ	_00213_DS_
;	.line	229; stateMachine.c	setState(STATE_IDIOM);
	MOVLW	0x0a
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00213_DS_:
;	.line	233; stateMachine.c	if (event == EV_RESET) {
	MOVF	r0x00, W
	XORLW	0x05
	BNZ	_00222_DS_
;	.line	234; stateMachine.c	setStateRst(STATE_DATE);
	MOVLW	0x0b
	MOVWF	POSTDEC1
	CALL	_setStateRst
	MOVF	POSTINC1, F
;	.line	235; stateMachine.c	setState(STATE_RST);
	MOVLW	0x0c
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
;	.line	237; stateMachine.c	break; 
	BRA	_00222_DS_
_00216_DS_:
;	.line	242; stateMachine.c	if (event == EV_RIGHT) {
	MOVF	r0x00, W
	XORLW	0x03
	BNZ	_00218_DS_
;	.line	243; stateMachine.c	setState(getStateRst());
	CALL	_getStateRst
	MOVWF	r0x01
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00218_DS_:
;	.line	245; stateMachine.c	if (event == EV_LEFT) {
	MOVF	r0x00, W
	XORLW	0x02
	BNZ	_00222_DS_
;	.line	246; stateMachine.c	varInit();
	CALL	_varInit
;	.line	248; stateMachine.c	break;
	BRA	_00222_DS_
_00221_DS_:
;	.line	250; stateMachine.c	default: setState(STATE_ALARM_HIGH_0);
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00222_DS_:
;	.line	254; stateMachine.c	outputPrint(getState(), getIdiom());
	CALL	_getState
	MOVWF	r0x00
	CLRF	r0x01
	CALL	_getIdiom
	MOVWF	r0x02
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_outputPrint
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	255; stateMachine.c	outputSerial(getState(), getIdiom());
	CALL	_getState
	MOVWF	r0x00
	CLRF	r0x01
	CALL	_getIdiom
	MOVWF	r0x02
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_outputSerial
	MOVLW	0x03
	ADDWF	FSR1L, F
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_stateMachine__smInit	code
_smInit:
;	.line	8; stateMachine.c	void smInit(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	9; stateMachine.c	setState(STATE_TIME);    
	MOVLW	0x08
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
	MOVFF	PREINC1, FSR2L
	RETURN	



; Statistics:
; code size:	 1506 (0x05e2) bytes ( 1.15%)
;           	  753 (0x02f1) words
; udata size:	    1 (0x0001) bytes ( 0.06%)
; access size:	    3 (0x0003) bytes


	end
