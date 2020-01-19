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
	global	_varInit
	global	_varTest
	global	_getState
	global	_setState
	global	_getStateRst
	global	_setStateRst
	global	_getTime
	global	_setTime
	global	_getAlarmLow
	global	_setAlarmLow
	global	_getAlarmHigh
	global	_setAlarmHigh
	global	_getIdiom
	global	_setIdiom

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern	_rtcStore
	extern	_rtcStoreInt
	extern	_rtcRead
	extern	_rtcReadInt

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


; Internal registers
.registers	udata_ovr	0x0000
r0x00	res	1
r0x01	res	1
r0x02	res	1
r0x03	res	1
r0x04	res	1

udata_var_0	udata
_state	res	1

udata_var_1	udata
_stateRst	res	1

udata_var_2	udata
_idiom	res	1

udata_var_3	udata
_time	res	2

udata_var_4	udata
_alarmLow	res	2

udata_var_5	udata
_alarmHigh	res	2

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_var__setIdiom	code
_setIdiom:
;	.line	114; var.c	void setIdiom(char newIdiom){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	117; var.c	idiom = newIdiom%2; 
	MOVLW	0x01
	ANDWF	r0x00, W
	BANKSEL	_idiom
	MOVWF	_idiom, B
	BANKSEL	_idiom
;	.line	118; var.c	rtcStore(ADDRESS_IDIOM, idiom);
	MOVF	_idiom, W, B
	MOVWF	POSTDEC1
	MOVLW	0x8a
	MOVWF	POSTDEC1
	CALL	_rtcStore
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_var__getIdiom	code
_getIdiom:
;	.line	110; var.c	char getIdiom(void){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
;	.line	111; var.c	idiom = rtcRead(ADDRESS_IDIOM)%2;
	MOVLW	0x8a
	MOVWF	POSTDEC1
	CALL	_rtcRead
	MOVWF	r0x00
	MOVF	POSTINC1, F
	MOVLW	0x01
	ANDWF	r0x00, W
	BANKSEL	_idiom
	MOVWF	_idiom, B
	BANKSEL	_idiom
;	.line	112; var.c	return idiom;
	MOVF	_idiom, W, B
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_var__setAlarmHigh	code
_setAlarmHigh:
;	.line	101; var.c	void setAlarmHigh(char alarm, int newAlarmHigh) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
;	.line	102; var.c	if(newAlarmHigh > getAlarmLow(alarm) & newAlarmHigh > 0 & newAlarmHigh <= 9999){
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_getAlarmLow
	MOVWF	r0x03
	MOVFF	PRODL, r0x04
	MOVF	POSTINC1, F
	MOVF	r0x04, W
	ADDLW	0x80
	MOVWF	PRODL
	MOVF	r0x02, W
	ADDLW	0x80
	SUBWF	PRODL, W
	BNZ	_00257_DS_
	MOVF	r0x01, W
	SUBWF	r0x03, W
_00257_DS_:
	BTG	STATUS, 0
	CLRF	r0x03
	RLCF	r0x03, F
	MOVF	r0x02, W
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_00259_DS_
	MOVLW	0x01
	SUBWF	r0x01, W
_00259_DS_:
	CLRF	r0x04
	RLCF	r0x04, F
	MOVF	r0x04, W
	ANDWF	r0x03, F
	MOVF	r0x02, W
	ADDLW	0x80
	ADDLW	0x59
	BNZ	_00262_DS_
	MOVLW	0x10
	SUBWF	r0x01, W
_00262_DS_:
	CLRF	r0x04
	RLCF	r0x04, F
	MOVF	r0x04, W
	BSF	STATUS, 0
	TSTFSZ	WREG
	BCF	STATUS, 0
	CLRF	r0x04
	RLCF	r0x04, F
	MOVF	r0x04, W
	ANDWF	r0x03, F
	MOVF	r0x03, W
	BZ	_00248_DS_
;	.line	103; var.c	if(alarm%2 == 0)
	BTFSC	r0x00, 0
	BRA	_00244_DS_
;	.line	104; var.c	rtcStoreInt(ADDRESS_AH0, newAlarmHigh);	
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVLW	0xbc
	MOVWF	POSTDEC1
	CALL	_rtcStoreInt
	MOVLW	0x03
	ADDWF	FSR1L, F
	BRA	_00248_DS_
_00244_DS_:
;	.line	106; var.c	rtcStoreInt(ADDRESS_AH1, newAlarmHigh);
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVLW	0xae
	MOVWF	POSTDEC1
	CALL	_rtcStoreInt
	MOVLW	0x03
	ADDWF	FSR1L, F
_00248_DS_:
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_var__getAlarmHigh	code
_getAlarmHigh:
;	.line	94; var.c	int getAlarmHigh(char alarm) {    
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	95; var.c	if(alarm%2 == 0)
	BTFSC	r0x00, 0
	BRA	_00231_DS_
;	.line	96; var.c	alarmHigh = rtcReadInt(ADDRESS_AH0);	
	MOVLW	0xbc
	MOVWF	POSTDEC1
	CALL	_rtcReadInt
	BANKSEL	_alarmHigh
	MOVWF	_alarmHigh, B
	MOVFF	PRODL, (_alarmHigh + 1)
	MOVF	POSTINC1, F
	BRA	_00232_DS_
_00231_DS_:
;	.line	98; var.c	alarmHigh = rtcReadInt(ADDRESS_AH1);        
	MOVLW	0xae
	MOVWF	POSTDEC1
	CALL	_rtcReadInt
	BANKSEL	_alarmHigh
	MOVWF	_alarmHigh, B
	MOVFF	PRODL, (_alarmHigh + 1)
	MOVF	POSTINC1, F
_00232_DS_:
;	.line	99; var.c	return alarmHigh;
	MOVFF	(_alarmHigh + 1), PRODL
	BANKSEL	_alarmHigh
	MOVF	_alarmHigh, W, B
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_var__setAlarmLow	code
_setAlarmLow:
;	.line	86; var.c	void setAlarmLow(char alarm,int newAlarmLow) {    
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
;	.line	87; var.c	if(newAlarmLow < getAlarmHigh(alarm) & newAlarmLow > 0 & newAlarmLow <= 9999){
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_getAlarmHigh
	MOVWF	r0x03
	MOVFF	PRODL, r0x04
	MOVF	POSTINC1, F
	MOVF	r0x02, W
	ADDLW	0x80
	MOVWF	PRODL
	MOVF	r0x04, W
	ADDLW	0x80
	SUBWF	PRODL, W
	BNZ	_00219_DS_
	MOVF	r0x03, W
	SUBWF	r0x01, W
_00219_DS_:
	BTG	STATUS, 0
	CLRF	r0x03
	RLCF	r0x03, F
	MOVF	r0x02, W
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_00221_DS_
	MOVLW	0x01
	SUBWF	r0x01, W
_00221_DS_:
	CLRF	r0x04
	RLCF	r0x04, F
	MOVF	r0x04, W
	ANDWF	r0x03, F
	MOVF	r0x02, W
	ADDLW	0x80
	ADDLW	0x59
	BNZ	_00224_DS_
	MOVLW	0x10
	SUBWF	r0x01, W
_00224_DS_:
	CLRF	r0x04
	RLCF	r0x04, F
	MOVF	r0x04, W
	BSF	STATUS, 0
	TSTFSZ	WREG
	BCF	STATUS, 0
	CLRF	r0x04
	RLCF	r0x04, F
	MOVF	r0x04, W
	ANDWF	r0x03, F
	MOVF	r0x03, W
	BZ	_00210_DS_
;	.line	88; var.c	if(alarm%2 == 0)
	BTFSC	r0x00, 0
	BRA	_00206_DS_
;	.line	89; var.c	rtcStoreInt(ADDRESS_AL0, newAlarmLow);	
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVLW	0x58
	MOVWF	POSTDEC1
	CALL	_rtcStoreInt
	MOVLW	0x03
	ADDWF	FSR1L, F
	BRA	_00210_DS_
_00206_DS_:
;	.line	91; var.c	rtcStoreInt(ADDRESS_AL1, newAlarmLow);     
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVLW	0x76
	MOVWF	POSTDEC1
	CALL	_rtcStoreInt
	MOVLW	0x03
	ADDWF	FSR1L, F
_00210_DS_:
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_var__getAlarmLow	code
_getAlarmLow:
;	.line	79; var.c	int getAlarmLow(char alarm) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	80; var.c	if(alarm%2 == 0)
	BTFSC	r0x00, 0
	BRA	_00193_DS_
;	.line	81; var.c	alarmLow = rtcReadInt(ADDRESS_AL0);	
	MOVLW	0x58
	MOVWF	POSTDEC1
	CALL	_rtcReadInt
	BANKSEL	_alarmLow
	MOVWF	_alarmLow, B
	MOVFF	PRODL, (_alarmLow + 1)
	MOVF	POSTINC1, F
	BRA	_00194_DS_
_00193_DS_:
;	.line	83; var.c	alarmLow = rtcReadInt(ADDRESS_AL1);     
	MOVLW	0x76
	MOVWF	POSTDEC1
	CALL	_rtcReadInt
	BANKSEL	_alarmLow
	MOVWF	_alarmLow, B
	MOVFF	PRODL, (_alarmLow + 1)
	MOVF	POSTINC1, F
_00194_DS_:
;	.line	84; var.c	return alarmLow;
	MOVFF	(_alarmLow + 1), PRODL
	BANKSEL	_alarmLow
	MOVF	_alarmLow, W, B
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_var__setTime	code
_setTime:
;	.line	72; var.c	void setTime(int newTime) {
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
;	.line	73; var.c	if((newTime)>=0 & newTime <= 9999){
	BSF	STATUS, 0
	BTFSS	r0x01, 7
	BCF	STATUS, 0
	CLRF	r0x02
	RLCF	r0x02, F
	MOVF	r0x02, W
	BSF	STATUS, 0
	TSTFSZ	WREG
	BCF	STATUS, 0
	CLRF	r0x02
	RLCF	r0x02, F
	MOVF	r0x01, W
	ADDLW	0x80
	ADDLW	0x59
	BNZ	_00187_DS_
	MOVLW	0x10
	SUBWF	r0x00, W
_00187_DS_:
	CLRF	r0x03
	RLCF	r0x03, F
	MOVF	r0x03, W
	BSF	STATUS, 0
	TSTFSZ	WREG
	BCF	STATUS, 0
	CLRF	r0x03
	RLCF	r0x03, F
	MOVF	r0x03, W
	ANDWF	r0x02, F
	MOVF	r0x02, W
	BZ	_00180_DS_
;	.line	74; var.c	time = newTime; 
	MOVFF	r0x00, _time
	MOVFF	r0x01, (_time + 1)
	BANKSEL	(_time + 1)
;	.line	75; var.c	rtcStoreInt(ADDRESS_TIME, time);	
	MOVF	(_time + 1), W, B
	MOVWF	POSTDEC1
	BANKSEL	_time
	MOVF	_time, W, B
	MOVWF	POSTDEC1
	MOVLW	0xf4
	MOVWF	POSTDEC1
	CALL	_rtcStoreInt
	MOVLW	0x03
	ADDWF	FSR1L, F
_00180_DS_:
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_var__getTime	code
_getTime:
;	.line	68; var.c	int getTime(void) {      
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	69; var.c	time = rtcReadInt(ADDRESS_TIME);	
	MOVLW	0xf4
	MOVWF	POSTDEC1
	CALL	_rtcReadInt
	BANKSEL	_time
	MOVWF	_time, B
	MOVFF	PRODL, (_time + 1)
	MOVF	POSTINC1, F
;	.line	70; var.c	return time;
	MOVFF	(_time + 1), PRODL
	BANKSEL	_time
	MOVF	_time, W, B
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_var__setStateRst	code
_setStateRst:
;	.line	64; var.c	void setStateRst(char newStateRst) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVLW	0x02
	MOVFF	PLUSW2, _stateRst
;	.line	65; var.c	stateRst = newStateRst;
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_var__getStateRst	code
_getStateRst:
;	.line	61; var.c	char getStateRst(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	BANKSEL	_stateRst
;	.line	62; var.c	return stateRst;
	MOVF	_stateRst, W, B
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_var__setState	code
_setState:
;	.line	57; var.c	void setState(char newState) {   
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	58; var.c	rtcStore(ADDRESS_STATE, newState);
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x90
	MOVWF	POSTDEC1
	CALL	_rtcStore
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	59; var.c	state = newState;	
	MOVFF	r0x00, _state
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_var__getState	code
_getState:
;	.line	53; var.c	char getState(void) {    
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	54; var.c	state = rtcRead(ADDRESS_STATE);	
	MOVLW	0x90
	MOVWF	POSTDEC1
	CALL	_rtcRead
	BANKSEL	_state
	MOVWF	_state, B
	MOVF	POSTINC1, F
	BANKSEL	_state
;	.line	55; var.c	return state;
	MOVF	_state, W, B
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_var__varTest	code
_varTest:
;	.line	31; var.c	void varTest(void) {   
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
;	.line	32; var.c	if(getAlarmHigh(0)<= getAlarmLow(0)){            
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_getAlarmHigh
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVF	POSTINC1, F
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_getAlarmLow
	MOVWF	r0x02
	MOVFF	PRODL, r0x03
	MOVF	POSTINC1, F
	MOVF	r0x03, W
	ADDLW	0x80
	MOVWF	PRODL
	MOVF	r0x01, W
	ADDLW	0x80
	SUBWF	PRODL, W
	BNZ	_00147_DS_
	MOVF	r0x00, W
	SUBWF	r0x02, W
_00147_DS_:
	BNC	_00111_DS_
;	.line	33; var.c	rtcStoreInt(ADDRESS_AH0, 7000);
	MOVLW	0x1b
	MOVWF	POSTDEC1
	MOVLW	0x58
	MOVWF	POSTDEC1
	MOVLW	0xbc
	MOVWF	POSTDEC1
	CALL	_rtcStoreInt
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	34; var.c	rtcStoreInt(ADDRESS_AL0, 1000);
	MOVLW	0x03
	MOVWF	POSTDEC1
	MOVLW	0xe8
	MOVWF	POSTDEC1
	MOVLW	0x58
	MOVWF	POSTDEC1
	CALL	_rtcStoreInt
	MOVLW	0x03
	ADDWF	FSR1L, F
_00111_DS_:
;	.line	36; var.c	if(getAlarmHigh(1)<= getAlarmLow(1)){
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_getAlarmHigh
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVF	POSTINC1, F
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_getAlarmLow
	MOVWF	r0x02
	MOVFF	PRODL, r0x03
	MOVF	POSTINC1, F
	MOVF	r0x03, W
	ADDLW	0x80
	MOVWF	PRODL
	MOVF	r0x01, W
	ADDLW	0x80
	SUBWF	PRODL, W
	BNZ	_00148_DS_
	MOVF	r0x00, W
	SUBWF	r0x02, W
_00148_DS_:
	BNC	_00113_DS_
;	.line	37; var.c	rtcStoreInt(ADDRESS_AH1, 9000);
	MOVLW	0x23
	MOVWF	POSTDEC1
	MOVLW	0x28
	MOVWF	POSTDEC1
	MOVLW	0xae
	MOVWF	POSTDEC1
	CALL	_rtcStoreInt
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	38; var.c	rtcStoreInt(ADDRESS_AL1, 3000);
	MOVLW	0x0b
	MOVWF	POSTDEC1
	MOVLW	0xb8
	MOVWF	POSTDEC1
	MOVLW	0x76
	MOVWF	POSTDEC1
	CALL	_rtcStoreInt
	MOVLW	0x03
	ADDWF	FSR1L, F
_00113_DS_:
;	.line	40; var.c	if(getTime()<0)
	CALL	_getTime
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	BSF	STATUS, 0
	BTFSS	r0x01, 7
	BCF	STATUS, 0
	BNC	_00115_DS_
;	.line	41; var.c	setTime(1000);
	MOVLW	0x03
	MOVWF	POSTDEC1
	MOVLW	0xe8
	MOVWF	POSTDEC1
	CALL	_setTime
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
_00115_DS_:
;	.line	42; var.c	if(getAlarmHigh(0)<0)
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_getAlarmHigh
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVF	POSTINC1, F
	BSF	STATUS, 0
	BTFSS	r0x01, 7
	BCF	STATUS, 0
	BNC	_00117_DS_
;	.line	43; var.c	rtcStoreInt(ADDRESS_AH0, 7000);
	MOVLW	0x1b
	MOVWF	POSTDEC1
	MOVLW	0x58
	MOVWF	POSTDEC1
	MOVLW	0xbc
	MOVWF	POSTDEC1
	CALL	_rtcStoreInt
	MOVLW	0x03
	ADDWF	FSR1L, F
_00117_DS_:
;	.line	44; var.c	if(getAlarmHigh(1)<0)
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_getAlarmHigh
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVF	POSTINC1, F
	BSF	STATUS, 0
	BTFSS	r0x01, 7
	BCF	STATUS, 0
	BNC	_00119_DS_
;	.line	45; var.c	rtcStoreInt(ADDRESS_AH1, 9000);
	MOVLW	0x23
	MOVWF	POSTDEC1
	MOVLW	0x28
	MOVWF	POSTDEC1
	MOVLW	0xae
	MOVWF	POSTDEC1
	CALL	_rtcStoreInt
	MOVLW	0x03
	ADDWF	FSR1L, F
_00119_DS_:
;	.line	46; var.c	if(getAlarmLow(0)<0)
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_getAlarmLow
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVF	POSTINC1, F
	BSF	STATUS, 0
	BTFSS	r0x01, 7
	BCF	STATUS, 0
	BNC	_00121_DS_
;	.line	47; var.c	rtcStoreInt(ADDRESS_AL0, 1000);
	MOVLW	0x03
	MOVWF	POSTDEC1
	MOVLW	0xe8
	MOVWF	POSTDEC1
	MOVLW	0x58
	MOVWF	POSTDEC1
	CALL	_rtcStoreInt
	MOVLW	0x03
	ADDWF	FSR1L, F
_00121_DS_:
;	.line	48; var.c	if(getAlarmLow(1)<0)
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_getAlarmLow
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVF	POSTINC1, F
	BSF	STATUS, 0
	BTFSS	r0x01, 7
	BCF	STATUS, 0
	BNC	_00124_DS_
;	.line	49; var.c	rtcStoreInt(ADDRESS_AL1, 300);   
	MOVLW	0x01
	MOVWF	POSTDEC1
	MOVLW	0x2c
	MOVWF	POSTDEC1
	MOVLW	0x76
	MOVWF	POSTDEC1
	CALL	_rtcStoreInt
	MOVLW	0x03
	ADDWF	FSR1L, F
_00124_DS_:
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_var__varInit	code
_varInit:
;	.line	20; var.c	void varInit(void) {   
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	21; var.c	setState(0);    
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
;	.line	22; var.c	setIdiom(0);
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_setIdiom
	MOVF	POSTINC1, F
;	.line	23; var.c	setTime(1000);
	MOVLW	0x03
	MOVWF	POSTDEC1
	MOVLW	0xe8
	MOVWF	POSTDEC1
	CALL	_setTime
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	24; var.c	rtcStoreInt(ADDRESS_AL0, 1000);
	MOVLW	0x03
	MOVWF	POSTDEC1
	MOVLW	0xe8
	MOVWF	POSTDEC1
	MOVLW	0x58
	MOVWF	POSTDEC1
	CALL	_rtcStoreInt
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	25; var.c	rtcStoreInt(ADDRESS_AL1, 3000);     
	MOVLW	0x0b
	MOVWF	POSTDEC1
	MOVLW	0xb8
	MOVWF	POSTDEC1
	MOVLW	0x76
	MOVWF	POSTDEC1
	CALL	_rtcStoreInt
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	26; var.c	rtcStoreInt(ADDRESS_AH0, 7000);
	MOVLW	0x1b
	MOVWF	POSTDEC1
	MOVLW	0x58
	MOVWF	POSTDEC1
	MOVLW	0xbc
	MOVWF	POSTDEC1
	CALL	_rtcStoreInt
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	27; var.c	rtcStoreInt(ADDRESS_AH1, 9000);
	MOVLW	0x23
	MOVWF	POSTDEC1
	MOVLW	0x28
	MOVWF	POSTDEC1
	MOVLW	0xae
	MOVWF	POSTDEC1
	CALL	_rtcStoreInt
	MOVLW	0x03
	ADDWF	FSR1L, F
	MOVFF	PREINC1, FSR2L
	RETURN	



; Statistics:
; code size:	 1560 (0x0618) bytes ( 1.19%)
;           	  780 (0x030c) words
; udata size:	    9 (0x0009) bytes ( 0.50%)
; access size:	    5 (0x0005) bytes


	end
