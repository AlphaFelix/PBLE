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
	global	_outputInit
	global	_outputPrint
	global	_outputSerial

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern	_lcdCommand
	extern	_lcdData
	extern	_lcdInt
	extern	_lcdString
	extern	_lcdInit
	extern	_getState
	extern	_getTime
	extern	_getAlarmLow
	extern	_getAlarmHigh
	extern	_getIdiom
	extern	_adcInit
	extern	_adcScale
	extern	_serialSend
	extern	_serialInt
	extern	_serialString
	extern	_serialInit
	extern	_testAlarmHigh
	extern	_testAlarmLow
	extern	_BCD2UpperCh
	extern	_BCD2LowerCh
	extern	_rtcRead
	extern	__mulint

;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
STATUS	equ	0xfd8
WREG	equ	0xfe8
FSR0L	equ	0xfe9
FSR0H	equ	0xfea
FSR1L	equ	0xfe1
FSR2L	equ	0xfd9
INDF0	equ	0xfef
POSTINC0	equ	0xfee
POSTINC1	equ	0xfe6
POSTDEC1	equ	0xfe5
PREINC1	equ	0xfe4
PLUSW2	equ	0xfdb
PRODL	equ	0xff3


	idata
_msgs	db	LOW(___str_15), HIGH(___str_15), UPPER(___str_15), LOW(___str_16), HIGH(___str_16), UPPER(___str_16), LOW(___str_17), HIGH(___str_17), UPPER(___str_17), LOW(___str_18), HIGH(___str_18), UPPER(___str_18)
	db	LOW(___str_19), HIGH(___str_19), UPPER(___str_19), LOW(___str_20), HIGH(___str_20), UPPER(___str_20), LOW(___str_21), HIGH(___str_21), UPPER(___str_21), LOW(___str_22), HIGH(___str_22), UPPER(___str_22)
	db	LOW(___str_23), HIGH(___str_23), UPPER(___str_23), LOW(___str_24), HIGH(___str_24), UPPER(___str_24), LOW(___str_25), HIGH(___str_25), UPPER(___str_25), LOW(___str_26), HIGH(___str_26), UPPER(___str_26)
	db	LOW(___str_27), HIGH(___str_27), UPPER(___str_27), LOW(___str_28), HIGH(___str_28), UPPER(___str_28), LOW(___str_29), HIGH(___str_29), UPPER(___str_29), LOW(___str_30), HIGH(___str_30), UPPER(___str_30)
	db	LOW(___str_31), HIGH(___str_31), UPPER(___str_31), LOW(___str_32), HIGH(___str_32), UPPER(___str_32), LOW(___str_33), HIGH(___str_33), UPPER(___str_33), LOW(___str_34), HIGH(___str_34), UPPER(___str_34)
	db	LOW(___str_35), HIGH(___str_35), UPPER(___str_35), LOW(___str_36), HIGH(___str_36), UPPER(___str_36), LOW(___str_37), HIGH(___str_37), UPPER(___str_37), LOW(___str_38), HIGH(___str_38), UPPER(___str_38)
	db	LOW(___str_39), HIGH(___str_39), UPPER(___str_39), LOW(___str_40), HIGH(___str_40), UPPER(___str_40)
_serial	db	LOW(___str_41), HIGH(___str_41), UPPER(___str_41), LOW(___str_42), HIGH(___str_42), UPPER(___str_42), LOW(___str_43), HIGH(___str_43), UPPER(___str_43), LOW(___str_44), HIGH(___str_44), UPPER(___str_44)
	db	LOW(___str_45), HIGH(___str_45), UPPER(___str_45), LOW(___str_46), HIGH(___str_46), UPPER(___str_46), LOW(___str_47), HIGH(___str_47), UPPER(___str_47), LOW(___str_48), HIGH(___str_48), UPPER(___str_48)
	db	LOW(___str_49), HIGH(___str_49), UPPER(___str_49), LOW(___str_50), HIGH(___str_50), UPPER(___str_50)


; Internal registers
.registers	udata_ovr	0x0000
r0x00	res	1
r0x01	res	1
r0x02	res	1
r0x03	res	1
r0x04	res	1
r0x05	res	1
r0x06	res	1
r0x07	res	1
r0x08	res	1
r0x09	res	1
r0x0a	res	1
r0x0b	res	1
r0x0c	res	1
r0x0d	res	1
r0x0e	res	1

udata_output_0	udata
_state_ant	res	1

udata_output_1	udata
_language_ant	res	1

udata_output_2	udata
_time_ant	res	2

udata_output_3	udata
_alarmLow_ant	res	2

