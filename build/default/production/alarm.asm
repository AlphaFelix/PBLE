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
	global	_testAlarmHigh
	global	_testAlarmLow
	global	_controlAlarms

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern	_ledOn
	extern	_ledOff
	extern	_ledBlink
	extern	_getAlarmLow
	extern	_getAlarmHigh
	extern	_adcScale
	extern	_BCD2UpperCh
	extern	_BCD2LowerCh
	extern	_rtcRead
	extern	_serialSend
	extern	_serialString

;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
STATUS	equ	0xfd8
WREG	equ	0xfe8
FSR1L	equ	0xfe1
FSR2L	equ	0xfd9
POSTINC1	equ	0xfe6
POSTDEC1	equ	0xfe5
PREINC1	equ	0xfe4
PLUSW2	equ	0xfdb
PRODL	equ	0xff3


	idata
_alarmNewH0	db	0x00
_alarmAntH0	db	0x01
_alarmNewH1	db	0x00
_alarmAntH1	db	0x01
_alarmNewL0	db	0x00
_alarmAntL0	db	0x01
_alarmNewL1	db	0x00
_alarmAntL1	db	0x01


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

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_alarm__controlAlarms	code
_controlAlarms:
;	.line	32; alarm.c	void controlAlarms(void){
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
;	.line	34; alarm.c	alarmNewH0 = testAlarmHigh(0);
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_testAlarmHigh
	BANKSEL	_alarmNewH0
	MOVWF	_alarmNewH0, B
	MOVF	POSTINC1, F
;	.line	35; alarm.c	alarmNewL0 = testAlarmLow(0);
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_testAlarmLow
	BANKSEL	_alarmNewL0
	MOVWF	_alarmNewL0, B
	MOVF	POSTINC1, F
;	.line	36; alarm.c	alarmNewH1 = testAlarmHigh(1);
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_testAlarmHigh
	BANKSEL	_alarmNewH1
	MOVWF	_alarmNewH1, B
	MOVF	POSTINC1, F
;	.line	37; alarm.c	alarmNewL1 = testAlarmLow(1);
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_testAlarmLow
	BANKSEL	_alarmNewL1
	MOVWF	_alarmNewL1, B
	MOVF	POSTINC1, F
	BANKSEL	_alarmNewL0
;	.line	39; alarm.c	if(alarmNewL0 == 1)
	MOVF	_alarmNewL0, W, B
	XORLW	0x01
	BNZ	_00132_DS_
;	.line	40; alarm.c	ledBlink(0);
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_ledBlink
	MOVF	POSTINC1, F
_00132_DS_:
	BANKSEL	_alarmNewH0
;	.line	41; alarm.c	if(alarmNewH0 == 1)
	MOVF	_alarmNewH0, W, B
	XORLW	0x01
	BNZ	_00134_DS_
;	.line	42; alarm.c	ledOn(0);
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_ledOn
	MOVF	POSTINC1, F
_00134_DS_:
;	.line	43; alarm.c	if(alarmNewH0 != alarmAntH0 & alarmNewH0 == 1)
	CLRF	r0x00
	BANKSEL	_alarmNewH0
	MOVF	_alarmNewH0, W, B
	BANKSEL	_alarmAntH0
	XORWF	_alarmAntH0, W, B
	BNZ	_00213_DS_
	INCF	r0x00, F
_00213_DS_:
	MOVF	r0x00, W
	BSF	STATUS, 0
	TSTFSZ	WREG
	BCF	STATUS, 0
	CLRF	r0x00
	RLCF	r0x00, F
	CLRF	r0x01
	BANKSEL	_alarmNewH0
	MOVF	_alarmNewH0, W, B
	XORLW	0x01
	BNZ	_00215_DS_
	INCF	r0x01, F
_00215_DS_:
	MOVF	r0x00, W
	ANDWF	r0x01, F
	MOVF	r0x01, W
	BZ	_00136_DS_
;	.line	45; alarm.c	serialString("Alarm High 0 Acionado");
	MOVLW	UPPER(___str_0)
	MOVWF	r0x02
	MOVLW	HIGH(___str_0)
	MOVWF	r0x01
	MOVLW	LOW(___str_0)
	MOVWF	r0x00
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_serialString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	46; alarm.c	serialSend(13);      
	MOVLW	0x0d
	MOVWF	POSTDEC1
	CALL	_serialSend
	MOVF	POSTINC1, F
_00136_DS_:
;	.line	48; alarm.c	if(alarmNewH0 != alarmAntH0 & alarmNewH0 == 0)
	CLRF	r0x00
	BANKSEL	_alarmNewH0
	MOVF	_alarmNewH0, W, B
	BANKSEL	_alarmAntH0
	XORWF	_alarmAntH0, W, B
	BNZ	_00217_DS_
	INCF	r0x00, F
_00217_DS_:
	MOVF	r0x00, W
	BSF	STATUS, 0
	TSTFSZ	WREG
	BCF	STATUS, 0
	CLRF	r0x00
	RLCF	r0x00, F
	BANKSEL	_alarmNewH0
	MOVF	_alarmNewH0, W, B
	BSF	STATUS, 0
	TSTFSZ	WREG
	BCF	STATUS, 0
	CLRF	r0x01
	RLCF	r0x01, F
	MOVF	r0x01, W
	ANDWF	r0x00, F
	MOVF	r0x00, W
	BZ	_00138_DS_
;	.line	50; alarm.c	serialString("Alarm High 0 Desligado");
	MOVLW	UPPER(___str_1)
	MOVWF	r0x02
	MOVLW	HIGH(___str_1)
	MOVWF	r0x01
	MOVLW	LOW(___str_1)
	MOVWF	r0x00
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_serialString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	51; alarm.c	serialSend(13);        
	MOVLW	0x0d
	MOVWF	POSTDEC1
	CALL	_serialSend
	MOVF	POSTINC1, F
_00138_DS_:
;	.line	53; alarm.c	if(alarmNewL0 != alarmAntL0 & alarmNewL0 == 1)
	CLRF	r0x00
	BANKSEL	_alarmNewL0
	MOVF	_alarmNewL0, W, B
	BANKSEL	_alarmAntL0
	XORWF	_alarmAntL0, W, B
	BNZ	_00219_DS_
	INCF	r0x00, F
_00219_DS_:
	MOVF	r0x00, W
	BSF	STATUS, 0
	TSTFSZ	WREG
	BCF	STATUS, 0
	CLRF	r0x00
	RLCF	r0x00, F
	CLRF	r0x01
	BANKSEL	_alarmNewL0
	MOVF	_alarmNewL0, W, B
	XORLW	0x01
	BNZ	_00221_DS_
	INCF	r0x01, F
_00221_DS_:
	MOVF	r0x00, W
	ANDWF	r0x01, F
	MOVF	r0x01, W
	BZ	_00140_DS_
;	.line	55; alarm.c	serialString("Alarm Low 0 Acionado");
	MOVLW	UPPER(___str_2)
	MOVWF	r0x02
	MOVLW	HIGH(___str_2)
	MOVWF	r0x01
	MOVLW	LOW(___str_2)
	MOVWF	r0x00
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_serialString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	56; alarm.c	serialSend(13);      
	MOVLW	0x0d
	MOVWF	POSTDEC1
	CALL	_serialSend
	MOVF	POSTINC1, F
_00140_DS_:
;	.line	58; alarm.c	if(alarmNewL0 != alarmAntL0 & alarmNewL0 == 0)
	CLRF	r0x00
	BANKSEL	_alarmNewL0
	MOVF	_alarmNewL0, W, B
	BANKSEL	_alarmAntL0
	XORWF	_alarmAntL0, W, B
	BNZ	_00223_DS_
	INCF	r0x00, F
_00223_DS_:
	MOVF	r0x00, W
	BSF	STATUS, 0
	TSTFSZ	WREG
	BCF	STATUS, 0
	CLRF	r0x00
	RLCF	r0x00, F
	BANKSEL	_alarmNewL0
	MOVF	_alarmNewL0, W, B
	BSF	STATUS, 0
	TSTFSZ	WREG
	BCF	STATUS, 0
	CLRF	r0x01
	RLCF	r0x01, F
	MOVF	r0x01, W
	ANDWF	r0x00, F
	MOVF	r0x00, W
	BZ	_00142_DS_
;	.line	60; alarm.c	serialString("Alarm Low 0 Desligado");
	MOVLW	UPPER(___str_3)
	MOVWF	r0x02
	MOVLW	HIGH(___str_3)
	MOVWF	r0x01
	MOVLW	LOW(___str_3)
	MOVWF	r0x00
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_serialString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	61; alarm.c	serialSend(13);        
	MOVLW	0x0d
	MOVWF	POSTDEC1
	CALL	_serialSend
	MOVF	POSTINC1, F
_00142_DS_:
	BANKSEL	_alarmNewH0
;	.line	63; alarm.c	if(alarmNewH0 == 0 & alarmNewL0 == 0)
	MOVF	_alarmNewH0, W, B
	BSF	STATUS, 0
	TSTFSZ	WREG
	BCF	STATUS, 0
	CLRF	r0x00
	RLCF	r0x00, F
	BANKSEL	_alarmNewL0
	MOVF	_alarmNewL0, W, B
	BSF	STATUS, 0
	TSTFSZ	WREG
	BCF	STATUS, 0
	CLRF	r0x01
	RLCF	r0x01, F
	MOVF	r0x01, W
	ANDWF	r0x00, F
	MOVF	r0x00, W
	BZ	_00144_DS_
;	.line	65; alarm.c	ledOff(0);
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_ledOff
	MOVF	POSTINC1, F
_00144_DS_:
	BANKSEL	_alarmNewL1
;	.line	67; alarm.c	if(alarmNewL1 == 1)
	MOVF	_alarmNewL1, W, B
	XORLW	0x01
	BNZ	_00146_DS_
;	.line	68; alarm.c	ledBlink(1);
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_ledBlink
	MOVF	POSTINC1, F
_00146_DS_:
	BANKSEL	_alarmNewH1
;	.line	69; alarm.c	if(alarmNewH1 == 1)
	MOVF	_alarmNewH1, W, B
	XORLW	0x01
	BNZ	_00148_DS_
;	.line	70; alarm.c	ledOn(1); 
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_ledOn
	MOVF	POSTINC1, F
_00148_DS_:
;	.line	71; alarm.c	if(alarmNewH1 != alarmAntH1 & alarmNewH1 == 1)
	CLRF	r0x00
	BANKSEL	_alarmNewH1
	MOVF	_alarmNewH1, W, B
	BANKSEL	_alarmAntH1
	XORWF	_alarmAntH1, W, B
	BNZ	_00229_DS_
	INCF	r0x00, F
_00229_DS_:
	MOVF	r0x00, W
	BSF	STATUS, 0
	TSTFSZ	WREG
	BCF	STATUS, 0
	CLRF	r0x00
	RLCF	r0x00, F
	CLRF	r0x01
	BANKSEL	_alarmNewH1
	MOVF	_alarmNewH1, W, B
	XORLW	0x01
	BNZ	_00231_DS_
	INCF	r0x01, F
_00231_DS_:
	MOVF	r0x00, W
	ANDWF	r0x01, F
	MOVF	r0x01, W
	BZ	_00150_DS_
;	.line	73; alarm.c	serialString("Alarm High 1 Acionado");
	MOVLW	UPPER(___str_4)
	MOVWF	r0x02
	MOVLW	HIGH(___str_4)
	MOVWF	r0x01
	MOVLW	LOW(___str_4)
	MOVWF	r0x00
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_serialString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	74; alarm.c	serialSend(13);      
	MOVLW	0x0d
	MOVWF	POSTDEC1
	CALL	_serialSend
	MOVF	POSTINC1, F
_00150_DS_:
;	.line	76; alarm.c	if(alarmNewH1 != alarmAntH1 & alarmNewH1 == 0)
	CLRF	r0x00
	BANKSEL	_alarmNewH1
	MOVF	_alarmNewH1, W, B
	BANKSEL	_alarmAntH1
	XORWF	_alarmAntH1, W, B
	BNZ	_00233_DS_
	INCF	r0x00, F
_00233_DS_:
	MOVF	r0x00, W
	BSF	STATUS, 0
	TSTFSZ	WREG
	BCF	STATUS, 0
	CLRF	r0x00
	RLCF	r0x00, F
	BANKSEL	_alarmNewH1
	MOVF	_alarmNewH1, W, B
	BSF	STATUS, 0
	TSTFSZ	WREG
	BCF	STATUS, 0
	CLRF	r0x01
	RLCF	r0x01, F
	MOVF	r0x01, W
	ANDWF	r0x00, F
	MOVF	r0x00, W
	BZ	_00152_DS_
;	.line	78; alarm.c	serialString("Alarm High 1 Desligado");
	MOVLW	UPPER(___str_5)
	MOVWF	r0x02
	MOVLW	HIGH(___str_5)
	MOVWF	r0x01
	MOVLW	LOW(___str_5)
	MOVWF	r0x00
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_serialString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	79; alarm.c	serialSend(13);        
	MOVLW	0x0d
	MOVWF	POSTDEC1
	CALL	_serialSend
	MOVF	POSTINC1, F
_00152_DS_:
;	.line	81; alarm.c	if(alarmNewL1 != alarmAntL1 & alarmNewL1 == 1)
	CLRF	r0x00
	BANKSEL	_alarmNewL1
	MOVF	_alarmNewL1, W, B
	BANKSEL	_alarmAntL1
	XORWF	_alarmAntL1, W, B
	BNZ	_00235_DS_
	INCF	r0x00, F
_00235_DS_:
	MOVF	r0x00, W
	BSF	STATUS, 0
	TSTFSZ	WREG
	BCF	STATUS, 0
	CLRF	r0x00
	RLCF	r0x00, F
	CLRF	r0x01
	BANKSEL	_alarmNewL1
	MOVF	_alarmNewL1, W, B
	XORLW	0x01
	BNZ	_00237_DS_
	INCF	r0x01, F
_00237_DS_:
	MOVF	r0x00, W
	ANDWF	r0x01, F
	MOVF	r0x01, W
	BZ	_00154_DS_
;	.line	83; alarm.c	serialString("Alarm Low 1 Acionado");
	MOVLW	UPPER(___str_6)
	MOVWF	r0x02
	MOVLW	HIGH(___str_6)
	MOVWF	r0x01
	MOVLW	LOW(___str_6)
	MOVWF	r0x00
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_serialString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	84; alarm.c	serialSend(13);      
	MOVLW	0x0d
	MOVWF	POSTDEC1
	CALL	_serialSend
	MOVF	POSTINC1, F
_00154_DS_:
;	.line	86; alarm.c	if(alarmNewL1 != alarmAntL1 & alarmNewL1 == 0)
	CLRF	r0x00
	BANKSEL	_alarmNewL1
	MOVF	_alarmNewL1, W, B
	BANKSEL	_alarmAntL1
	XORWF	_alarmAntL1, W, B
	BNZ	_00239_DS_
	INCF	r0x00, F
_00239_DS_:
	MOVF	r0x00, W
	BSF	STATUS, 0
	TSTFSZ	WREG
	BCF	STATUS, 0
	CLRF	r0x00
	RLCF	r0x00, F
	BANKSEL	_alarmNewL1
	MOVF	_alarmNewL1, W, B
	BSF	STATUS, 0
	TSTFSZ	WREG
	BCF	STATUS, 0
	CLRF	r0x01
	RLCF	r0x01, F
	MOVF	r0x01, W
	ANDWF	r0x00, F
	MOVF	r0x00, W
	BZ	_00156_DS_
;	.line	88; alarm.c	serialString("Alarm Low 1 Desligado");
	MOVLW	UPPER(___str_7)
	MOVWF	r0x02
	MOVLW	HIGH(___str_7)
	MOVWF	r0x01
	MOVLW	LOW(___str_7)
	MOVWF	r0x00
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_serialString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	89; alarm.c	serialSend(13);        
	MOVLW	0x0d
	MOVWF	POSTDEC1
	CALL	_serialSend
	MOVF	POSTINC1, F
_00156_DS_:
	BANKSEL	_alarmNewH1
;	.line	91; alarm.c	if(alarmNewH1 == 0 & alarmNewL1 == 0)
	MOVF	_alarmNewH1, W, B
	BSF	STATUS, 0
	TSTFSZ	WREG
	BCF	STATUS, 0
	CLRF	r0x00
	RLCF	r0x00, F
	BANKSEL	_alarmNewL1
	MOVF	_alarmNewL1, W, B
	BSF	STATUS, 0
	TSTFSZ	WREG
	BCF	STATUS, 0
	CLRF	r0x01
	RLCF	r0x01, F
	MOVF	r0x01, W
	ANDWF	r0x00, F
	MOVF	r0x00, W
	BZ	_00158_DS_
;	.line	93; alarm.c	ledOff(1);
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_ledOff
	MOVF	POSTINC1, F
_00158_DS_:
;	.line	95; alarm.c	if(alarmNewL0 != alarmAntL0 | alarmNewH0 != alarmAntH0 | alarmNewL1 != alarmAntL1 | alarmNewH1 != alarmAntH1)
	CLRF	r0x00
	BANKSEL	_alarmNewL0
	MOVF	_alarmNewL0, W, B
	BANKSEL	_alarmAntL0
	XORWF	_alarmAntL0, W, B
	BNZ	_00241_DS_
	INCF	r0x00, F
_00241_DS_:
	MOVF	r0x00, W
	BSF	STATUS, 0
	TSTFSZ	WREG
	BCF	STATUS, 0
	CLRF	r0x00
	RLCF	r0x00, F
	CLRF	r0x01
	BANKSEL	_alarmNewH0
	MOVF	_alarmNewH0, W, B
	BANKSEL	_alarmAntH0
	XORWF	_alarmAntH0, W, B
	BNZ	_00243_DS_
	INCF	r0x01, F
_00243_DS_:
	MOVF	r0x01, W
	BSF	STATUS, 0
	TSTFSZ	WREG
	BCF	STATUS, 0
	CLRF	r0x01
	RLCF	r0x01, F
	MOVF	r0x01, W
	IORWF	r0x00, F
	CLRF	r0x01
	BANKSEL	_alarmNewL1
	MOVF	_alarmNewL1, W, B
	BANKSEL	_alarmAntL1
	XORWF	_alarmAntL1, W, B
	BNZ	_00246_DS_
	INCF	r0x01, F
_00246_DS_:
	MOVF	r0x01, W
	BSF	STATUS, 0
	TSTFSZ	WREG
	BCF	STATUS, 0
	CLRF	r0x01
	RLCF	r0x01, F
	MOVF	r0x01, W
	IORWF	r0x00, F
	CLRF	r0x01
	BANKSEL	_alarmNewH1
	MOVF	_alarmNewH1, W, B
	BANKSEL	_alarmAntH1
	XORWF	_alarmAntH1, W, B
	BNZ	_00249_DS_
	INCF	r0x01, F
_00249_DS_:
	MOVF	r0x01, W
	BSF	STATUS, 0
	TSTFSZ	WREG
	BCF	STATUS, 0
	CLRF	r0x01
	RLCF	r0x01, F
	MOVF	r0x01, W
	IORWF	r0x00, F
	MOVF	r0x00, W
	BTFSC	STATUS, 2
	BRA	_00160_DS_
;	.line	97; alarm.c	min = rtcRead(0x01);
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_rtcRead
	MOVWF	r0x00
	MOVF	POSTINC1, F
	CLRF	r0x01
;	.line	98; alarm.c	hour = rtcRead(0x02);
	MOVLW	0x02
	MOVWF	POSTDEC1
	CALL	_rtcRead
	MOVWF	r0x02
	MOVF	POSTINC1, F
	CLRF	r0x03
;	.line	99; alarm.c	sec = rtcRead(0x00);
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_rtcRead
	MOVWF	r0x04
	MOVF	POSTINC1, F
	CLRF	r0x05
;	.line	100; alarm.c	date = rtcRead(0x04);
	MOVLW	0x04
	MOVWF	POSTDEC1
	CALL	_rtcRead
	MOVWF	r0x06
	MOVF	POSTINC1, F
	CLRF	r0x07
;	.line	101; alarm.c	month = rtcRead(0x05);
	MOVLW	0x05
	MOVWF	POSTDEC1
	CALL	_rtcRead
	MOVWF	r0x08
	MOVF	POSTINC1, F
	CLRF	r0x09
;	.line	102; alarm.c	year = rtcRead(0x06);
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	_rtcRead
	MOVWF	r0x0a
	MOVF	POSTINC1, F
	CLRF	r0x0b
;	.line	103; alarm.c	serialString("Time: ");
	MOVLW	UPPER(___str_8)
	MOVWF	r0x0e
	MOVLW	HIGH(___str_8)
	MOVWF	r0x0d
	MOVLW	LOW(___str_8)
	MOVWF	r0x0c
	MOVF	r0x0e, W
	MOVWF	POSTDEC1
	MOVF	r0x0d, W
	MOVWF	POSTDEC1
	MOVF	r0x0c, W
	MOVWF	POSTDEC1
	CALL	_serialString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	104; alarm.c	serialSend(BCD2UpperCh(hour));
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	_BCD2UpperCh
	MOVWF	r0x03
	MOVF	POSTINC1, F
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_serialSend
	MOVF	POSTINC1, F
;	.line	105; alarm.c	serialSend(BCD2LowerCh(hour));
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	_BCD2LowerCh
	MOVWF	r0x02
	MOVF	POSTINC1, F
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	_serialSend
	MOVF	POSTINC1, F
;	.line	106; alarm.c	serialSend(':');
	MOVLW	0x3a
	MOVWF	POSTDEC1
	CALL	_serialSend
	MOVF	POSTINC1, F
;	.line	107; alarm.c	serialSend(BCD2UpperCh(min));
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_BCD2UpperCh
	MOVWF	r0x01
	MOVF	POSTINC1, F
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_serialSend
	MOVF	POSTINC1, F
;	.line	108; alarm.c	serialSend(BCD2LowerCh(min));
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_BCD2LowerCh
	MOVWF	r0x00
	MOVF	POSTINC1, F
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_serialSend
	MOVF	POSTINC1, F
;	.line	109; alarm.c	serialSend(':');
	MOVLW	0x3a
	MOVWF	POSTDEC1
	CALL	_serialSend
	MOVF	POSTINC1, F
;	.line	110; alarm.c	serialSend(BCD2UpperCh(sec));
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_BCD2UpperCh
	MOVWF	r0x00
	MOVF	POSTINC1, F
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_serialSend
	MOVF	POSTINC1, F
;	.line	111; alarm.c	serialSend(BCD2LowerCh(sec));
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_BCD2LowerCh
	MOVWF	r0x00
	MOVF	POSTINC1, F
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_serialSend
	MOVF	POSTINC1, F
;	.line	112; alarm.c	serialSend(13);
	MOVLW	0x0d
	MOVWF	POSTDEC1
	CALL	_serialSend
	MOVF	POSTINC1, F
;	.line	113; alarm.c	serialString("Date: ");
	MOVLW	UPPER(___str_9)
	MOVWF	r0x02
	MOVLW	HIGH(___str_9)
	MOVWF	r0x01
	MOVLW	LOW(___str_9)
	MOVWF	r0x00
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_serialString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	114; alarm.c	serialSend(BCD2UpperCh(date));
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	CALL	_BCD2UpperCh
	MOVWF	r0x00
	MOVF	POSTINC1, F
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_serialSend
	MOVF	POSTINC1, F
;	.line	115; alarm.c	serialSend(BCD2LowerCh(date));
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	CALL	_BCD2LowerCh
	MOVWF	r0x00
	MOVF	POSTINC1, F
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_serialSend
	MOVF	POSTINC1, F
;	.line	116; alarm.c	serialSend('/');
	MOVLW	0x2f
	MOVWF	POSTDEC1
	CALL	_serialSend
	MOVF	POSTINC1, F
;	.line	117; alarm.c	serialSend(BCD2UpperCh(month));
	MOVF	r0x08, W
	MOVWF	POSTDEC1
	CALL	_BCD2UpperCh
	MOVWF	r0x00
	MOVF	POSTINC1, F
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_serialSend
	MOVF	POSTINC1, F
;	.line	118; alarm.c	serialSend(BCD2LowerCh(month));
	MOVF	r0x08, W
	MOVWF	POSTDEC1
	CALL	_BCD2LowerCh
	MOVWF	r0x00
	MOVF	POSTINC1, F
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_serialSend
	MOVF	POSTINC1, F
;	.line	119; alarm.c	serialSend('/');
	MOVLW	0x2f
	MOVWF	POSTDEC1
	CALL	_serialSend
	MOVF	POSTINC1, F
;	.line	120; alarm.c	serialSend(BCD2UpperCh(year));
	MOVF	r0x0a, W
	MOVWF	POSTDEC1
	CALL	_BCD2UpperCh
	MOVWF	r0x00
	MOVF	POSTINC1, F
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_serialSend
	MOVF	POSTINC1, F
;	.line	121; alarm.c	serialSend(BCD2LowerCh(year));
	MOVF	r0x0a, W
	MOVWF	POSTDEC1
	CALL	_BCD2LowerCh
	MOVWF	r0x00
	MOVF	POSTINC1, F
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_serialSend
	MOVF	POSTINC1, F
;	.line	122; alarm.c	serialSend(13);
	MOVLW	0x0d
	MOVWF	POSTDEC1
	CALL	_serialSend
	MOVF	POSTINC1, F
_00160_DS_:
;	.line	124; alarm.c	alarmAntL1 = alarmNewL1;    
	MOVFF	_alarmNewL1, _alarmAntL1
;	.line	125; alarm.c	alarmAntH1 = alarmNewH1;
	MOVFF	_alarmNewH1, _alarmAntH1
;	.line	126; alarm.c	alarmAntL0 = alarmNewL0;
	MOVFF	_alarmNewL0, _alarmAntL0
;	.line	127; alarm.c	alarmAntH0 = alarmNewH0;          
	MOVFF	_alarmNewH0, _alarmAntH0
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
S_alarm__testAlarmLow	code
_testAlarmLow:
;	.line	23; alarm.c	char testAlarmLow(char alarm){    
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	24; alarm.c	if(adcScale(POT, 1023) <= getAlarmLow(alarm)){
	MOVLW	0x03
	MOVWF	POSTDEC1
	MOVLW	0xff
	MOVWF	POSTDEC1
	MOVLW	0x02
	MOVWF	POSTDEC1
	CALL	_adcScale
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVLW	0x03
	ADDWF	FSR1L, F
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_getAlarmLow
	MOVWF	r0x00
	MOVFF	PRODL, r0x03
	MOVF	POSTINC1, F
	MOVF	r0x03, W
	ADDLW	0x80
	MOVWF	PRODL
	MOVF	r0x02, W
	ADDLW	0x80
	SUBWF	PRODL, W
	BNZ	_00126_DS_
	MOVF	r0x01, W
	SUBWF	r0x00, W
_00126_DS_:
	BNC	_00119_DS_
;	.line	25; alarm.c	return 1;        
	MOVLW	0x01
	BRA	_00121_DS_
_00119_DS_:
;	.line	28; alarm.c	return 0;   
	CLRF	WREG
_00121_DS_:
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_alarm__testAlarmHigh	code
_testAlarmHigh:
;	.line	14; alarm.c	char testAlarmHigh(char alarm){    
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	15; alarm.c	if(adcScale(POT, 1023) >= getAlarmHigh(alarm)){
	MOVLW	0x03
	MOVWF	POSTDEC1
	MOVLW	0xff
	MOVWF	POSTDEC1
	MOVLW	0x02
	MOVWF	POSTDEC1
	CALL	_adcScale
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVLW	0x03
	ADDWF	FSR1L, F
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_getAlarmHigh
	MOVWF	r0x00
	MOVFF	PRODL, r0x03
	MOVF	POSTINC1, F
	MOVF	r0x02, W
	ADDLW	0x80
	MOVWF	PRODL
	MOVF	r0x03, W
	ADDLW	0x80
	SUBWF	PRODL, W
	BNZ	_00113_DS_
	MOVF	r0x00, W
	SUBWF	r0x01, W
_00113_DS_:
	BNC	_00106_DS_
;	.line	16; alarm.c	return 1;                                 
	MOVLW	0x01
	BRA	_00108_DS_
_00106_DS_:
;	.line	19; alarm.c	return 0;           
	CLRF	WREG
_00108_DS_:
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
___str_0:
	DB	0x41, 0x6c, 0x61, 0x72, 0x6d, 0x20, 0x48, 0x69, 0x67, 0x68, 0x20, 0x30
	DB	0x20, 0x41, 0x63, 0x69, 0x6f, 0x6e, 0x61, 0x64, 0x6f, 0x00
; ; Starting pCode block
___str_1:
	DB	0x41, 0x6c, 0x61, 0x72, 0x6d, 0x20, 0x48, 0x69, 0x67, 0x68, 0x20, 0x30
	DB	0x20, 0x44, 0x65, 0x73, 0x6c, 0x69, 0x67, 0x61, 0x64, 0x6f, 0x00
; ; Starting pCode block
___str_2:
	DB	0x41, 0x6c, 0x61, 0x72, 0x6d, 0x20, 0x4c, 0x6f, 0x77, 0x20, 0x30, 0x20
	DB	0x41, 0x63, 0x69, 0x6f, 0x6e, 0x61, 0x64, 0x6f, 0x00
; ; Starting pCode block
___str_3:
	DB	0x41, 0x6c, 0x61, 0x72, 0x6d, 0x20, 0x4c, 0x6f, 0x77, 0x20, 0x30, 0x20
	DB	0x44, 0x65, 0x73, 0x6c, 0x69, 0x67, 0x61, 0x64, 0x6f, 0x00
; ; Starting pCode block
___str_4:
	DB	0x41, 0x6c, 0x61, 0x72, 0x6d, 0x20, 0x48, 0x69, 0x67, 0x68, 0x20, 0x31
	DB	0x20, 0x41, 0x63, 0x69, 0x6f, 0x6e, 0x61, 0x64, 0x6f, 0x00
; ; Starting pCode block
___str_5:
	DB	0x41, 0x6c, 0x61, 0x72, 0x6d, 0x20, 0x48, 0x69, 0x67, 0x68, 0x20, 0x31
	DB	0x20, 0x44, 0x65, 0x73, 0x6c, 0x69, 0x67, 0x61, 0x64, 0x6f, 0x00
; ; Starting pCode block
___str_6:
	DB	0x41, 0x6c, 0x61, 0x72, 0x6d, 0x20, 0x4c, 0x6f, 0x77, 0x20, 0x31, 0x20
	DB	0x41, 0x63, 0x69, 0x6f, 0x6e, 0x61, 0x64, 0x6f, 0x00
; ; Starting pCode block
___str_7:
	DB	0x41, 0x6c, 0x61, 0x72, 0x6d, 0x20, 0x4c, 0x6f, 0x77, 0x20, 0x31, 0x20
	DB	0x44, 0x65, 0x73, 0x6c, 0x69, 0x67, 0x61, 0x64, 0x6f, 0x00
; ; Starting pCode block
___str_8:
	DB	0x54, 0x69, 0x6d, 0x65, 0x3a, 0x20, 0x00
; ; Starting pCode block
___str_9:
	DB	0x44, 0x61, 0x74, 0x65, 0x3a, 0x20, 0x00


; Statistics:
; code size:	 1952 (0x07a0) bytes ( 1.49%)
;           	  976 (0x03d0) words
; udata size:	    0 (0x0000) bytes ( 0.00%)
; access size:	   15 (0x000f) bytes


	end
