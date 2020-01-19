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
	global	_serialSend
	global	_serialInt
	global	_serialString
	global	_serialRead
	global	_serialInit
	global	_serialProtocol
	global	_code
	global	_mi
	global	_cen
	global	_dez
	global	_uni

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern	__gptrget1
	extern	_setTime
	extern	_setAlarmLow
	extern	_setAlarmHigh
	extern	_getIdiom
	extern	_setIdiom
	extern	__divsint
	extern	__modsint
	extern	__mulint

;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
STATUS	equ	0xfd8
WREG	equ	0xfe8
FSR0L	equ	0xfe9
FSR1L	equ	0xfe1
FSR2L	equ	0xfd9
INDF0	equ	0xfef
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
r0x05	res	1
r0x06	res	1

udata_serial_0	udata
_mi	res	1

udata_serial_1	udata
_cen	res	1

udata_serial_2	udata
_uni	res	1

udata_serial_3	udata
_dez	res	1

udata_serial_4	udata
_code	res	1

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_serial__serialProtocol	code
_serialProtocol:
;	.line	61; serial.c	unsigned char serialProtocol(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	BANKSEL	_code
;	.line	63; serial.c	if(code == 0){
	MOVF	_code, W, B
	BNZ	_00162_DS_
;	.line	64; serial.c	code = serialRead();
	CALL	_serialRead
	BANKSEL	_code
	MOVWF	_code, B
	BANKSEL	_code
;	.line	65; serial.c	return code;
	MOVF	_code, W, B
	GOTO	_00247_DS_
_00162_DS_:
	BANKSEL	_code
;	.line	68; serial.c	switch (code){
	MOVF	_code, W, B
	XORLW	0x43
	BNZ	_00412_DS_
	GOTO	_00244_DS_
_00412_DS_:
	BANKSEL	_code
	MOVF	_code, W, B
	XORLW	0x48
	BNZ	_00414_DS_
	BRA	_00177_DS_
_00414_DS_:
	BANKSEL	_code
	MOVF	_code, W, B
	XORLW	0x49
	BNZ	_00416_DS_
	GOTO	_00243_DS_
_00416_DS_:
	BANKSEL	_code
	MOVF	_code, W, B
	XORLW	0x4a
	BNZ	_00418_DS_
	BRA	_00191_DS_
_00418_DS_:
	BANKSEL	_code
	MOVF	_code, W, B
	XORLW	0x4b
	BNZ	_00420_DS_
	GOTO	_00221_DS_
_00420_DS_:
	BANKSEL	_code
	MOVF	_code, W, B
	XORLW	0x4c
	BNZ	_00422_DS_
	GOTO	_00205_DS_
_00422_DS_:
	BANKSEL	_code
	MOVF	_code, W, B
	XORLW	0x4d
	BNZ	_00424_DS_
	GOTO	_00235_DS_
_00424_DS_:
	BANKSEL	_code
	MOVF	_code, W, B
	XORLW	0x54
	BZ	_00426_DS_
	GOTO	_00245_DS_
_00426_DS_:
	BANKSEL	_mi
;	.line	70; serial.c	if(mi == 0){
	MOVF	_mi, W, B
	BNZ	_00165_DS_
;	.line	71; serial.c	mi = serialRead();
	CALL	_serialRead
	BANKSEL	_mi
	MOVWF	_mi, B
_00165_DS_:
	BANKSEL	_cen
;	.line	73; serial.c	if(cen == 0 && mi!=0){
	MOVF	_cen, W, B
	BNZ	_00167_DS_
	BANKSEL	_mi
	MOVF	_mi, W, B
	BZ	_00167_DS_
;	.line	74; serial.c	cen = serialRead();
	CALL	_serialRead
	BANKSEL	_cen
	MOVWF	_cen, B
_00167_DS_:
	BANKSEL	_dez
;	.line	76; serial.c	if(dez == 0 && cen!=0 ){
	MOVF	_dez, W, B
	BNZ	_00170_DS_
	BANKSEL	_cen
	MOVF	_cen, W, B
	BZ	_00170_DS_
;	.line	77; serial.c	dez = serialRead();
	CALL	_serialRead
	BANKSEL	_dez
	MOVWF	_dez, B
_00170_DS_:
	BANKSEL	_uni
;	.line	79; serial.c	if(uni == 0 && dez!=0 ){
	MOVF	_uni, W, B
	BNZ	_00173_DS_
	BANKSEL	_dez
	MOVF	_dez, W, B
	BZ	_00173_DS_
;	.line	80; serial.c	uni = serialRead();                
	CALL	_serialRead
	BANKSEL	_uni
	MOVWF	_uni, B
_00173_DS_:
	BANKSEL	_uni
;	.line	82; serial.c	if(uni !=0)
	MOVF	_uni, W, B
	BTFSC	STATUS, 2
	GOTO	_00246_DS_
;	.line	84; serial.c	soma = (mi-48)*1000 + (cen-48)*100 + (dez-48)*10 + uni-48;
	MOVFF	_mi, r0x00
	CLRF	r0x01
	MOVLW	0xd0
	ADDWF	r0x00, F
	BTFSS	STATUS, 0
	DECF	r0x01, F
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x03
	MOVWF	POSTDEC1
	MOVLW	0xe8
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVFF	_cen, r0x02
	CLRF	r0x03
	MOVLW	0xd0
	ADDWF	r0x02, F
	BTFSS	STATUS, 0
	DECF	r0x03, F
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x64
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x02
	MOVFF	PRODL, r0x03
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x02, W
	ADDWF	r0x00, F
	MOVF	r0x03, W
	ADDWFC	r0x01, F
	MOVFF	_dez, r0x02
	CLRF	r0x03
	MOVLW	0xd0
	ADDWF	r0x02, F
	BTFSS	STATUS, 0
	DECF	r0x03, F
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x0a
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x02
	MOVFF	PRODL, r0x03
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x02, W
	ADDWF	r0x00, F
	MOVF	r0x03, W
	ADDWFC	r0x01, F
	MOVFF	_uni, r0x02
	CLRF	r0x03
	MOVF	r0x02, W
	ADDWF	r0x00, F
	MOVF	r0x03, W
	ADDWFC	r0x01, F
	MOVLW	0xd0
	ADDWF	r0x00, F
	BTFSS	STATUS, 0
	DECF	r0x01, F
;	.line	85; serial.c	setTime (soma);
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_setTime
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
	BANKSEL	_code
;	.line	86; serial.c	code = 0;
	CLRF	_code, B
	BANKSEL	_uni
;	.line	87; serial.c	uni = 0;
	CLRF	_uni, B
	BANKSEL	_dez
;	.line	88; serial.c	dez = 0;
	CLRF	_dez, B
	BANKSEL	_mi
;	.line	89; serial.c	mi = 0;
	CLRF	_mi, B
	BANKSEL	_cen
;	.line	90; serial.c	cen = 0;
	CLRF	_cen, B
;	.line	93; serial.c	break; 
	GOTO	_00246_DS_
_00177_DS_:
	BANKSEL	_mi
;	.line	96; serial.c	if(mi == 0){
	MOVF	_mi, W, B
	BNZ	_00179_DS_
;	.line	97; serial.c	mi = serialRead();
	CALL	_serialRead
	BANKSEL	_mi
	MOVWF	_mi, B
_00179_DS_:
	BANKSEL	_cen
;	.line	99; serial.c	if(cen == 0 && mi!=0){
	MOVF	_cen, W, B
	BNZ	_00181_DS_
	BANKSEL	_mi
	MOVF	_mi, W, B
	BZ	_00181_DS_
;	.line	100; serial.c	cen = serialRead();
	CALL	_serialRead
	BANKSEL	_cen
	MOVWF	_cen, B
_00181_DS_:
	BANKSEL	_dez
;	.line	102; serial.c	if(dez == 0 && cen!=0 ){
	MOVF	_dez, W, B
	BNZ	_00184_DS_
	BANKSEL	_cen
	MOVF	_cen, W, B
	BZ	_00184_DS_
;	.line	103; serial.c	dez = serialRead();
	CALL	_serialRead
	BANKSEL	_dez
	MOVWF	_dez, B
_00184_DS_:
	BANKSEL	_uni
;	.line	105; serial.c	if(uni == 0 && dez!=0 ){
	MOVF	_uni, W, B
	BNZ	_00187_DS_
	BANKSEL	_dez
	MOVF	_dez, W, B
	BZ	_00187_DS_
;	.line	106; serial.c	uni = serialRead();                 
	CALL	_serialRead
	BANKSEL	_uni
	MOVWF	_uni, B
_00187_DS_:
	BANKSEL	_uni
;	.line	108; serial.c	if(uni !=0)
	MOVF	_uni, W, B
	BTFSC	STATUS, 2
	GOTO	_00246_DS_
;	.line	110; serial.c	soma = (mi-48)*1000 + (cen-48)*100 + (dez-48)*10 + uni-48;
	MOVFF	_mi, r0x02
	CLRF	r0x03
	MOVLW	0xd0
	ADDWF	r0x02, F
	BTFSS	STATUS, 0
	DECF	r0x03, F
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVLW	0x03
	MOVWF	POSTDEC1
	MOVLW	0xe8
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x02
	MOVFF	PRODL, r0x03
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVFF	_cen, r0x04
	CLRF	r0x05
	MOVLW	0xd0
	ADDWF	r0x04, F
	BTFSS	STATUS, 0
	DECF	r0x05, F
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x64
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x04, W
	ADDWF	r0x02, F
	MOVF	r0x05, W
	ADDWFC	r0x03, F
	MOVFF	_dez, r0x04
	CLRF	r0x05
	MOVLW	0xd0
	ADDWF	r0x04, F
	BTFSS	STATUS, 0
	DECF	r0x05, F
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x0a
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x04, W
	ADDWF	r0x02, F
	MOVF	r0x05, W
	ADDWFC	r0x03, F
	MOVFF	_uni, r0x04
	CLRF	r0x05
	MOVF	r0x04, W
	ADDWF	r0x02, F
	MOVF	r0x05, W
	ADDWFC	r0x03, F
	MOVF	r0x02, W
	ADDLW	0xd0
	MOVWF	r0x00
	MOVLW	0xff
	ADDWFC	r0x03, W
	MOVWF	r0x01
;	.line	111; serial.c	setAlarmHigh (0, soma);
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_setAlarmHigh
	MOVLW	0x03
	ADDWF	FSR1L, F
	BANKSEL	_code
;	.line	112; serial.c	code = 0;
	CLRF	_code, B
	BANKSEL	_uni
;	.line	113; serial.c	uni = 0;
	CLRF	_uni, B
	BANKSEL	_dez
;	.line	114; serial.c	dez = 0;
	CLRF	_dez, B
	BANKSEL	_mi
;	.line	115; serial.c	mi = 0;
	CLRF	_mi, B
	BANKSEL	_cen
;	.line	116; serial.c	cen = 0;
	CLRF	_cen, B
;	.line	118; serial.c	break;
	GOTO	_00246_DS_
_00191_DS_:
	BANKSEL	_mi
;	.line	121; serial.c	if(mi == 0){
	MOVF	_mi, W, B
	BNZ	_00193_DS_
;	.line	122; serial.c	mi = serialRead();
	CALL	_serialRead
	BANKSEL	_mi
	MOVWF	_mi, B
_00193_DS_:
	BANKSEL	_cen
;	.line	124; serial.c	if(cen == 0 && mi!=0){
	MOVF	_cen, W, B
	BNZ	_00195_DS_
	BANKSEL	_mi
	MOVF	_mi, W, B
	BZ	_00195_DS_
;	.line	125; serial.c	cen = serialRead();
	CALL	_serialRead
	BANKSEL	_cen
	MOVWF	_cen, B
_00195_DS_:
	BANKSEL	_dez
;	.line	127; serial.c	if(dez == 0 && cen!=0 ){
	MOVF	_dez, W, B
	BNZ	_00198_DS_
	BANKSEL	_cen
	MOVF	_cen, W, B
	BZ	_00198_DS_
;	.line	128; serial.c	dez = serialRead();
	CALL	_serialRead
	BANKSEL	_dez
	MOVWF	_dez, B
_00198_DS_:
	BANKSEL	_uni
;	.line	130; serial.c	if(uni == 0 && dez!=0 ){
	MOVF	_uni, W, B
	BNZ	_00201_DS_
	BANKSEL	_dez
	MOVF	_dez, W, B
	BZ	_00201_DS_
;	.line	131; serial.c	uni = serialRead();                 
	CALL	_serialRead
	BANKSEL	_uni
	MOVWF	_uni, B
_00201_DS_:
	BANKSEL	_uni
;	.line	133; serial.c	if(uni !=0)
	MOVF	_uni, W, B
	BTFSC	STATUS, 2
	GOTO	_00246_DS_
;	.line	135; serial.c	soma = (mi-48)*1000 + (cen-48)*100 + (dez-48)*10 + uni-48;
	MOVFF	_mi, r0x02
	CLRF	r0x03
	MOVLW	0xd0
	ADDWF	r0x02, F
	BTFSS	STATUS, 0
	DECF	r0x03, F
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVLW	0x03
	MOVWF	POSTDEC1
	MOVLW	0xe8
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x02
	MOVFF	PRODL, r0x03
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVFF	_cen, r0x04
	CLRF	r0x05
	MOVLW	0xd0
	ADDWF	r0x04, F
	BTFSS	STATUS, 0
	DECF	r0x05, F
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x64
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x04, W
	ADDWF	r0x02, F
	MOVF	r0x05, W
	ADDWFC	r0x03, F
	MOVFF	_dez, r0x04
	CLRF	r0x05
	MOVLW	0xd0
	ADDWF	r0x04, F
	BTFSS	STATUS, 0
	DECF	r0x05, F
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x0a
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x04, W
	ADDWF	r0x02, F
	MOVF	r0x05, W
	ADDWFC	r0x03, F
	MOVFF	_uni, r0x04
	CLRF	r0x05
	MOVF	r0x04, W
	ADDWF	r0x02, F
	MOVF	r0x05, W
	ADDWFC	r0x03, F
	MOVF	r0x02, W
	ADDLW	0xd0
	MOVWF	r0x00
	MOVLW	0xff
	ADDWFC	r0x03, W
	MOVWF	r0x01
;	.line	136; serial.c	setAlarmHigh (1, soma);
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_setAlarmHigh
	MOVLW	0x03
	ADDWF	FSR1L, F
	BANKSEL	_code
;	.line	137; serial.c	code = 0;
	CLRF	_code, B
	BANKSEL	_uni
;	.line	138; serial.c	uni = 0;
	CLRF	_uni, B
	BANKSEL	_dez
;	.line	139; serial.c	dez = 0;
	CLRF	_dez, B
	BANKSEL	_mi
;	.line	140; serial.c	mi = 0;
	CLRF	_mi, B
	BANKSEL	_cen
;	.line	141; serial.c	cen = 0;
	CLRF	_cen, B
;	.line	143; serial.c	break;
	GOTO	_00246_DS_
_00205_DS_:
	BANKSEL	_mi
;	.line	146; serial.c	if(mi == 0){
	MOVF	_mi, W, B
	BNZ	_00207_DS_
;	.line	147; serial.c	mi = serialRead();
	CALL	_serialRead
	BANKSEL	_mi
	MOVWF	_mi, B
_00207_DS_:
	BANKSEL	_cen
;	.line	149; serial.c	if(cen == 0 && mi!=0){
	MOVF	_cen, W, B
	BNZ	_00209_DS_
	BANKSEL	_mi
	MOVF	_mi, W, B
	BZ	_00209_DS_
;	.line	150; serial.c	cen = serialRead();
	CALL	_serialRead
	BANKSEL	_cen
	MOVWF	_cen, B
_00209_DS_:
	BANKSEL	_dez
;	.line	152; serial.c	if(dez == 0 && cen!=0 ){
	MOVF	_dez, W, B
	BNZ	_00212_DS_
	BANKSEL	_cen
	MOVF	_cen, W, B
	BZ	_00212_DS_
;	.line	153; serial.c	dez = serialRead();
	CALL	_serialRead
	BANKSEL	_dez
	MOVWF	_dez, B
_00212_DS_:
	BANKSEL	_uni
;	.line	155; serial.c	if(uni == 0 && dez!=0 ){
	MOVF	_uni, W, B
	BNZ	_00215_DS_
	BANKSEL	_dez
	MOVF	_dez, W, B
	BZ	_00215_DS_
;	.line	156; serial.c	uni = serialRead();                 
	CALL	_serialRead
	BANKSEL	_uni
	MOVWF	_uni, B
_00215_DS_:
	BANKSEL	_uni
;	.line	158; serial.c	if(uni !=0)
	MOVF	_uni, W, B
	BTFSC	STATUS, 2
	GOTO	_00246_DS_
;	.line	160; serial.c	soma = (mi-48)*1000 + (cen-48)*100 + (dez-48)*10 + uni-48;
	MOVFF	_mi, r0x02
	CLRF	r0x03
	MOVLW	0xd0
	ADDWF	r0x02, F
	BTFSS	STATUS, 0
	DECF	r0x03, F
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVLW	0x03
	MOVWF	POSTDEC1
	MOVLW	0xe8
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x02
	MOVFF	PRODL, r0x03
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVFF	_cen, r0x04
	CLRF	r0x05
	MOVLW	0xd0
	ADDWF	r0x04, F
	BTFSS	STATUS, 0
	DECF	r0x05, F
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x64
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x04, W
	ADDWF	r0x02, F
	MOVF	r0x05, W
	ADDWFC	r0x03, F
	MOVFF	_dez, r0x04
	CLRF	r0x05
	MOVLW	0xd0
	ADDWF	r0x04, F
	BTFSS	STATUS, 0
	DECF	r0x05, F
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x0a
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x04, W
	ADDWF	r0x02, F
	MOVF	r0x05, W
	ADDWFC	r0x03, F
	MOVFF	_uni, r0x04
	CLRF	r0x05
	MOVF	r0x04, W
	ADDWF	r0x02, F
	MOVF	r0x05, W
	ADDWFC	r0x03, F
	MOVF	r0x02, W
	ADDLW	0xd0
	MOVWF	r0x00
	MOVLW	0xff
	ADDWFC	r0x03, W
	MOVWF	r0x01
;	.line	161; serial.c	if(soma>=1024){
	MOVF	r0x01, W
	ADDLW	0x80
	ADDLW	0x7c
	BNZ	_00427_DS_
	MOVLW	0x00
	SUBWF	r0x00, W
_00427_DS_:
	BNC	_00218_DS_
;	.line	162; serial.c	soma = 1023;
	MOVLW	0xff
	MOVWF	r0x00
	MOVLW	0x03
	MOVWF	r0x01
;	.line	163; serial.c	setAlarmLow (0, soma);
	MOVLW	0x03
	MOVWF	POSTDEC1
	MOVLW	0xff
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_setAlarmLow
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	164; serial.c	serialString("Representação Estourada");
	MOVLW	UPPER(___str_0)
	MOVWF	r0x04
	MOVLW	HIGH(___str_0)
	MOVWF	r0x03
	MOVLW	LOW(___str_0)
	MOVWF	r0x02
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	_serialString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00218_DS_:
;	.line	166; serial.c	setAlarmLow (0, soma);
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_setAlarmLow
	MOVLW	0x03
	ADDWF	FSR1L, F
	BANKSEL	_code
;	.line	167; serial.c	code = 0;
	CLRF	_code, B
	BANKSEL	_uni
;	.line	168; serial.c	uni = 0;
	CLRF	_uni, B
	BANKSEL	_dez
;	.line	169; serial.c	dez = 0;
	CLRF	_dez, B
	BANKSEL	_mi
;	.line	170; serial.c	mi = 0;
	CLRF	_mi, B
	BANKSEL	_cen
;	.line	171; serial.c	cen = 0;
	CLRF	_cen, B
;	.line	173; serial.c	break;
	BRA	_00246_DS_
_00221_DS_:
	BANKSEL	_mi
;	.line	176; serial.c	if(mi == 0){
	MOVF	_mi, W, B
	BNZ	_00223_DS_
;	.line	177; serial.c	mi = serialRead();
	CALL	_serialRead
	BANKSEL	_mi
	MOVWF	_mi, B
_00223_DS_:
	BANKSEL	_cen
;	.line	179; serial.c	if(cen == 0 && mi!=0){
	MOVF	_cen, W, B
	BNZ	_00225_DS_
	BANKSEL	_mi
	MOVF	_mi, W, B
	BZ	_00225_DS_
;	.line	180; serial.c	cen = serialRead();
	CALL	_serialRead
	BANKSEL	_cen
	MOVWF	_cen, B
_00225_DS_:
	BANKSEL	_dez
;	.line	182; serial.c	if(dez == 0 && cen!=0 ){
	MOVF	_dez, W, B
	BNZ	_00228_DS_
	BANKSEL	_cen
	MOVF	_cen, W, B
	BZ	_00228_DS_
;	.line	183; serial.c	dez = serialRead();
	CALL	_serialRead
	BANKSEL	_dez
	MOVWF	_dez, B
_00228_DS_:
	BANKSEL	_uni
;	.line	185; serial.c	if(uni == 0 && dez!=0 ){
	MOVF	_uni, W, B
	BNZ	_00231_DS_
	BANKSEL	_dez
	MOVF	_dez, W, B
	BZ	_00231_DS_
;	.line	186; serial.c	uni = serialRead();                 
	CALL	_serialRead
	BANKSEL	_uni
	MOVWF	_uni, B
_00231_DS_:
	BANKSEL	_uni
;	.line	188; serial.c	if(uni !=0)
	MOVF	_uni, W, B
	BTFSC	STATUS, 2
	BRA	_00246_DS_
;	.line	190; serial.c	soma = (mi-48)*1000 + (cen-48)*100 + (dez-48)*10 + uni-48;           
	MOVFF	_mi, r0x02
	CLRF	r0x03
	MOVLW	0xd0
	ADDWF	r0x02, F
	BTFSS	STATUS, 0
	DECF	r0x03, F
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVLW	0x03
	MOVWF	POSTDEC1
	MOVLW	0xe8
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x02
	MOVFF	PRODL, r0x03
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVFF	_cen, r0x04
	CLRF	r0x05
	MOVLW	0xd0
	ADDWF	r0x04, F
	BTFSS	STATUS, 0
	DECF	r0x05, F
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x64
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x04, W
	ADDWF	r0x02, F
	MOVF	r0x05, W
	ADDWFC	r0x03, F
	MOVFF	_dez, r0x04
	CLRF	r0x05
	MOVLW	0xd0
	ADDWF	r0x04, F
	BTFSS	STATUS, 0
	DECF	r0x05, F
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x0a
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x04, W
	ADDWF	r0x02, F
	MOVF	r0x05, W
	ADDWFC	r0x03, F
	MOVFF	_uni, r0x04
	CLRF	r0x05
	MOVF	r0x04, W
	ADDWF	r0x02, F
	MOVF	r0x05, W
	ADDWFC	r0x03, F
	MOVF	r0x02, W
	ADDLW	0xd0
	MOVWF	r0x00
	MOVLW	0xff
	ADDWFC	r0x03, W
	MOVWF	r0x01
;	.line	192; serial.c	setAlarmLow (1, soma);
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_setAlarmLow
	MOVLW	0x03
	ADDWF	FSR1L, F
	BANKSEL	_code
;	.line	193; serial.c	code = 0;
	CLRF	_code, B
	BANKSEL	_uni
;	.line	194; serial.c	uni = 0;
	CLRF	_uni, B
	BANKSEL	_dez
;	.line	195; serial.c	dez = 0;
	CLRF	_dez, B
	BANKSEL	_mi
;	.line	196; serial.c	mi = 0;
	CLRF	_mi, B
	BANKSEL	_cen
;	.line	197; serial.c	cen = 0;
	CLRF	_cen, B
;	.line	199; serial.c	break;
	BRA	_00246_DS_
_00235_DS_:
	BANKSEL	_mi
;	.line	201; serial.c	if(mi == 0){
	MOVF	_mi, W, B
	BNZ	_00237_DS_
;	.line	202; serial.c	mi = serialRead();
	CALL	_serialRead
	BANKSEL	_mi
	MOVWF	_mi, B
_00237_DS_:
	BANKSEL	_cen
;	.line	204; serial.c	if(cen == 0 && mi!=0){
	MOVF	_cen, W, B
	BNZ	_00239_DS_
	BANKSEL	_mi
	MOVF	_mi, W, B
	BZ	_00239_DS_
;	.line	205; serial.c	cen = serialRead();
	CALL	_serialRead
	BANKSEL	_cen
	MOVWF	_cen, B
_00239_DS_:
	BANKSEL	_cen
;	.line	207; serial.c	if(cen !=0)
	MOVF	_cen, W, B
	BTFSC	STATUS, 2
	BRA	_00243_DS_
;	.line	209; serial.c	soma = (mi-48)*1000 + (cen-48)*100 + (dez-48)*10 + uni-48;           
	MOVFF	_mi, r0x02
	CLRF	r0x03
	MOVLW	0xd0
	ADDWF	r0x02, F
	BTFSS	STATUS, 0
	DECF	r0x03, F
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVLW	0x03
	MOVWF	POSTDEC1
	MOVLW	0xe8
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x02
	MOVFF	PRODL, r0x03
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVFF	_cen, r0x04
	CLRF	r0x05
	MOVLW	0xd0
	ADDWF	r0x04, F
	BTFSS	STATUS, 0
	DECF	r0x05, F
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x64
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x04, W
	ADDWF	r0x02, F
	MOVF	r0x05, W
	ADDWFC	r0x03, F
	MOVFF	_dez, r0x04
	CLRF	r0x05
	MOVLW	0xd0
	ADDWF	r0x04, F
	BTFSS	STATUS, 0
	DECF	r0x05, F
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x0a
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x04, W
	ADDWF	r0x02, F
	MOVF	r0x05, W
	ADDWFC	r0x03, F
	MOVFF	_uni, r0x04
	CLRF	r0x05
	MOVF	r0x04, W
	ADDWF	r0x02, F
	MOVF	r0x05, W
	ADDWFC	r0x03, F
	MOVF	r0x02, W
	ADDLW	0xd0
	MOVWF	r0x00
	MOVLW	0xff
	ADDWFC	r0x03, W
	MOVWF	r0x01
;	.line	211; serial.c	setAlarmLow (1, soma);
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_setAlarmLow
	MOVLW	0x03
	ADDWF	FSR1L, F
	BANKSEL	_code
;	.line	212; serial.c	code = 0;
	CLRF	_code, B
	BANKSEL	_uni
;	.line	213; serial.c	uni = 0;
	CLRF	_uni, B
	BANKSEL	_dez
;	.line	214; serial.c	dez = 0;
	CLRF	_dez, B
	BANKSEL	_mi
;	.line	215; serial.c	mi = 0;
	CLRF	_mi, B
	BANKSEL	_cen
;	.line	216; serial.c	cen = 0;
	CLRF	_cen, B
_00243_DS_:
;	.line	219; serial.c	setIdiom(getIdiom() + 1);
	CALL	_getIdiom
	MOVWF	r0x00
	INCF	r0x00, F
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_setIdiom
	MOVF	POSTINC1, F
	BANKSEL	_code
;	.line	220; serial.c	code = 0;
	CLRF	_code, B
	BANKSEL	_uni
;	.line	221; serial.c	uni = 0;
	CLRF	_uni, B
	BANKSEL	_dez
;	.line	222; serial.c	dez = 0;
	CLRF	_dez, B
	BANKSEL	_cen
;	.line	223; serial.c	cen = 0;
	CLRF	_cen, B
	BANKSEL	_mi
;	.line	224; serial.c	mi = 0;            
	CLRF	_mi, B
;	.line	225; serial.c	break;
	BRA	_00246_DS_
_00244_DS_:
	BANKSEL	_code
;	.line	228; serial.c	code = 0;
	CLRF	_code, B
	BANKSEL	_uni
;	.line	229; serial.c	uni = 0;
	CLRF	_uni, B
	BANKSEL	_dez
;	.line	230; serial.c	dez = 0;
	CLRF	_dez, B
	BANKSEL	_cen
;	.line	231; serial.c	cen = 0;
	CLRF	_cen, B
	BANKSEL	_mi
;	.line	232; serial.c	mi = 0;
	CLRF	_mi, B
;	.line	234; serial.c	break;
	BRA	_00246_DS_
_00245_DS_:
	BANKSEL	_code
;	.line	236; serial.c	default: code = 0; 
	CLRF	_code, B
	BANKSEL	_uni
;	.line	237; serial.c	uni = 0;
	CLRF	_uni, B
	BANKSEL	_dez
;	.line	238; serial.c	dez = 0;
	CLRF	_dez, B
	BANKSEL	_mi
;	.line	239; serial.c	mi = 0;
	CLRF	_mi, B
	BANKSEL	_cen
;	.line	240; serial.c	cen = 0;
	CLRF	_cen, B
_00246_DS_:
	BANKSEL	_code
;	.line	243; serial.c	return code;
	MOVF	_code, W, B
_00247_DS_:
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_serial__serialInit	code
_serialInit:
;	.line	50; serial.c	void serialInit(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
;	.line	51; serial.c	TXSTA = 0b00101100; //configura a transmissão de dados da serial
	LFSR	0x00, 0xfac
	MOVLW	0x2c
	MOVWF	INDF0
;	.line	52; serial.c	RCSTA = 0b10010000; //configura a recepção de dados da serial
	LFSR	0x00, 0xfab
	MOVLW	0x90
	MOVWF	INDF0
;	.line	53; serial.c	BAUDCON = 0b00001000; //configura sistema de velocidade da serial
	LFSR	0x00, 0xfb8
	MOVLW	0x08
	MOVWF	INDF0
;	.line	54; serial.c	SPBRGH = 0b00000000; //configura para 56k
	LFSR	0x00, 0xfb0
	MOVLW	0x00
	MOVWF	INDF0
;	.line	55; serial.c	SPBRG = 51; //configura para 56k
	LFSR	0x00, 0xfaf
	MOVLW	0x33
	MOVWF	INDF0
;	.line	56; serial.c	bitSet(TRISC, 6); //pino de recepção de dados
	LFSR	0x00, 0xf94
	MOVFF	INDF0, r0x00
	BSF	r0x00, 6
	LFSR	0x00, 0xf94
	MOVFF	r0x00, INDF0
;	.line	57; serial.c	bitSet(TRISC, 7); //pino de envio de dados
	LFSR	0x00, 0xf94
	MOVFF	INDF0, r0x00
	BSF	r0x00, 7
	LFSR	0x00, 0xf94
	MOVFF	r0x00, INDF0
	BANKSEL	_mi
;	.line	58; serial.c	mi = 0, cen = 0, uni = 0, dez = 0, code = 0;
	CLRF	_mi, B
	BANKSEL	_cen
	CLRF	_cen, B
	BANKSEL	_uni
	CLRF	_uni, B
	BANKSEL	_dez
	CLRF	_dez, B
	BANKSEL	_code
	CLRF	_code, B
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_serial__serialRead	code
_serialRead:
;	.line	34; serial.c	unsigned char serialRead(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
;	.line	35; serial.c	char resp = 0;    
	CLRF	r0x00
;	.line	37; serial.c	if (bitTst(RCSTA, 1)) //Verifica se há erro de overrun e reseta a serial
	LFSR	0x00, 0xfab
	MOVFF	INDF0, r0x01
	BTFSS	r0x01, 1
	BRA	_00137_DS_
;	.line	39; serial.c	bitClr(RCSTA, 4);
	LFSR	0x00, 0xfab
	MOVFF	INDF0, r0x01
	BCF	r0x01, 4
	LFSR	0x00, 0xfab
	MOVFF	r0x01, INDF0
;	.line	40; serial.c	bitSet(RCSTA, 4);
	LFSR	0x00, 0xfab
	MOVFF	INDF0, r0x01
	BSF	r0x01, 4
	LFSR	0x00, 0xfab
	MOVFF	r0x01, INDF0
_00137_DS_:
;	.line	43; serial.c	if (bitTst(PIR1, 5)) //Verifica se existe algum valor disponivel
	LFSR	0x00, 0xf9e
	MOVFF	INDF0, r0x01
	BTFSS	r0x01, 5
	BRA	_00139_DS_
;	.line	45; serial.c	resp = RCREG; //retorna o valor
	LFSR	0x00, 0xfae
	MOVFF	INDF0, r0x00
_00139_DS_:
;	.line	47; serial.c	return resp; //retorna zero
	MOVF	r0x00, W
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_serial__serialString	code
_serialString:
;	.line	23; serial.c	void serialString(char vector[])
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
;	.line	27; serial.c	while(vector[i])
	CLRF	r0x03
_00128_DS_:
	MOVF	r0x03, W
	ADDWF	r0x00, W
	MOVWF	r0x04
	CLRF	WREG
	ADDWFC	r0x01, W
	MOVWF	r0x05
	CLRF	WREG
	ADDWFC	r0x02, W
	MOVWF	r0x06
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, PRODL
	MOVF	r0x06, W
	CALL	__gptrget1
	MOVWF	r0x04
	MOVF	r0x04, W
	BZ	_00131_DS_
;	.line	29; serial.c	serialSend(vector[i]);
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_serialSend
	MOVF	POSTINC1, F
;	.line	30; serial.c	i++;
	INCF	r0x03, F
	BRA	_00128_DS_
_00131_DS_:
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
S_serial__serialInt	code
_serialInt:
;	.line	12; serial.c	void serialInt(int val) {
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
;	.line	13; serial.c	if (val < 0) {
	BSF	STATUS, 0
	BTFSS	r0x01, 7
	BCF	STATUS, 0
	BNC	_00122_DS_
;	.line	14; serial.c	val = val * (-1);
	COMF	r0x01, F
	NEGF	r0x00
	BTFSC	STATUS, 2
	INCF	r0x01, F
;	.line	15; serial.c	serialSend('-');
	MOVLW	0x2d
	MOVWF	POSTDEC1
	CALL	_serialSend
	MOVF	POSTINC1, F
_00122_DS_:
;	.line	17; serial.c	serialSend((val / 1000) % 10 + 48);
	MOVLW	0x03
	MOVWF	POSTDEC1
	MOVLW	0xe8
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	__divsint
	MOVWF	r0x02
	MOVFF	PRODL, r0x03
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x0a
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	__modsint
	MOVWF	r0x02
	MOVFF	PRODL, r0x03
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	0x30
	ADDWF	r0x02, F
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	_serialSend
	MOVF	POSTINC1, F
;	.line	18; serial.c	serialSend((val / 100) % 10 + 48);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x64
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	__divsint
	MOVWF	r0x02
	MOVFF	PRODL, r0x03
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x0a
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	__modsint
	MOVWF	r0x02
	MOVFF	PRODL, r0x03
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	0x30
	ADDWF	r0x02, F
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	_serialSend
	MOVF	POSTINC1, F
;	.line	19; serial.c	serialSend((val / 10) % 10 + 48);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x0a
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	__divsint
	MOVWF	r0x02
	MOVFF	PRODL, r0x03
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x0a
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	__modsint
	MOVWF	r0x02
	MOVFF	PRODL, r0x03
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	0x30
	ADDWF	r0x02, F
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	_serialSend
	MOVF	POSTINC1, F
;	.line	20; serial.c	serialSend((val / 1) % 10 + 48);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x0a
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	__modsint
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	0x30
	ADDWF	r0x00, F
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_serialSend
	MOVF	POSTINC1, F
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_serial__serialSend	code
_serialSend:
;	.line	7; serial.c	void serialSend(unsigned char c) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
_00105_DS_:
;	.line	8; serial.c	while (!bitTst(PIR1, 4)); //Wait register becomes available 
	LFSR	0x00, 0xf9e
	MOVFF	INDF0, r0x01
	BTFSS	r0x01, 4
	BRA	_00105_DS_
;	.line	9; serial.c	TXREG = c; //Puts the value to be send 
	LFSR	0x00, 0xfad
	MOVFF	r0x00, INDF0
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
___str_0:
	DB	0x52, 0x65, 0x70, 0x72, 0x65, 0x73, 0x65, 0x6e, 0x74, 0x61, 0xe7, 0xe3
	DB	0x6f, 0x20, 0x45, 0x73, 0x74, 0x6f, 0x75, 0x72, 0x61, 0x64, 0x61, 0x00


; Statistics:
; code size:	 2860 (0x0b2c) bytes ( 2.18%)
;           	 1430 (0x0596) words
; udata size:	    5 (0x0005) bytes ( 0.28%)
; access size:	    7 (0x0007) bytes


	end
