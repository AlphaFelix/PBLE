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
	global	_kpInit
	global	_kpRead
	global	_tecla_pressionada

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern	_adcRead
	extern	__divuint

;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
STATUS	equ	0xfd8
WREG	equ	0xfe8
FSR1L	equ	0xfe1
FSR2L	equ	0xfd9
INDF0	equ	0xfef
POSTINC1	equ	0xfe6
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

udata_keypad_0	udata
_tecla_pressionada	res	1

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_keypad__kpRead	code
_kpRead:
;	.line	16; keypad.c	unsigned char kpRead (void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
;	.line	17; keypad.c	unsigned int Vteclado = 0, i; 
	CLRF	r0x00
	CLRF	r0x01
;	.line	19; keypad.c	for(i=0; i<50; i++) {
	CLRF	r0x02
	CLRF	r0x03
_00141_DS_:
;	.line	20; keypad.c	Vteclado += adcRead(KP);
	MOVLW	0x03
	MOVWF	POSTDEC1
	CALL	_adcRead
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVF	POSTINC1, F
	MOVF	r0x04, W
	ADDWF	r0x00, F
	MOVF	r0x05, W
	ADDWFC	r0x01, F
;	.line	19; keypad.c	for(i=0; i<50; i++) {
	INFSNZ	r0x02, F
	INCF	r0x03, F
	MOVLW	0x00
	SUBWF	r0x03, W
	BNZ	_00194_DS_
	MOVLW	0x32
	SUBWF	r0x02, W
_00194_DS_:
	BNC	_00141_DS_
;	.line	23; keypad.c	Vteclado = Vteclado/50;
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x32
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	__divuint
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVLW	0x04
	ADDWF	FSR1L, F
;	.line	25; keypad.c	if((Vteclado>=0)&&(Vteclado<170)) 
	MOVLW	0x00
	SUBWF	r0x01, W
	BNZ	_00195_DS_
	MOVLW	0xaa
	SUBWF	r0x00, W
_00195_DS_:
	BC	_00138_DS_
	BANKSEL	_tecla_pressionada
;	.line	28; keypad.c	if(tecla_pressionada!=1) {
	MOVF	_tecla_pressionada, W, B
	XORLW	0x01
	BNZ	_00197_DS_
	BRA	_00139_DS_
_00197_DS_:
;	.line	29; keypad.c	tecla_pressionada = 1;            
	MOVLW	0x01
	BANKSEL	_tecla_pressionada
	MOVWF	_tecla_pressionada, B
	BRA	_00139_DS_
_00138_DS_:
;	.line	32; keypad.c	else if((Vteclado>200)&&(Vteclado<=370)) 
	MOVLW	0x00
	SUBWF	r0x01, W
	BNZ	_00198_DS_
	MOVLW	0xc9
	SUBWF	r0x00, W
_00198_DS_:
	BNC	_00134_DS_
	MOVLW	0x01
	SUBWF	r0x01, W
	BNZ	_00199_DS_
	MOVLW	0x73
	SUBWF	r0x00, W
_00199_DS_:
	BC	_00134_DS_
	BANKSEL	_tecla_pressionada
;	.line	35; keypad.c	if(tecla_pressionada!=2) {
	MOVF	_tecla_pressionada, W, B
	XORLW	0x02
	BNZ	_00201_DS_
	BRA	_00139_DS_
_00201_DS_:
;	.line	36; keypad.c	tecla_pressionada = 2;           
	MOVLW	0x02
	BANKSEL	_tecla_pressionada
	MOVWF	_tecla_pressionada, B
	BRA	_00139_DS_
_00134_DS_:
;	.line	40; keypad.c	else if((Vteclado>450)&&(Vteclado<=500)) 
	MOVLW	0x01
	SUBWF	r0x01, W
	BNZ	_00202_DS_
	MOVLW	0xc3
	SUBWF	r0x00, W
_00202_DS_:
	BNC	_00130_DS_
	MOVLW	0x01
	SUBWF	r0x01, W
	BNZ	_00203_DS_
	MOVLW	0xf5
	SUBWF	r0x00, W
_00203_DS_:
	BC	_00130_DS_
	BANKSEL	_tecla_pressionada
;	.line	43; keypad.c	if(tecla_pressionada!=3) {
	MOVF	_tecla_pressionada, W, B
	XORLW	0x03
	BZ	_00139_DS_
;	.line	44; keypad.c	tecla_pressionada = 3;           
	MOVLW	0x03
	BANKSEL	_tecla_pressionada
	MOVWF	_tecla_pressionada, B
	BRA	_00139_DS_
_00130_DS_:
;	.line	49; keypad.c	else if((Vteclado>650)&&(Vteclado<=690)) 
	MOVLW	0x02
	SUBWF	r0x01, W
	BNZ	_00206_DS_
	MOVLW	0x8b
	SUBWF	r0x00, W
_00206_DS_:
	BNC	_00126_DS_
	MOVLW	0x02
	SUBWF	r0x01, W
	BNZ	_00207_DS_
	MOVLW	0xb3
	SUBWF	r0x00, W
_00207_DS_:
	BC	_00126_DS_
	BANKSEL	_tecla_pressionada
;	.line	51; keypad.c	if(tecla_pressionada!=4) {
	MOVF	_tecla_pressionada, W, B
	XORLW	0x04
	BZ	_00139_DS_
;	.line	52; keypad.c	tecla_pressionada = 4;           
	MOVLW	0x04
	BANKSEL	_tecla_pressionada
	MOVWF	_tecla_pressionada, B
	BRA	_00139_DS_
_00126_DS_:
;	.line	56; keypad.c	else if((Vteclado>720)&&(Vteclado<=780))
	MOVLW	0x02
	SUBWF	r0x01, W
	BNZ	_00210_DS_
	MOVLW	0xd1
	SUBWF	r0x00, W
_00210_DS_:
	BNC	_00122_DS_
	MOVLW	0x03
	SUBWF	r0x01, W
	BNZ	_00211_DS_
	MOVLW	0x0d
	SUBWF	r0x00, W
_00211_DS_:
	BC	_00122_DS_
	BANKSEL	_tecla_pressionada
;	.line	58; keypad.c	if(tecla_pressionada!=5) {
	MOVF	_tecla_pressionada, W, B
	XORLW	0x05
	BZ	_00139_DS_
;	.line	59; keypad.c	tecla_pressionada = 5;            
	MOVLW	0x05
	BANKSEL	_tecla_pressionada
	MOVWF	_tecla_pressionada, B
	BRA	_00139_DS_
_00122_DS_:
	BANKSEL	_tecla_pressionada
;	.line	63; keypad.c	tecla_pressionada = 0;
	CLRF	_tecla_pressionada, B
_00139_DS_:
	BANKSEL	_tecla_pressionada
;	.line	65; keypad.c	return tecla_pressionada;    
	MOVF	_tecla_pressionada, W, B
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_keypad__kpInit	code
_kpInit:
;	.line	5; keypad.c	void kpInit(void)   //Inicia o teclado a partir dos registros necessarios 
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
;	.line	7; keypad.c	bitClr(INTCON2, 7); //liga pull up   
	LFSR	0x00, 0xff1
	MOVFF	INDF0, r0x00
	BCF	r0x00, 7
	LFSR	0x00, 0xff1
	MOVFF	r0x00, INDF0
;	.line	8; keypad.c	bitSet(TRISE, 0);
	LFSR	0x00, 0xf96
	MOVFF	INDF0, r0x00
	BSF	r0x00, 0
	LFSR	0x00, 0xf96
	MOVFF	r0x00, INDF0
;	.line	10; keypad.c	SPPCFG = 0x00;          // SFR nao presente no PIC18F4520
	LFSR	0x00, 0xf63
	MOVLW	0x00
	MOVWF	INDF0
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	



; Statistics:
; code size:	  406 (0x0196) bytes ( 0.31%)
;           	  203 (0x00cb) words
; udata size:	    1 (0x0001) bytes ( 0.06%)
; access size:	    6 (0x0006) bytes


	end