udata_output_4	udata
_alarmHigh_ant	res	2

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_output__outputSerial	code
_outputSerial:
;	.line	233; output.c	void outputSerial(int numTela, char idiom) {    
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	MOVFF	r0x07, POSTDEC1
	MOVFF	r0x08, POSTDEC1
	MOVFF	r0x09, POSTDEC1
	MOVFF	r0x0a, POSTDEC1
	MOVFF	r0x0b, POSTDEC1
	MOVFF	r0x0c, POSTDEC1
	MOVFF	r0x0d, POSTDEC1
	MOVFF	r0x0e, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
;	.line	236; output.c	state = getState();
	CALL	_getState
	MOVWF	r0x03
;	.line	237; output.c	language = getIdiom();
	CALL	_getIdiom
	MOVWF	r0x04
;	.line	238; output.c	time = getTime();
	CALL	_getTime
	MOVWF	r0x05
	MOVFF	PRODL, r0x06
;	.line	239; output.c	alarmLow = getAlarmLow(0);
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_getAlarmLow
	MOVWF	r0x07
	MOVFF	PRODL, r0x08
	MOVF	POSTINC1, F
;	.line	240; output.c	alarmHigh = getAlarmHigh(0);
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_getAlarmHigh
	MOVWF	r0x09
	MOVFF	PRODL, r0x0a
	MOVF	POSTINC1, F
;	.line	242; output.c	if (state != state_ant) {
	MOVF	r0x03, W
	BANKSEL	_state_ant
	XORWF	_state_ant, W, B
	BNZ	_00316_DS_
	BRA	_00294_DS_
; ;multiply lit val:0x03 by variable r0x02 and store in r0x0b
_00316_DS_:
;	.line	243; output.c	serialString(serial[SERIAL_S][idiom]);
	MOVF	r0x02, W
	MULLW	0x03
	MOVFF	PRODL, r0x0b
	MOVLW	LOW(_serial)
	ADDWF	r0x0b, W
	MOVWF	r0x0c
	CLRF	r0x0d
	MOVLW	HIGH(_serial)
	ADDWFC	r0x0d, F
	MOVFF	r0x0c, FSR0L
	MOVFF	r0x0d, FSR0H
	MOVFF	POSTINC0, r0x0c
	MOVFF	POSTINC0, r0x0d
	MOVFF	INDF0, r0x0e
	MOVF	r0x0e, W
	MOVWF	POSTDEC1
	MOVF	r0x0d, W
	MOVWF	POSTDEC1
	MOVF	r0x0c, W
	MOVWF	POSTDEC1
	CALL	_serialString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	244; output.c	serialString(msgs[numTela][idiom]);
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_msgs)
	ADDWF	r0x00, F
	MOVLW	HIGH(_msgs)
	ADDWFC	r0x01, F
	CLRF	r0x0c
	MOVF	r0x00, W
	ADDWF	r0x0b, F
	MOVF	r0x01, W
	ADDWFC	r0x0c, F
	MOVFF	r0x0b, FSR0L
	MOVFF	r0x0c, FSR0H
	MOVFF	POSTINC0, r0x0b
	MOVFF	POSTINC0, r0x0c
	MOVFF	INDF0, r0x00
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVF	r0x0c, W
	MOVWF	POSTDEC1
	MOVF	r0x0b, W
	MOVWF	POSTDEC1
	CALL	_serialString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	245; output.c	serialSend(13);
	MOVLW	0x0d
	MOVWF	POSTDEC1
	CALL	_serialSend
	MOVF	POSTINC1, F
_00294_DS_:
;	.line	247; output.c	if (alarmHigh != alarmHigh_ant) {
	MOVF	r0x09, W
	MOVWF	r0x00
	MOVF	r0x0a, W
	MOVWF	r0x01
	MOVF	r0x00, W
	BANKSEL	_alarmHigh_ant
	XORWF	_alarmHigh_ant, W, B
	BNZ	_00318_DS_
	MOVF	r0x01, W
	BANKSEL	(_alarmHigh_ant + 1)
	XORWF	(_alarmHigh_ant + 1), W, B
	BZ	_00296_DS_
; ;multiply lit val:0x03 by variable r0x02 and store in r0x00
_00318_DS_:
;	.line	248; output.c	serialString(serial[SERIAL_AH][idiom]);
	MOVF	r0x02, W
	MULLW	0x03
	MOVFF	PRODL, r0x00
	CLRF	r0x01
	MOVLW	LOW(_serial + 6)
	ADDWF	r0x00, F
	MOVLW	HIGH(_serial + 6)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVFF	POSTINC0, r0x00
	MOVFF	POSTINC0, r0x01
	MOVFF	INDF0, r0x0b
	MOVF	r0x0b, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_serialString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	249; output.c	serialInt(alarmHigh);
	MOVF	r0x0a, W
	MOVWF	POSTDEC1
	MOVF	r0x09, W
	MOVWF	POSTDEC1
	CALL	_serialInt
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	250; output.c	serialSend(13);
	MOVLW	0x0d
	MOVWF	POSTDEC1
	CALL	_serialSend
	MOVF	POSTINC1, F
_00296_DS_:
;	.line	252; output.c	if (alarmLow != alarmLow_ant) {
	MOVF	r0x07, W
	MOVWF	r0x00
	MOVF	r0x08, W
	MOVWF	r0x01
	MOVF	r0x00, W
	BANKSEL	_alarmLow_ant
	XORWF	_alarmLow_ant, W, B
	BNZ	_00320_DS_
	MOVF	r0x01, W
	BANKSEL	(_alarmLow_ant + 1)
	XORWF	(_alarmLow_ant + 1), W, B
	BZ	_00298_DS_
; ;multiply lit val:0x03 by variable r0x02 and store in r0x00
_00320_DS_:
;	.line	253; output.c	serialString(serial[SERIAL_AL][idiom]);
	MOVF	r0x02, W
	MULLW	0x03
	MOVFF	PRODL, r0x00
	CLRF	r0x01
	MOVLW	LOW(_serial + 12)
	ADDWF	r0x00, F
	MOVLW	HIGH(_serial + 12)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVFF	POSTINC0, r0x00
	MOVFF	POSTINC0, r0x01
	MOVFF	INDF0, r0x0b
	MOVF	r0x0b, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_serialString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	254; output.c	serialInt(alarmLow);
	MOVF	r0x08, W
	MOVWF	POSTDEC1
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	CALL	_serialInt
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	255; output.c	serialSend(13);
	MOVLW	0x0d
	MOVWF	POSTDEC1
	CALL	_serialSend
	MOVF	POSTINC1, F
_00298_DS_:
;	.line	257; output.c	if (time != time_ant) {
	MOVF	r0x05, W
	MOVWF	r0x00
	MOVF	r0x06, W
	MOVWF	r0x01
	MOVF	r0x00, W
	BANKSEL	_time_ant
	XORWF	_time_ant, W, B
	BNZ	_00322_DS_
	MOVF	r0x01, W
	BANKSEL	(_time_ant + 1)
	XORWF	(_time_ant + 1), W, B
	BZ	_00300_DS_
; ;multiply lit val:0x03 by variable r0x02 and store in r0x02
_00322_DS_:
;	.line	258; output.c	serialString(serial[SERIAL_T][idiom]);
	MOVF	r0x02, W
	MULLW	0x03
	MOVFF	PRODL, r0x02
	CLRF	r0x00
	MOVLW	LOW(_serial + 18)
	ADDWF	r0x02, F
	MOVLW	HIGH(_serial + 18)
	ADDWFC	r0x00, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x00, FSR0H
	MOVFF	POSTINC0, r0x02
	MOVFF	POSTINC0, r0x00
	MOVFF	INDF0, r0x01
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	_serialString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	259; output.c	serialInt(time);
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	CALL	_serialInt
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	260; output.c	serialSend(13);
	MOVLW	0x0d
	MOVWF	POSTDEC1
	CALL	_serialSend
	MOVF	POSTINC1, F
_00300_DS_:
;	.line	264; output.c	state_ant = state;
	MOVFF	r0x03, _state_ant
;	.line	265; output.c	language_ant = language;
	MOVFF	r0x04, _language_ant
;	.line	266; output.c	time_ant = time;
	MOVFF	r0x05, _time_ant
	MOVFF	r0x06, (_time_ant + 1)
;	.line	267; output.c	alarmLow_ant = alarmLow;
	MOVFF	r0x07, _alarmLow_ant
	MOVFF	r0x08, (_alarmLow_ant + 1)
;	.line	268; output.c	alarmHigh_ant = alarmHigh;
	MOVFF	r0x09, _alarmHigh_ant
	MOVFF	r0x0a, (_alarmHigh_ant + 1)
	MOVFF	PREINC1, r0x0e
	MOVFF	PREINC1, r0x0d
	MOVFF	PREINC1, r0x0c
	MOVFF	PREINC1, r0x0b
	MOVFF	PREINC1, r0x0a
	MOVFF	PREINC1, r0x09
	MOVFF	PREINC1, r0x08
	MOVFF	PREINC1, r0x07
	MOVFF	PREINC1, r0x06
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_output__outputPrint	code
_outputPrint:
;	.line	59; output.c	void outputPrint(int numTela, char idiom) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	MOVFF	r0x07, POSTDEC1
	MOVFF	r0x08, POSTDEC1
	MOVFF	r0x09, POSTDEC1
	MOVFF	r0x0a, POSTDEC1
	MOVFF	r0x0b, POSTDEC1
	MOVFF	r0x0c, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
;	.line	62; output.c	adcInit();
	CALL	_adcInit
;	.line	63; output.c	testHigh0 = testAlarmHigh(0);
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_testAlarmHigh
	MOVWF	r0x03
	MOVF	POSTINC1, F
;	.line	64; output.c	testLow0 = testAlarmLow(0);
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_testAlarmLow
	MOVWF	r0x04
	MOVF	POSTINC1, F
;	.line	65; output.c	testHigh1 = testAlarmHigh(1);
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_testAlarmHigh
	MOVWF	r0x05
	MOVF	POSTINC1, F
;	.line	66; output.c	testLow1 = testAlarmLow(1);
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_testAlarmLow
	MOVWF	r0x06
	MOVF	POSTINC1, F
;	.line	68; output.c	if (numTela == STATE_ALARM_HIGH_0) {
	MOVF	r0x00, W
	IORWF	r0x01, W
	BTFSS	STATUS, 2
	BRA	_00114_DS_
;	.line	69; output.c	lcdCommand(0x80);
	MOVLW	0x80
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	70; output.c	lcdString(msgs[numTela][idiom]);
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x07
	MOVFF	PRODL, r0x08
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_msgs)
	ADDWF	r0x07, F
	MOVLW	HIGH(_msgs)
	ADDWFC	r0x08, F
; ;multiply lit val:0x03 by variable r0x02 and store in r0x09
	MOVF	r0x02, W
	MULLW	0x03
	MOVFF	PRODL, r0x09
	MOVF	r0x09, W
	ADDWF	r0x07, F
	CLRF	WREG
	ADDWFC	r0x08, F
	MOVFF	r0x07, FSR0L
	MOVFF	r0x08, FSR0H
	MOVFF	POSTINC0, r0x07
	MOVFF	POSTINC0, r0x08
	MOVFF	INDF0, r0x09
	MOVF	r0x09, W
	MOVWF	POSTDEC1
	MOVF	r0x08, W
	MOVWF	POSTDEC1
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	71; output.c	lcdCommand(0xC0);         
	MOVLW	0xc0
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	72; output.c	lcdInt(getAlarmHigh(0));
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_getAlarmHigh
	MOVWF	r0x07
	MOVFF	PRODL, r0x08
	MOVF	POSTINC1, F
	MOVF	r0x08, W
	MOVWF	POSTDEC1
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	CALL	_lcdInt
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	73; output.c	lcdString("         ");
	MOVLW	UPPER(___str_0)
	MOVWF	r0x09
	MOVLW	HIGH(___str_0)
	MOVWF	r0x08
	MOVLW	LOW(___str_0)
	MOVWF	r0x07
	MOVF	r0x09, W
	MOVWF	POSTDEC1
	MOVF	r0x08, W
	MOVWF	POSTDEC1
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	74; output.c	if(testHigh0 == 1)
	MOVF	r0x03, W
	XORLW	0x01
	BNZ	_00111_DS_
;	.line	75; output.c	lcdString(" ON ");
	MOVLW	UPPER(___str_1)
	MOVWF	r0x09
	MOVLW	HIGH(___str_1)
	MOVWF	r0x08
	MOVLW	LOW(___str_1)
	MOVWF	r0x07
	MOVF	r0x09, W
	MOVWF	POSTDEC1
	MOVF	r0x08, W
	MOVWF	POSTDEC1
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
	BRA	_00114_DS_
_00111_DS_:
;	.line	77; output.c	lcdString("OFF ");       
	MOVLW	UPPER(___str_2)
	MOVWF	r0x09
	MOVLW	HIGH(___str_2)
	MOVWF	r0x08
	MOVLW	LOW(___str_2)
	MOVWF	r0x07
	MOVF	r0x09, W
	MOVWF	POSTDEC1
	MOVF	r0x08, W
	MOVWF	POSTDEC1
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00114_DS_:
;	.line	79; output.c	if (numTela == STATE_SET_AH_0) {
	MOVF	r0x00, W
	XORLW	0x01
	BNZ	_00247_DS_
	MOVF	r0x01, W
	BZ	_00248_DS_
_00247_DS_:
	BRA	_00119_DS_
_00248_DS_:
;	.line	80; output.c	lcdCommand(0x80);
	MOVLW	0x80
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	81; output.c	lcdString(msgs[numTela][idiom]);
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x07
	MOVFF	PRODL, r0x08
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_msgs)
	ADDWF	r0x07, F
	MOVLW	HIGH(_msgs)
	ADDWFC	r0x08, F
; ;multiply lit val:0x03 by variable r0x02 and store in r0x09
	MOVF	r0x02, W
	MULLW	0x03
	MOVFF	PRODL, r0x09
	MOVF	r0x09, W
	ADDWF	r0x07, F
	CLRF	WREG
	ADDWFC	r0x08, F
	MOVFF	r0x07, FSR0L
	MOVFF	r0x08, FSR0H
	MOVFF	POSTINC0, r0x07
	MOVFF	POSTINC0, r0x08
	MOVFF	INDF0, r0x09
	MOVF	r0x09, W
	MOVWF	POSTDEC1
	MOVF	r0x08, W
	MOVWF	POSTDEC1
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	82; output.c	lcdCommand(0xC0);        
	MOVLW	0xc0
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	83; output.c	lcdInt(getAlarmHigh(0));        
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_getAlarmHigh
	MOVWF	r0x07
	MOVFF	PRODL, r0x08
	MOVF	POSTINC1, F
	MOVF	r0x08, W
	MOVWF	POSTDEC1
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	CALL	_lcdInt
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	84; output.c	if(testHigh0 == 1)
	MOVF	r0x03, W
	XORLW	0x01
	BNZ	_00116_DS_
;	.line	85; output.c	lcdString(" ON  ");
	MOVLW	UPPER(___str_3)
	MOVWF	r0x08
	MOVLW	HIGH(___str_3)
	MOVWF	r0x07
	MOVLW	LOW(___str_3)
	MOVWF	r0x03
	MOVF	r0x08, W
	MOVWF	POSTDEC1
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
	BRA	_00117_DS_
_00116_DS_:
;	.line	87; output.c	lcdString(" OFF ");
	MOVLW	UPPER(___str_4)
	MOVWF	r0x08
	MOVLW	HIGH(___str_4)
	MOVWF	r0x07
	MOVLW	LOW(___str_4)
	MOVWF	r0x03
	MOVF	r0x08, W
	MOVWF	POSTDEC1
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00117_DS_:
;	.line	88; output.c	lcdString("A0:");
	MOVLW	UPPER(___str_5)
	MOVWF	r0x08
	MOVLW	HIGH(___str_5)
	MOVWF	r0x07
	MOVLW	LOW(___str_5)
	MOVWF	r0x03
	MOVF	r0x08, W
	MOVWF	POSTDEC1
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	89; output.c	lcdInt(adcScale(POT, 1000));
	MOVLW	0x44
	MOVWF	POSTDEC1
	MOVLW	0x7a
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x02
	MOVWF	POSTDEC1
	CALL	_adcScale
	MOVWF	r0x03
	MOVFF	PRODL, r0x07
	MOVLW	0x05
	ADDWF	FSR1L, F
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdInt
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
_00119_DS_:
;	.line	91; output.c	if (numTela == STATE_ALARM_LOW_0) {
	MOVF	r0x00, W
	XORLW	0x02
	BNZ	_00251_DS_
	MOVF	r0x01, W
	BZ	_00252_DS_
_00251_DS_:
	BRA	_00124_DS_
_00252_DS_:
;	.line	92; output.c	lcdCommand(0x80);
	MOVLW	0x80
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	93; output.c	lcdString(msgs[numTela][idiom]);
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x03
	MOVFF	PRODL, r0x07
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_msgs)
	ADDWF	r0x03, F
	MOVLW	HIGH(_msgs)
	ADDWFC	r0x07, F
; ;multiply lit val:0x03 by variable r0x02 and store in r0x08
	MOVF	r0x02, W
	MULLW	0x03
	MOVFF	PRODL, r0x08
	MOVF	r0x08, W
	ADDWF	r0x03, F
	CLRF	WREG
	ADDWFC	r0x07, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x07, FSR0H
	MOVFF	POSTINC0, r0x03
	MOVFF	POSTINC0, r0x07
	MOVFF	INDF0, r0x08
	MOVF	r0x08, W
	MOVWF	POSTDEC1
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	94; output.c	lcdCommand(0xC0);
	MOVLW	0xc0
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	95; output.c	lcdInt(getAlarmLow(0));
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_getAlarmLow
	MOVWF	r0x03
	MOVFF	PRODL, r0x07
	MOVF	POSTINC1, F
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdInt
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	96; output.c	lcdString("         ");
	MOVLW	UPPER(___str_0)
	MOVWF	r0x08
	MOVLW	HIGH(___str_0)
	MOVWF	r0x07
	MOVLW	LOW(___str_0)
	MOVWF	r0x03
	MOVF	r0x08, W
	MOVWF	POSTDEC1
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	97; output.c	if(testLow0 == 1)
	MOVF	r0x04, W
	XORLW	0x01
	BNZ	_00121_DS_
;	.line	98; output.c	lcdString(" ON ");
	MOVLW	UPPER(___str_1)
	MOVWF	r0x08
	MOVLW	HIGH(___str_1)
	MOVWF	r0x07
	MOVLW	LOW(___str_1)
	MOVWF	r0x03
	MOVF	r0x08, W
	MOVWF	POSTDEC1
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
	BRA	_00124_DS_
_00121_DS_:
;	.line	100; output.c	lcdString("OFF "); 
	MOVLW	UPPER(___str_2)
	MOVWF	r0x08
	MOVLW	HIGH(___str_2)
	MOVWF	r0x07
	MOVLW	LOW(___str_2)
	MOVWF	r0x03
	MOVF	r0x08, W
	MOVWF	POSTDEC1
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00124_DS_:
;	.line	102; output.c	if (numTela == STATE_SET_AL_0) {
	MOVF	r0x00, W
	XORLW	0x03
	BNZ	_00255_DS_
	MOVF	r0x01, W
	BZ	_00256_DS_
_00255_DS_:
	BRA	_00129_DS_
_00256_DS_:
;	.line	103; output.c	lcdCommand(0x80);
	MOVLW	0x80
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	104; output.c	lcdString(msgs[numTela][idiom]);
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x03
	MOVFF	PRODL, r0x07
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_msgs)
	ADDWF	r0x03, F
	MOVLW	HIGH(_msgs)
	ADDWFC	r0x07, F
; ;multiply lit val:0x03 by variable r0x02 and store in r0x08
	MOVF	r0x02, W
	MULLW	0x03
	MOVFF	PRODL, r0x08
	MOVF	r0x08, W
	ADDWF	r0x03, F
	CLRF	WREG
	ADDWFC	r0x07, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x07, FSR0H
	MOVFF	POSTINC0, r0x03
	MOVFF	POSTINC0, r0x07
	MOVFF	INDF0, r0x08
	MOVF	r0x08, W
	MOVWF	POSTDEC1
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	105; output.c	lcdCommand(0xC0);
	MOVLW	0xc0
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	106; output.c	lcdInt(getAlarmLow(0));        
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_getAlarmLow
	MOVWF	r0x03
	MOVFF	PRODL, r0x07
	MOVF	POSTINC1, F
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdInt
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	107; output.c	if(testLow0 == 1)
	MOVF	r0x04, W
	XORLW	0x01
	BNZ	_00126_DS_
;	.line	108; output.c	lcdString(" ON  ");
	MOVLW	UPPER(___str_3)
	MOVWF	r0x07
	MOVLW	HIGH(___str_3)
	MOVWF	r0x04
	MOVLW	LOW(___str_3)
	MOVWF	r0x03
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
	BRA	_00127_DS_
_00126_DS_:
;	.line	110; output.c	lcdString(" OFF ");
	MOVLW	UPPER(___str_4)
	MOVWF	r0x07
	MOVLW	HIGH(___str_4)
	MOVWF	r0x04
	MOVLW	LOW(___str_4)
	MOVWF	r0x03
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00127_DS_:
;	.line	111; output.c	lcdString("A0:");
	MOVLW	UPPER(___str_5)
	MOVWF	r0x07
	MOVLW	HIGH(___str_5)
	MOVWF	r0x04
	MOVLW	LOW(___str_5)
	MOVWF	r0x03
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	112; output.c	lcdInt(adcScale(POT, 1020));
	MOVLW	0x44
	MOVWF	POSTDEC1
	MOVLW	0x7f
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x02
	MOVWF	POSTDEC1
	CALL	_adcScale
	MOVWF	r0x03
	MOVFF	PRODL, r0x04
	MOVLW	0x05
	ADDWF	FSR1L, F
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdInt
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
_00129_DS_:
;	.line	114; output.c	if (numTela == STATE_ALARM_HIGH_1) {
	MOVF	r0x00, W
	XORLW	0x04
	BNZ	_00259_DS_
	MOVF	r0x01, W
	BZ	_00260_DS_
_00259_DS_:
	BRA	_00134_DS_
_00260_DS_:
;	.line	115; output.c	lcdCommand(0x80);
	MOVLW	0x80
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	116; output.c	lcdString(msgs[numTela][idiom]);
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x03
	MOVFF	PRODL, r0x04
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_msgs)
	ADDWF	r0x03, F
	MOVLW	HIGH(_msgs)
	ADDWFC	r0x04, F
; ;multiply lit val:0x03 by variable r0x02 and store in r0x07
	MOVF	r0x02, W
	MULLW	0x03
	MOVFF	PRODL, r0x07
	MOVF	r0x07, W
	ADDWF	r0x03, F
	CLRF	WREG
	ADDWFC	r0x04, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVFF	POSTINC0, r0x03
	MOVFF	POSTINC0, r0x04
	MOVFF	INDF0, r0x07
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	117; output.c	lcdCommand(0xC0);
	MOVLW	0xc0
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	118; output.c	lcdInt(getAlarmHigh(1));
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_getAlarmHigh
	MOVWF	r0x03
	MOVFF	PRODL, r0x04
	MOVF	POSTINC1, F
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdInt
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	119; output.c	lcdString("         ");
	MOVLW	UPPER(___str_0)
	MOVWF	r0x07
	MOVLW	HIGH(___str_0)
	MOVWF	r0x04
	MOVLW	LOW(___str_0)
	MOVWF	r0x03
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	120; output.c	if(testHigh1 == 1)
	MOVF	r0x05, W
	XORLW	0x01
	BNZ	_00131_DS_
;	.line	121; output.c	lcdString(" ON ");
	MOVLW	UPPER(___str_1)
	MOVWF	r0x07
	MOVLW	HIGH(___str_1)
	MOVWF	r0x04
	MOVLW	LOW(___str_1)
	MOVWF	r0x03
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
	BRA	_00134_DS_
_00131_DS_:
;	.line	123; output.c	lcdString("OFF "); 
	MOVLW	UPPER(___str_2)
	MOVWF	r0x07
	MOVLW	HIGH(___str_2)
	MOVWF	r0x04
	MOVLW	LOW(___str_2)
	MOVWF	r0x03
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00134_DS_:
;	.line	125; output.c	if (numTela == STATE_SET_AH_1) {
	MOVF	r0x00, W
	XORLW	0x05
	BNZ	_00263_DS_
	MOVF	r0x01, W
	BZ	_00264_DS_
_00263_DS_:
	BRA	_00139_DS_
_00264_DS_:
;	.line	126; output.c	lcdCommand(0x80);
	MOVLW	0x80
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	127; output.c	lcdString(msgs[numTela][idiom]);
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x03
	MOVFF	PRODL, r0x04
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_msgs)
	ADDWF	r0x03, F
	MOVLW	HIGH(_msgs)
	ADDWFC	r0x04, F
; ;multiply lit val:0x03 by variable r0x02 and store in r0x07
	MOVF	r0x02, W
	MULLW	0x03
	MOVFF	PRODL, r0x07
	MOVF	r0x07, W
	ADDWF	r0x03, F
	CLRF	WREG
	ADDWFC	r0x04, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVFF	POSTINC0, r0x03
	MOVFF	POSTINC0, r0x04
	MOVFF	INDF0, r0x07
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	128; output.c	lcdCommand(0xC0);
	MOVLW	0xc0
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	129; output.c	lcdInt(getAlarmHigh(1));
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_getAlarmHigh
	MOVWF	r0x03
	MOVFF	PRODL, r0x04
	MOVF	POSTINC1, F
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdInt
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	130; output.c	if(testHigh1 == 1)
	MOVF	r0x05, W
	XORLW	0x01
	BNZ	_00136_DS_
;	.line	131; output.c	lcdString(" ON  ");
	MOVLW	UPPER(___str_3)
	MOVWF	r0x05
	MOVLW	HIGH(___str_3)
	MOVWF	r0x04
	MOVLW	LOW(___str_3)
	MOVWF	r0x03
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
	BRA	_00137_DS_
_00136_DS_:
;	.line	133; output.c	lcdString(" OFF ");
	MOVLW	UPPER(___str_4)
	MOVWF	r0x05
	MOVLW	HIGH(___str_4)
	MOVWF	r0x04
	MOVLW	LOW(___str_4)
	MOVWF	r0x03
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00137_DS_:
;	.line	134; output.c	lcdString("A1:");
	MOVLW	UPPER(___str_6)
	MOVWF	r0x05
	MOVLW	HIGH(___str_6)
	MOVWF	r0x04
	MOVLW	LOW(___str_6)
	MOVWF	r0x03
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	135; output.c	lcdInt(adcScale(POT, 1020));         
	MOVLW	0x44
	MOVWF	POSTDEC1
	MOVLW	0x7f
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x02
	MOVWF	POSTDEC1
	CALL	_adcScale
	MOVWF	r0x03
	MOVFF	PRODL, r0x04
	MOVLW	0x05
	ADDWF	FSR1L, F
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdInt
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
_00139_DS_:
;	.line	137; output.c	if (numTela == STATE_ALARM_LOW_1) {
	MOVF	r0x00, W
	XORLW	0x06
	BNZ	_00267_DS_
	MOVF	r0x01, W
	BZ	_00268_DS_
_00267_DS_:
	BRA	_00144_DS_
_00268_DS_:
;	.line	138; output.c	lcdCommand(0x80);
	MOVLW	0x80
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	139; output.c	lcdString(msgs[numTela][idiom]);
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x03
	MOVFF	PRODL, r0x04
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_msgs)
	ADDWF	r0x03, F
	MOVLW	HIGH(_msgs)
	ADDWFC	r0x04, F
; ;multiply lit val:0x03 by variable r0x02 and store in r0x05
	MOVF	r0x02, W
	MULLW	0x03
	MOVFF	PRODL, r0x05
	MOVF	r0x05, W
	ADDWF	r0x03, F
	CLRF	WREG
	ADDWFC	r0x04, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVFF	POSTINC0, r0x03
	MOVFF	POSTINC0, r0x04
	MOVFF	INDF0, r0x05
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	140; output.c	lcdCommand(0xC0);
	MOVLW	0xc0
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	142; output.c	lcdInt(getAlarmLow(1));
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_getAlarmLow
	MOVWF	r0x03
	MOVFF	PRODL, r0x04
	MOVF	POSTINC1, F
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdInt
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	143; output.c	lcdString("         ");
	MOVLW	UPPER(___str_0)
	MOVWF	r0x05
	MOVLW	HIGH(___str_0)
	MOVWF	r0x04
	MOVLW	LOW(___str_0)
	MOVWF	r0x03
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	144; output.c	if(testLow1 == 1)
	MOVF	r0x06, W
	XORLW	0x01
	BNZ	_00141_DS_
;	.line	145; output.c	lcdString(" ON ");
	MOVLW	UPPER(___str_1)
	MOVWF	r0x05
	MOVLW	HIGH(___str_1)
	MOVWF	r0x04
	MOVLW	LOW(___str_1)
	MOVWF	r0x03
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
	BRA	_00144_DS_
_00141_DS_:
;	.line	147; output.c	lcdString("OFF "); 
	MOVLW	UPPER(___str_2)
	MOVWF	r0x05
	MOVLW	HIGH(___str_2)
	MOVWF	r0x04
	MOVLW	LOW(___str_2)
	MOVWF	r0x03
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00144_DS_:
;	.line	149; output.c	if (numTela == STATE_SET_AL_1) {
	MOVF	r0x00, W
	XORLW	0x07
	BNZ	_00271_DS_
	MOVF	r0x01, W
	BZ	_00272_DS_
_00271_DS_:
	BRA	_00149_DS_
_00272_DS_:
;	.line	150; output.c	lcdCommand(0x80);
	MOVLW	0x80
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	151; output.c	lcdString(msgs[numTela][idiom]);
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x03
	MOVFF	PRODL, r0x04
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_msgs)
	ADDWF	r0x03, F
	MOVLW	HIGH(_msgs)
	ADDWFC	r0x04, F
; ;multiply lit val:0x03 by variable r0x02 and store in r0x05
	MOVF	r0x02, W
	MULLW	0x03
	MOVFF	PRODL, r0x05
	MOVF	r0x05, W
	ADDWF	r0x03, F
	CLRF	WREG
	ADDWFC	r0x04, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVFF	POSTINC0, r0x03
	MOVFF	POSTINC0, r0x04
	MOVFF	INDF0, r0x05
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	152; output.c	lcdCommand(0xC0);
	MOVLW	0xc0
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	153; output.c	lcdInt(getAlarmLow(1));
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_getAlarmLow
	MOVWF	r0x03
	MOVFF	PRODL, r0x04
	MOVF	POSTINC1, F
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdInt
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	154; output.c	if(testLow1 == 1)
	MOVF	r0x06, W
	XORLW	0x01
	BNZ	_00146_DS_
;	.line	155; output.c	lcdString(" ON  ");
	MOVLW	UPPER(___str_3)
	MOVWF	r0x05
	MOVLW	HIGH(___str_3)
	MOVWF	r0x04
	MOVLW	LOW(___str_3)
	MOVWF	r0x03
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
	BRA	_00147_DS_
_00146_DS_:
;	.line	157; output.c	lcdString(" OFF ");
	MOVLW	UPPER(___str_4)
	MOVWF	r0x05
	MOVLW	HIGH(___str_4)
	MOVWF	r0x04
	MOVLW	LOW(___str_4)
	MOVWF	r0x03
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00147_DS_:
;	.line	158; output.c	lcdString("A1:");
	MOVLW	UPPER(___str_6)
	MOVWF	r0x05
	MOVLW	HIGH(___str_6)
	MOVWF	r0x04
	MOVLW	LOW(___str_6)
	MOVWF	r0x03
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	159; output.c	lcdInt(adcScale(POT, 1020));         
	MOVLW	0x44
	MOVWF	POSTDEC1
	MOVLW	0x7f
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x02
	MOVWF	POSTDEC1
	CALL	_adcScale
	MOVWF	r0x03
	MOVFF	PRODL, r0x04
	MOVLW	0x05
	ADDWF	FSR1L, F
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdInt
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
_00149_DS_:
;	.line	161; output.c	if (numTela == STATE_TIME) {
	MOVF	r0x00, W
	XORLW	0x08
	BNZ	_00275_DS_
	MOVF	r0x01, W
	BZ	_00276_DS_
_00275_DS_:
	BRA	_00151_DS_
_00276_DS_:
;	.line	162; output.c	lcdCommand(0x80);
	MOVLW	0x80
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	163; output.c	lcdString(msgs[numTela][idiom]);
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x03
	MOVFF	PRODL, r0x04
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_msgs)
	ADDWF	r0x03, F
	MOVLW	HIGH(_msgs)
	ADDWFC	r0x04, F
; ;multiply lit val:0x03 by variable r0x02 and store in r0x05
	MOVF	r0x02, W
	MULLW	0x03
	MOVFF	PRODL, r0x05
	MOVF	r0x05, W
	ADDWF	r0x03, F
	CLRF	WREG
	ADDWFC	r0x04, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVFF	POSTINC0, r0x03
	MOVFF	POSTINC0, r0x04
	MOVFF	INDF0, r0x05
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	164; output.c	lcdCommand(0xC0);
	MOVLW	0xc0
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	165; output.c	lcdInt(getTime());
	CALL	_getTime
	MOVWF	r0x03
	MOVFF	PRODL, r0x04
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdInt
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	166; output.c	lcdString(" ms");
	MOVLW	UPPER(___str_7)
	MOVWF	r0x05
	MOVLW	HIGH(___str_7)
	MOVWF	r0x04
	MOVLW	LOW(___str_7)
	MOVWF	r0x03
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	167; output.c	lcdString("            ");//para apagar os textos depois do numero
	MOVLW	UPPER(___str_8)
	MOVWF	r0x05
	MOVLW	HIGH(___str_8)
	MOVWF	r0x04
	MOVLW	LOW(___str_8)
	MOVWF	r0x03
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00151_DS_:
;	.line	169; output.c	if (numTela == STATE_SET_T) {
	MOVF	r0x00, W
	XORLW	0x09
	BNZ	_00277_DS_
	MOVF	r0x01, W
	BZ	_00278_DS_
_00277_DS_:
	BRA	_00153_DS_
_00278_DS_:
;	.line	170; output.c	lcdCommand(0x80);
	MOVLW	0x80
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	171; output.c	lcdString(msgs[numTela][idiom]);
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x03
	MOVFF	PRODL, r0x04
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_msgs)
	ADDWF	r0x03, F
	MOVLW	HIGH(_msgs)
	ADDWFC	r0x04, F
; ;multiply lit val:0x03 by variable r0x02 and store in r0x05
	MOVF	r0x02, W
	MULLW	0x03
	MOVFF	PRODL, r0x05
	MOVF	r0x05, W
	ADDWF	r0x03, F
	CLRF	WREG
	ADDWFC	r0x04, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVFF	POSTINC0, r0x03
	MOVFF	POSTINC0, r0x04
	MOVFF	INDF0, r0x05
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	172; output.c	lcdCommand(0xC0);
	MOVLW	0xc0
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	173; output.c	lcdInt(getTime());
	CALL	_getTime
	MOVWF	r0x03
	MOVFF	PRODL, r0x04
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdInt
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	174; output.c	lcdString(" ms");
	MOVLW	UPPER(___str_7)
	MOVWF	r0x05
	MOVLW	HIGH(___str_7)
	MOVWF	r0x04
	MOVLW	LOW(___str_7)
	MOVWF	r0x03
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	175; output.c	lcdString("           ");//para apagar os textos depois do numero
	MOVLW	UPPER(___str_9)
	MOVWF	r0x05
	MOVLW	HIGH(___str_9)
	MOVWF	r0x04
	MOVLW	LOW(___str_9)
	MOVWF	r0x03
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00153_DS_:
;	.line	177; output.c	if (numTela == STATE_IDIOM) {
	MOVF	r0x00, W
	XORLW	0x0a
	BNZ	_00279_DS_
	MOVF	r0x01, W
	BZ	_00280_DS_
_00279_DS_:
	BRA	_00159_DS_
_00280_DS_:
;	.line	178; output.c	lcdCommand(0x80);
	MOVLW	0x80
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	179; output.c	lcdString(msgs[numTela][idiom]);
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x03
	MOVFF	PRODL, r0x04
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_msgs)
	ADDWF	r0x03, F
	MOVLW	HIGH(_msgs)
	ADDWFC	r0x04, F
; ;multiply lit val:0x03 by variable r0x02 and store in r0x05
	MOVF	r0x02, W
	MULLW	0x03
	MOVFF	PRODL, r0x05
	MOVF	r0x05, W
	ADDWF	r0x03, F
	CLRF	WREG
	ADDWFC	r0x04, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVFF	POSTINC0, r0x03
	MOVFF	POSTINC0, r0x04
	MOVFF	INDF0, r0x05
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	180; output.c	lcdCommand(0xC0);
	MOVLW	0xc0
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	181; output.c	if (getIdiom() == 0) {
	CALL	_getIdiom
	MOVWF	r0x03
	MOVF	r0x03, W
	BNZ	_00155_DS_
;	.line	182; output.c	lcdString("Portugues       ");
	MOVLW	UPPER(___str_10)
	MOVWF	r0x05
	MOVLW	HIGH(___str_10)
	MOVWF	r0x04
	MOVLW	LOW(___str_10)
	MOVWF	r0x03
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00155_DS_:
;	.line	184; output.c	if (getIdiom() == 1) {
	CALL	_getIdiom
	MOVWF	r0x03
	MOVF	r0x03, W
	XORLW	0x01
	BNZ	_00159_DS_
;	.line	185; output.c	lcdString("English         ");
	MOVLW	UPPER(___str_11)
	MOVWF	r0x05
	MOVLW	HIGH(___str_11)
	MOVWF	r0x04
	MOVLW	LOW(___str_11)
	MOVWF	r0x03
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00159_DS_:
;	.line	189; output.c	if (numTela == STATE_DATE) {
	MOVF	r0x00, W
	XORLW	0x0b
	BNZ	_00283_DS_
	MOVF	r0x01, W
	BZ	_00284_DS_
_00283_DS_:
	BRA	_00161_DS_
_00284_DS_:
;	.line	190; output.c	lcdCommand(0x80);
	MOVLW	0x80
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	191; output.c	lcdString(msgs[numTela][idiom]);
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x03
	MOVFF	PRODL, r0x04
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_msgs)
	ADDWF	r0x03, F
	MOVLW	HIGH(_msgs)
	ADDWFC	r0x04, F
; ;multiply lit val:0x03 by variable r0x02 and store in r0x05
	MOVF	r0x02, W
	MULLW	0x03
	MOVFF	PRODL, r0x05
	MOVF	r0x05, W
	ADDWF	r0x03, F
	CLRF	WREG
	ADDWFC	r0x04, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVFF	POSTINC0, r0x03
	MOVFF	POSTINC0, r0x04
	MOVFF	INDF0, r0x05
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	192; output.c	lcdCommand(0xC0);
	MOVLW	0xc0
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	194; output.c	sec = rtcRead(0x00);
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_rtcRead
	MOVWF	r0x03
	MOVF	POSTINC1, F
	CLRF	r0x04
;	.line	195; output.c	min = rtcRead(0x01);
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_rtcRead
	MOVWF	r0x05
	MOVF	POSTINC1, F
	CLRF	r0x06
;	.line	196; output.c	hour = rtcRead(0x02);        
	MOVLW	0x02
	MOVWF	POSTDEC1
	CALL	_rtcRead
	MOVWF	r0x07
	MOVF	POSTINC1, F
	CLRF	r0x08
;	.line	197; output.c	date = rtcRead(0x04);
	MOVLW	0x04
	MOVWF	POSTDEC1
	CALL	_rtcRead
	MOVWF	r0x09
	MOVF	POSTINC1, F
	CLRF	r0x0a
;	.line	198; output.c	month = rtcRead(0x05);
	MOVLW	0x05
	MOVWF	POSTDEC1
	CALL	_rtcRead
	MOVWF	r0x0b
	MOVF	POSTINC1, F
	CLRF	r0x0c
;	.line	199; output.c	year = rtcRead(0x06);
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	_rtcRead
	MOVF	POSTINC1, F
;	.line	201; output.c	lcdData(BCD2UpperCh(hour));
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	CALL	_BCD2UpperCh
	MOVWF	r0x08
	MOVF	POSTINC1, F
	MOVF	r0x08, W
	MOVWF	POSTDEC1
	CALL	_lcdData
	MOVF	POSTINC1, F
;	.line	202; output.c	lcdData(BCD2LowerCh(hour));
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	CALL	_BCD2LowerCh
	MOVWF	r0x07
	MOVF	POSTINC1, F
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	CALL	_lcdData
	MOVF	POSTINC1, F
;	.line	203; output.c	lcdData(':');
	MOVLW	0x3a
	MOVWF	POSTDEC1
	CALL	_lcdData
	MOVF	POSTINC1, F
;	.line	204; output.c	lcdData(BCD2UpperCh(min));
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	CALL	_BCD2UpperCh
	MOVWF	r0x06
	MOVF	POSTINC1, F
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	CALL	_lcdData
	MOVF	POSTINC1, F
;	.line	205; output.c	lcdData(BCD2LowerCh(min));
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	CALL	_BCD2LowerCh
	MOVWF	r0x05
	MOVF	POSTINC1, F
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	CALL	_lcdData
	MOVF	POSTINC1, F
;	.line	206; output.c	lcdData(':');
	MOVLW	0x3a
	MOVWF	POSTDEC1
	CALL	_lcdData
	MOVF	POSTINC1, F
;	.line	207; output.c	lcdData(BCD2UpperCh(sec));
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_BCD2UpperCh
	MOVWF	r0x04
	MOVF	POSTINC1, F
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdData
	MOVF	POSTINC1, F
;	.line	208; output.c	lcdData(BCD2LowerCh(sec));
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_BCD2LowerCh
	MOVWF	r0x03
	MOVF	POSTINC1, F
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdData
	MOVF	POSTINC1, F
;	.line	209; output.c	lcdString("   ");
	MOVLW	UPPER(___str_12)
	MOVWF	r0x05
	MOVLW	HIGH(___str_12)
	MOVWF	r0x04
	MOVLW	LOW(___str_12)
	MOVWF	r0x03
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	210; output.c	lcdData(BCD2UpperCh(date));
	MOVF	r0x09, W
	MOVWF	POSTDEC1
	CALL	_BCD2UpperCh
	MOVWF	r0x03
	MOVF	POSTINC1, F
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdData
	MOVF	POSTINC1, F
;	.line	211; output.c	lcdData(BCD2LowerCh(date));
	MOVF	r0x09, W
	MOVWF	POSTDEC1
	CALL	_BCD2LowerCh
	MOVWF	r0x03
	MOVF	POSTINC1, F
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdData
	MOVF	POSTINC1, F
;	.line	212; output.c	lcdData('/');
	MOVLW	0x2f
	MOVWF	POSTDEC1
	CALL	_lcdData
	MOVF	POSTINC1, F
;	.line	213; output.c	lcdData(BCD2UpperCh(month));
	MOVF	r0x0b, W
	MOVWF	POSTDEC1
	CALL	_BCD2UpperCh
	MOVWF	r0x03
	MOVF	POSTINC1, F
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdData
	MOVF	POSTINC1, F
;	.line	214; output.c	lcdData(BCD2LowerCh(month));
	MOVF	r0x0b, W
	MOVWF	POSTDEC1
	CALL	_BCD2LowerCh
	MOVWF	r0x03
	MOVF	POSTINC1, F
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_lcdData
	MOVF	POSTINC1, F
_00161_DS_:
;	.line	219; output.c	if (numTela == STATE_RST) {
	MOVF	r0x00, W
	XORLW	0x0c
	BNZ	_00285_DS_
	MOVF	r0x01, W
	BZ	_00286_DS_
_00285_DS_:
	BRA	_00168_DS_
_00286_DS_:
;	.line	220; output.c	lcdCommand(0x80);
	MOVLW	0x80
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	221; output.c	lcdString(msgs[numTela][idiom]);  
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_msgs)
	ADDWF	r0x00, F
	MOVLW	HIGH(_msgs)
	ADDWFC	r0x01, F
; ;multiply lit val:0x03 by variable r0x02 and store in r0x02
	MOVF	r0x02, W
	MULLW	0x03
	MOVFF	PRODL, r0x02
	MOVF	r0x02, W
	ADDWF	r0x00, F
	CLRF	WREG
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVFF	POSTINC0, r0x00
	MOVFF	POSTINC0, r0x01
	MOVFF	INDF0, r0x02
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	222; output.c	lcdCommand(0xC0);
	MOVLW	0xc0
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	223; output.c	if (getIdiom() == 0) {
	CALL	_getIdiom
	MOVWF	r0x00
	MOVF	r0x00, W
	BNZ	_00163_DS_
;	.line	224; output.c	lcdString(" (<-) S/N (->)  ");
	MOVLW	UPPER(___str_13)
	MOVWF	r0x02
	MOVLW	HIGH(___str_13)
	MOVWF	r0x01
	MOVLW	LOW(___str_13)
	MOVWF	r0x00
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00163_DS_:
;	.line	226; output.c	if (getIdiom() == 1) {
	CALL	_getIdiom
	MOVWF	r0x00
	MOVF	r0x00, W
	XORLW	0x01
	BNZ	_00168_DS_
;	.line	227; output.c	lcdString(" (<-) Y/N (->)  ");
	MOVLW	UPPER(___str_14)
	MOVWF	r0x02
	MOVLW	HIGH(___str_14)
	MOVWF	r0x01
	MOVLW	LOW(___str_14)
	MOVWF	r0x00
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00168_DS_:
	MOVFF	PREINC1, r0x0c
	MOVFF	PREINC1, r0x0b
	MOVFF	PREINC1, r0x0a
	MOVFF	PREINC1, r0x09
	MOVFF	PREINC1, r0x08
	MOVFF	PREINC1, r0x07
	MOVFF	PREINC1, r0x06
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_output__outputInit	code
_outputInit:
;	.line	46; output.c	void outputInit(void) {   
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	47; output.c	lcdInit();
	CALL	_lcdInit
;	.line	48; output.c	adcInit();
	CALL	_adcInit
;	.line	49; output.c	serialInit();
	CALL	_serialInit
	BANKSEL	_state_ant
;	.line	50; output.c	state_ant = 0;
	CLRF	_state_ant, B
	BANKSEL	_language_ant
;	.line	51; output.c	language_ant = 0;
	CLRF	_language_ant, B
	BANKSEL	_time_ant
;	.line	52; output.c	time_ant = 0;
	CLRF	_time_ant, B
	BANKSEL	(_time_ant + 1)
	CLRF	(_time_ant + 1), B
	BANKSEL	_alarmLow_ant
;	.line	53; output.c	alarmLow_ant = 0;
	CLRF	_alarmLow_ant, B
	BANKSEL	(_alarmLow_ant + 1)
	CLRF	(_alarmLow_ant + 1), B
	BANKSEL	_alarmHigh_ant
;	.line	54; output.c	alarmHigh_ant = 0;
	CLRF	_alarmHigh_ant, B
	BANKSEL	(_alarmHigh_ant + 1)
	CLRF	(_alarmHigh_ant + 1), B
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
___str_0:
	DB	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_1:
	DB	0x20, 0x4f, 0x4e, 0x20, 0x00
; ; Starting pCode block
___str_2:
	DB	0x4f, 0x46, 0x46, 0x20, 0x00
; ; Starting pCode block
___str_3:
	DB	0x20, 0x4f, 0x4e, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_4:
	DB	0x20, 0x4f, 0x46, 0x46, 0x20, 0x00
; ; Starting pCode block
___str_5:
	DB	0x41, 0x30, 0x3a, 0x00
; ; Starting pCode block
___str_6:
	DB	0x41, 0x31, 0x3a, 0x00
; ; Starting pCode block
___str_7:
	DB	0x20, 0x6d, 0x73, 0x00
; ; Starting pCode block
___str_8:
	DB	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	DB	0x00
; ; Starting pCode block
___str_9:
	DB	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_10:
	DB	0x50, 0x6f, 0x72, 0x74, 0x75, 0x67, 0x75, 0x65, 0x73, 0x20, 0x20, 0x20
	DB	0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_11:
	DB	0x45, 0x6e, 0x67, 0x6c, 0x69, 0x73, 0x68, 0x20, 0x20, 0x20, 0x20, 0x20
	DB	0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_12:
	DB	0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_13:
	DB	0x20, 0x28, 0x3c, 0x2d, 0x29, 0x20, 0x53, 0x2f, 0x4e, 0x20, 0x28, 0x2d
	DB	0x3e, 0x29, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_14:
	DB	0x20, 0x28, 0x3c, 0x2d, 0x29, 0x20, 0x59, 0x2f, 0x4e, 0x20, 0x28, 0x2d
	DB	0x3e, 0x29, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_15:
	DB	0x3c, 0x49, 0x20, 0x20, 0x20, 0x41, 0x4c, 0x5f, 0x41, 0x5f, 0x30, 0x20
	DB	0x41, 0x42, 0x30, 0x3e, 0x00
; ; Starting pCode block
___str_16:
	DB	0x3c, 0x49, 0x20, 0x20, 0x20, 0x41, 0x4c, 0x5f, 0x48, 0x5f, 0x30, 0x20
	DB	0x41, 0x4c, 0x30, 0x3e, 0x00
; ; Starting pCode block
___str_17:
	DB	0x41, 0x4c, 0x41, 0x52, 0x4d, 0x45, 0x20, 0x41, 0x4c, 0x54, 0x4f, 0x20
	DB	0x30, 0x3a, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_18:
	DB	0x41, 0x4c, 0x41, 0x52, 0x4d, 0x20, 0x48, 0x49, 0x47, 0x48, 0x20, 0x30
	DB	0x3a, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_19:
	DB	0x3c, 0x41, 0x41, 0x30, 0x20, 0x41, 0x4c, 0x5f, 0x42, 0x5f, 0x30, 0x20
	DB	0x41, 0x41, 0x31, 0x3e, 0x00
; ; Starting pCode block
___str_20:
	DB	0x3c, 0x41, 0x48, 0x30, 0x20, 0x41, 0x4c, 0x5f, 0x4c, 0x5f, 0x30, 0x20
	DB	0x41, 0x48, 0x31, 0x3e, 0x00
; ; Starting pCode block
___str_21:
	DB	0x41, 0x4c, 0x41, 0x52, 0x4d, 0x45, 0x20, 0x42, 0x41, 0x49, 0x58, 0x4f
	DB	0x20, 0x30, 0x3a, 0x20, 0x00
; ; Starting pCode block
___str_22:
	DB	0x41, 0x4c, 0x41, 0x52, 0x4d, 0x20, 0x4c, 0x4f, 0x57, 0x20, 0x30, 0x3a
	DB	0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_23:
	DB	0x3c, 0x41, 0x42, 0x30, 0x20, 0x41, 0x4c, 0x5f, 0x41, 0x5f, 0x31, 0x20
	DB	0x41, 0x42, 0x31, 0x3e, 0x00
; ; Starting pCode block
___str_24:
	DB	0x3c, 0x41, 0x4c, 0x30, 0x20, 0x41, 0x4c, 0x5f, 0x48, 0x5f, 0x31, 0x20
	DB	0x41, 0x4c, 0x31, 0x3e, 0x00
; ; Starting pCode block
___str_25:
	DB	0x41, 0x4c, 0x41, 0x52, 0x4d, 0x45, 0x20, 0x41, 0x4c, 0x54, 0x4f, 0x20
	DB	0x31, 0x3a, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_26:
	DB	0x41, 0x4c, 0x41, 0x52, 0x4d, 0x20, 0x48, 0x49, 0x47, 0x48, 0x20, 0x31
	DB	0x3a, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_27:
	DB	0x3c, 0x41, 0x41, 0x31, 0x20, 0x41, 0x4c, 0x5f, 0x42, 0x5f, 0x31, 0x20
	DB	0x20, 0x20, 0x54, 0x3e, 0x00
; ; Starting pCode block
___str_28:
	DB	0x3c, 0x41, 0x48, 0x31, 0x20, 0x41, 0x4c, 0x5f, 0x4c, 0x5f, 0x31, 0x20
	DB	0x20, 0x20, 0x54, 0x3e, 0x00
; ; Starting pCode block
___str_29:
	DB	0x41, 0x4c, 0x41, 0x52, 0x4d, 0x45, 0x20, 0x42, 0x41, 0x49, 0x58, 0x4f
	DB	0x20, 0x31, 0x3a, 0x20, 0x00
; ; Starting pCode block
___str_30:
	DB	0x41, 0x4c, 0x41, 0x52, 0x4d, 0x20, 0x4c, 0x4f, 0x57, 0x20, 0x31, 0x3a
	DB	0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_31:
	DB	0x3c, 0x41, 0x42, 0x31, 0x20, 0x54, 0x45, 0x4d, 0x50, 0x4f, 0x20, 0x20
	DB	0x20, 0x20, 0x49, 0x3e, 0x00
; ; Starting pCode block
___str_32:
	DB	0x3c, 0x41, 0x4c, 0x31, 0x20, 0x20, 0x54, 0x49, 0x4d, 0x45, 0x20, 0x20
	DB	0x20, 0x20, 0x49, 0x3e, 0x00
; ; Starting pCode block
___str_33:
	DB	0x41, 0x4c, 0x54, 0x45, 0x52, 0x41, 0x52, 0x20, 0x54, 0x45, 0x4d, 0x50
	DB	0x4f, 0x3a, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_34:
	DB	0x43, 0x48, 0x41, 0x4e, 0x47, 0x45, 0x20, 0x54, 0x49, 0x4d, 0x45, 0x3a
	DB	0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_35:
	DB	0x3c, 0x54, 0x20, 0x20, 0x20, 0x49, 0x44, 0x49, 0x4f, 0x4d, 0x41, 0x20
	DB	0x20, 0x20, 0x44, 0x3e, 0x00
; ; Starting pCode block
___str_36:
	DB	0x3c, 0x54, 0x20, 0x20, 0x20, 0x49, 0x44, 0x49, 0x4f, 0x4d, 0x20, 0x20
	DB	0x20, 0x20, 0x44, 0x3e, 0x00
; ; Starting pCode block
___str_37:
	DB	0x3c, 0x49, 0x20, 0x20, 0x20, 0x44, 0x41, 0x54, 0x41, 0x20, 0x20, 0x20
	DB	0x41, 0x41, 0x30, 0x3e, 0x00
; ; Starting pCode block
___str_38:
	DB	0x3c, 0x54, 0x20, 0x20, 0x20, 0x44, 0x41, 0x54, 0x45, 0x20, 0x20, 0x20
	DB	0x41, 0x48, 0x30, 0x3e, 0x00
; ; Starting pCode block
___str_39:
	DB	0x52, 0x65, 0x73, 0x65, 0x74, 0x61, 0x72, 0x3f, 0x20, 0x20, 0x20, 0x20
	DB	0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_40:
	DB	0x52, 0x65, 0x73, 0x65, 0x74, 0x3f, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	DB	0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_41:
	DB	0x45, 0x73, 0x74, 0x61, 0x64, 0x6f, 0x20, 0x3d, 0x20, 0x00
; ; Starting pCode block
___str_42:
	DB	0x53, 0x74, 0x61, 0x74, 0x65, 0x20, 0x3d, 0x20, 0x00
; ; Starting pCode block
___str_43:
	DB	0x41, 0x6c, 0x61, 0x72, 0x6d, 0x65, 0x20, 0x41, 0x6c, 0x74, 0x6f, 0x20
	DB	0x3d, 0x20, 0x00
; ; Starting pCode block
___str_44:
	DB	0x41, 0x6c, 0x61, 0x72, 0x6d, 0x20, 0x48, 0x69, 0x67, 0x68, 0x20, 0x3d
	DB	0x20, 0x00
; ; Starting pCode block
___str_45:
	DB	0x41, 0x6c, 0x61, 0x72, 0x6d, 0x65, 0x20, 0x42, 0x61, 0x69, 0x78, 0x6f
	DB	0x20, 0x3d, 0x20, 0x00
; ; Starting pCode block
___str_46:
	DB	0x41, 0x6c, 0x61, 0x72, 0x6d, 0x20, 0x4c, 0x6f, 0x77, 0x20, 0x3d, 0x20
	DB	0x00
; ; Starting pCode block
___str_47:
	DB	0x54, 0x65, 0x6d, 0x70, 0x6f, 0x20, 0x3d, 0x20, 0x00
; ; Starting pCode block
___str_48:
	DB	0x54, 0x69, 0x6d, 0x65, 0x20, 0x3d, 0x20, 0x00
; ; Starting pCode block
___str_49:
	DB	0x49, 0x64, 0x69, 0x6f, 0x6d, 0x61, 0x20, 0x3d, 0x20, 0x00
; ; Starting pCode block
___str_50:
	DB	0x49, 0x64, 0x69, 0x6f, 0x6d, 0x20, 0x3d, 0x20, 0x00


; Statistics:
; code size:	 4784 (0x12b0) bytes ( 3.65%)
;           	 2392 (0x0958) words
; udata size:	    8 (0x0008) bytes ( 0.45%)
; access size:	   15 (0x000f) bytes


	end
