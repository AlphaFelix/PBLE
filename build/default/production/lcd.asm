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
	global	_delay40us
	global	_delay2ms
	global	_pulsoEN
	global	_lcdCommand
	global	_lcdLine
	global	_lcdData
	global	_lcdInt
	global	_lcdString
	global	_lcdInit

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern	__gptrget1
	extern	__divsint
	extern	__modsint

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

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_lcd__lcdInit	code
_lcdInit:
;	.line	147; lcd.c	void lcdInit(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
;	.line	152; lcd.c	delay2ms();
	CALL	_delay2ms
;	.line	153; lcd.c	delay2ms();
	CALL	_delay2ms
;	.line	154; lcd.c	delay2ms();
	CALL	_delay2ms
;	.line	157; lcd.c	bitClr(TRISA,RS);	//RS
	LFSR	0x00, 0xf92
	MOVFF	INDF0, r0x00
	BCF	r0x00, 0
	LFSR	0x00, 0xf92
	MOVFF	r0x00, INDF0
;	.line	158; lcd.c	bitClr(TRISA,EN);	//EN
	LFSR	0x00, 0xf92
	MOVFF	INDF0, r0x00
	BCF	r0x00, 1
	LFSR	0x00, 0xf92
	MOVFF	r0x00, INDF0
;	.line	162; lcd.c	bitClr(TRISD,D1);
	LFSR	0x00, 0xf95
	MOVFF	INDF0, r0x00
	BCF	r0x00, 7
	LFSR	0x00, 0xf95
	MOVFF	r0x00, INDF0
;	.line	163; lcd.c	bitClr(TRISD,D2);
	LFSR	0x00, 0xf95
	MOVFF	INDF0, r0x00
	BCF	r0x00, 6
	LFSR	0x00, 0xf95
	MOVFF	r0x00, INDF0
;	.line	164; lcd.c	bitClr(TRISD,D3);
	LFSR	0x00, 0xf95
	MOVFF	INDF0, r0x00
	BCF	r0x00, 5
	LFSR	0x00, 0xf95
	MOVFF	r0x00, INDF0
;	.line	165; lcd.c	bitClr(TRISD,D4);
	LFSR	0x00, 0xf95
	MOVFF	INDF0, r0x00
	BCF	r0x00, 4
	LFSR	0x00, 0xf95
	MOVFF	r0x00, INDF0
;	.line	167; lcd.c	bitClr(PORTA,RS);
	LFSR	0x00, 0xf80
	MOVFF	INDF0, r0x00
	BCF	r0x00, 0
	LFSR	0x00, 0xf80
	MOVFF	r0x00, INDF0
;	.line	168; lcd.c	bitClr(PORTA,EN);
	LFSR	0x00, 0xf80
	MOVFF	INDF0, r0x00
	BCF	r0x00, 1
	LFSR	0x00, 0xf80
	MOVFF	r0x00, INDF0
;	.line	170; lcd.c	delay2ms();
	CALL	_delay2ms
;	.line	175; lcd.c	bitClr(PORTD,D4);
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x00
	BCF	r0x00, 4
	LFSR	0x00, 0xf83
	MOVFF	r0x00, INDF0
;	.line	176; lcd.c	bitClr(PORTD,D3);
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x00
	BCF	r0x00, 5
	LFSR	0x00, 0xf83
	MOVFF	r0x00, INDF0
;	.line	177; lcd.c	bitSet(PORTD,D2);	
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x00
	BSF	r0x00, 6
	LFSR	0x00, 0xf83
	MOVFF	r0x00, INDF0
;	.line	178; lcd.c	bitSet(PORTD,D1);
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x00
	BSF	r0x00, 7
	LFSR	0x00, 0xf83
	MOVFF	r0x00, INDF0
;	.line	180; lcd.c	pulsoEN();
	CALL	_pulsoEN
;	.line	182; lcd.c	bitClr(PORTD,D4);
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x00
	BCF	r0x00, 4
	LFSR	0x00, 0xf83
	MOVFF	r0x00, INDF0
;	.line	183; lcd.c	bitClr(PORTD,D3);
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x00
	BCF	r0x00, 5
	LFSR	0x00, 0xf83
	MOVFF	r0x00, INDF0
;	.line	184; lcd.c	bitSet(PORTD,D2);	
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x00
	BSF	r0x00, 6
	LFSR	0x00, 0xf83
	MOVFF	r0x00, INDF0
;	.line	185; lcd.c	bitSet(PORTD,D1);
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x00
	BSF	r0x00, 7
	LFSR	0x00, 0xf83
	MOVFF	r0x00, INDF0
;	.line	187; lcd.c	pulsoEN();
	CALL	_pulsoEN
;	.line	189; lcd.c	bitClr(PORTD,D4);
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x00
	BCF	r0x00, 4
	LFSR	0x00, 0xf83
	MOVFF	r0x00, INDF0
;	.line	190; lcd.c	bitClr(PORTD,D3);
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x00
	BCF	r0x00, 5
	LFSR	0x00, 0xf83
	MOVFF	r0x00, INDF0
;	.line	191; lcd.c	bitSet(PORTD,D2);	
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x00
	BSF	r0x00, 6
	LFSR	0x00, 0xf83
	MOVFF	r0x00, INDF0
;	.line	192; lcd.c	bitSet(PORTD,D1);
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x00
	BSF	r0x00, 7
	LFSR	0x00, 0xf83
	MOVFF	r0x00, INDF0
;	.line	194; lcd.c	pulsoEN();
	CALL	_pulsoEN
;	.line	196; lcd.c	bitClr(PORTD,D4);
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x00
	BCF	r0x00, 4
	LFSR	0x00, 0xf83
	MOVFF	r0x00, INDF0
;	.line	197; lcd.c	bitClr(PORTD,D3);
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x00
	BCF	r0x00, 5
	LFSR	0x00, 0xf83
	MOVFF	r0x00, INDF0
;	.line	198; lcd.c	bitSet(PORTD,D2);	
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x00
	BSF	r0x00, 6
	LFSR	0x00, 0xf83
	MOVFF	r0x00, INDF0
;	.line	199; lcd.c	bitClr(PORTD,D1);
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x00
	BCF	r0x00, 7
	LFSR	0x00, 0xf83
	MOVFF	r0x00, INDF0
;	.line	201; lcd.c	pulsoEN();
	CALL	_pulsoEN
;	.line	203; lcd.c	bitClr(PORTD,D4);
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x00
	BCF	r0x00, 4
	LFSR	0x00, 0xf83
	MOVFF	r0x00, INDF0
;	.line	204; lcd.c	bitClr(PORTD,D3);
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x00
	BCF	r0x00, 5
	LFSR	0x00, 0xf83
	MOVFF	r0x00, INDF0
;	.line	205; lcd.c	bitSet(PORTD,D2);	
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x00
	BSF	r0x00, 6
	LFSR	0x00, 0xf83
	MOVFF	r0x00, INDF0
;	.line	206; lcd.c	bitClr(PORTD,D1);
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x00
	BCF	r0x00, 7
	LFSR	0x00, 0xf83
	MOVFF	r0x00, INDF0
;	.line	208; lcd.c	pulsoEN();
	CALL	_pulsoEN
;	.line	210; lcd.c	bitClr(PORTD,D4);
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x00
	BCF	r0x00, 4
	LFSR	0x00, 0xf83
	MOVFF	r0x00, INDF0
;	.line	211; lcd.c	bitClr(PORTD,D3);
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x00
	BCF	r0x00, 5
	LFSR	0x00, 0xf83
	MOVFF	r0x00, INDF0
;	.line	212; lcd.c	bitClr(PORTD,D1);
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x00
	BCF	r0x00, 7
	LFSR	0x00, 0xf83
	MOVFF	r0x00, INDF0
;	.line	213; lcd.c	bitSet(PORTD,D2);
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x00
	BSF	r0x00, 6
	LFSR	0x00, 0xf83
	MOVFF	r0x00, INDF0
;	.line	215; lcd.c	pulsoEN();
	CALL	_pulsoEN
;	.line	217; lcd.c	bitClr(PORTD,D4);
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x00
	BCF	r0x00, 4
	LFSR	0x00, 0xf83
	MOVFF	r0x00, INDF0
;	.line	218; lcd.c	bitClr(PORTD,D3);
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x00
	BCF	r0x00, 5
	LFSR	0x00, 0xf83
	MOVFF	r0x00, INDF0
;	.line	219; lcd.c	bitClr(PORTD,D2);	
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x00
	BCF	r0x00, 6
	LFSR	0x00, 0xf83
	MOVFF	r0x00, INDF0
;	.line	220; lcd.c	bitClr(PORTD,D1);
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x00
	BCF	r0x00, 7
	LFSR	0x00, 0xf83
	MOVFF	r0x00, INDF0
;	.line	222; lcd.c	pulsoEN();
	CALL	_pulsoEN
;	.line	224; lcd.c	bitSet(PORTD,D4);
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x00
	BSF	r0x00, 4
	LFSR	0x00, 0xf83
	MOVFF	r0x00, INDF0
;	.line	225; lcd.c	bitSet(PORTD,D3);
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x00
	BSF	r0x00, 5
	LFSR	0x00, 0xf83
	MOVFF	r0x00, INDF0
;	.line	226; lcd.c	bitSet(PORTD,D2);	
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x00
	BSF	r0x00, 6
	LFSR	0x00, 0xf83
	MOVFF	r0x00, INDF0
;	.line	227; lcd.c	bitSet(PORTD,D1);
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x00
	BSF	r0x00, 7
	LFSR	0x00, 0xf83
	MOVFF	r0x00, INDF0
;	.line	229; lcd.c	pulsoEN();
	CALL	_pulsoEN
;	.line	233; lcd.c	lcdCommand(0x01); //limpa o display
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	235; lcd.c	lcdCommand(0x2b); //4bits, 2 linhas, 5x8 tamanho
	MOVLW	0x2b
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	237; lcd.c	lcdCommand(0x0f); //display on, cursor e blink off
	MOVLW	0x0f
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	239; lcd.c	lcdCommand(0b00000110);	// Entry mode set: Increment, Shift OFF
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	241; lcd.c	lcdCommand(0b00010100);	// Entry mode set         
	MOVLW	0x14
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	243; lcd.c	lcdCommand(0x80); // Vai para primeira linha
	MOVLW	0x80
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_lcd__lcdString	code
_lcdString:
;	.line	136; lcd.c	void lcdString(char vector[])
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
;	.line	140; lcd.c	while(vector[i])
	CLRF	r0x03
_00305_DS_:
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
	BZ	_00308_DS_
;	.line	142; lcd.c	lcdData(vector[i]);
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdData
	MOVF	POSTINC1, F
;	.line	143; lcd.c	i++;
	INCF	r0x03, F
	BRA	_00305_DS_
_00308_DS_:
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
S_lcd__lcdInt	code
_lcdInt:
;	.line	123; lcd.c	void lcdInt(int val) {
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
;	.line	124; lcd.c	if (val < 0) {
	BSF	STATUS, 0
	BTFSS	r0x01, 7
	BCF	STATUS, 0
	BNC	_00299_DS_
;	.line	125; lcd.c	val = val * (-1);
	COMF	r0x01, F
	NEGF	r0x00
	BTFSC	STATUS, 2
	INCF	r0x01, F
;	.line	126; lcd.c	lcdData('-');
	MOVLW	0x2d
	MOVWF	POSTDEC1
	CALL	_lcdData
	MOVF	POSTINC1, F
_00299_DS_:
;	.line	128; lcd.c	lcdData((val / 1000) % 10 + 48);
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
	CALL	_lcdData
	MOVF	POSTINC1, F
;	.line	129; lcd.c	lcdData((val / 100) % 10 + 48);
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
	CALL	_lcdData
	MOVF	POSTINC1, F
;	.line	130; lcd.c	lcdData((val / 10) % 10 + 48);
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
	CALL	_lcdData
	MOVF	POSTINC1, F
;	.line	131; lcd.c	lcdData((val / 1) % 10 + 48);
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
	CALL	_lcdData
	MOVF	POSTINC1, F
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_lcd__lcdData	code
_lcdData:
;	.line	87; lcd.c	void lcdData(unsigned char valor)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	89; lcd.c	delay2ms();
	CALL	_delay2ms
;	.line	91; lcd.c	bitSet(PORTA,RS);
	LFSR	0x00, 0xf80
	MOVFF	INDF0, r0x01
	BSF	r0x01, 0
	LFSR	0x00, 0xf80
	MOVFF	r0x01, INDF0
;	.line	92; lcd.c	bitClr(PORTA,EN);	//comando
	LFSR	0x00, 0xf80
	MOVFF	INDF0, r0x01
	BCF	r0x01, 1
	LFSR	0x00, 0xf80
	MOVFF	r0x01, INDF0
;	.line	95; lcd.c	delay2ms();
	CALL	_delay2ms
;	.line	98; lcd.c	if(valor&0b00010000){bitSet(PORTD,D1);}
	BTFSS	r0x00, 4
	BRA	_00221_DS_
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x01
	BSF	r0x01, 7
	LFSR	0x00, 0xf83
	MOVFF	r0x01, INDF0
	BRA	_00222_DS_
_00221_DS_:
;	.line	99; lcd.c	else {bitClr(PORTD,D1);}
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x01
	BCF	r0x01, 7
	LFSR	0x00, 0xf83
	MOVFF	r0x01, INDF0
_00222_DS_:
;	.line	100; lcd.c	if(valor&0b00100000){bitSet(PORTD,D2);}
	BTFSS	r0x00, 5
	BRA	_00224_DS_
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x01
	BSF	r0x01, 6
	LFSR	0x00, 0xf83
	MOVFF	r0x01, INDF0
	BRA	_00225_DS_
_00224_DS_:
;	.line	101; lcd.c	else {bitClr(PORTD,D2);}
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x01
	BCF	r0x01, 6
	LFSR	0x00, 0xf83
	MOVFF	r0x01, INDF0
_00225_DS_:
;	.line	102; lcd.c	if(valor&0b01000000){bitSet(PORTD,D3);}
	BTFSS	r0x00, 6
	BRA	_00227_DS_
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x01
	BSF	r0x01, 5
	LFSR	0x00, 0xf83
	MOVFF	r0x01, INDF0
	BRA	_00228_DS_
_00227_DS_:
;	.line	103; lcd.c	else {bitClr(PORTD,D3);}
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x01
	BCF	r0x01, 5
	LFSR	0x00, 0xf83
	MOVFF	r0x01, INDF0
_00228_DS_:
;	.line	104; lcd.c	if(valor&0b10000000){bitSet(PORTD,D4);}
	BTFSS	r0x00, 7
	BRA	_00230_DS_
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x01
	BSF	r0x01, 4
	LFSR	0x00, 0xf83
	MOVFF	r0x01, INDF0
	BRA	_00231_DS_
_00230_DS_:
;	.line	105; lcd.c	else {bitClr(PORTD,D4);}    
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x01
	BCF	r0x01, 4
	LFSR	0x00, 0xf83
	MOVFF	r0x01, INDF0
_00231_DS_:
;	.line	106; lcd.c	pulsoEN();
	CALL	_pulsoEN
;	.line	109; lcd.c	if(valor&0b00000001){bitSet(PORTD,D1);}
	BTFSS	r0x00, 0
	BRA	_00233_DS_
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x01
	BSF	r0x01, 7
	LFSR	0x00, 0xf83
	MOVFF	r0x01, INDF0
	BRA	_00234_DS_
_00233_DS_:
;	.line	110; lcd.c	else {bitClr(PORTD,D1);}
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x01
	BCF	r0x01, 7
	LFSR	0x00, 0xf83
	MOVFF	r0x01, INDF0
_00234_DS_:
;	.line	111; lcd.c	if(valor&0b00000010){bitSet(PORTD,D2);}
	BTFSS	r0x00, 1
	BRA	_00236_DS_
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x01
	BSF	r0x01, 6
	LFSR	0x00, 0xf83
	MOVFF	r0x01, INDF0
	BRA	_00237_DS_
_00236_DS_:
;	.line	112; lcd.c	else {bitClr(PORTD,D2);}
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x01
	BCF	r0x01, 6
	LFSR	0x00, 0xf83
	MOVFF	r0x01, INDF0
_00237_DS_:
;	.line	113; lcd.c	if(valor&0b00000100){bitSet(PORTD,D3);}
	BTFSS	r0x00, 2
	BRA	_00239_DS_
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x01
	BSF	r0x01, 5
	LFSR	0x00, 0xf83
	MOVFF	r0x01, INDF0
	BRA	_00240_DS_
_00239_DS_:
;	.line	114; lcd.c	else {bitClr(PORTD,D3);}
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x01
	BCF	r0x01, 5
	LFSR	0x00, 0xf83
	MOVFF	r0x01, INDF0
_00240_DS_:
;	.line	115; lcd.c	if(valor&0b00001000){bitSet(PORTD,D4);}
	BTFSS	r0x00, 3
	BRA	_00242_DS_
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x00
	BSF	r0x00, 4
	LFSR	0x00, 0xf83
	MOVFF	r0x00, INDF0
	BRA	_00243_DS_
_00242_DS_:
;	.line	116; lcd.c	else {bitClr(PORTD,D4);}
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x00
	BCF	r0x00, 4
	LFSR	0x00, 0xf83
	MOVFF	r0x00, INDF0
_00243_DS_:
;	.line	117; lcd.c	pulsoEN();
	CALL	_pulsoEN
;	.line	120; lcd.c	bitClr(PORTA,RS);
	LFSR	0x00, 0xf80
	MOVFF	INDF0, r0x00
	BCF	r0x00, 0
	LFSR	0x00, 0xf80
	MOVFF	r0x00, INDF0
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_lcd__lcdLine	code
_lcdLine:
;	.line	75; lcd.c	void lcdLine(int linha)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
;	.line	77; lcd.c	if(linha==2)
	MOVF	r0x00, W
	XORLW	0x02
	BNZ	_00214_DS_
	MOVF	r0x01, W
	BZ	_00215_DS_
_00214_DS_:
	BRA	_00207_DS_
_00215_DS_:
;	.line	79; lcd.c	lcdCommand(0xC0);
	MOVLW	0xc0
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
	BRA	_00209_DS_
_00207_DS_:
;	.line	83; lcd.c	lcdCommand(0x80);
	MOVLW	0x80
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
_00209_DS_:
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_lcd__lcdCommand	code
_lcdCommand:
;	.line	40; lcd.c	void lcdCommand(unsigned char cmd)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	43; lcd.c	delay2ms();
	CALL	_delay2ms
;	.line	45; lcd.c	bitClr(PORTA,RS);
	LFSR	0x00, 0xf80
	MOVFF	INDF0, r0x01
	BCF	r0x01, 0
	LFSR	0x00, 0xf80
	MOVFF	r0x01, INDF0
;	.line	46; lcd.c	bitClr(PORTA,EN);	//comando
	LFSR	0x00, 0xf80
	MOVFF	INDF0, r0x01
	BCF	r0x01, 1
	LFSR	0x00, 0xf80
	MOVFF	r0x01, INDF0
;	.line	49; lcd.c	delay2ms();
	CALL	_delay2ms
;	.line	52; lcd.c	if(cmd&0b00010000){bitSet(PORTD,D1);}
	BTFSS	r0x00, 4
	BRA	_00129_DS_
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x01
	BSF	r0x01, 7
	LFSR	0x00, 0xf83
	MOVFF	r0x01, INDF0
	BRA	_00130_DS_
_00129_DS_:
;	.line	53; lcd.c	else {bitClr(PORTD,D1);}
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x01
	BCF	r0x01, 7
	LFSR	0x00, 0xf83
	MOVFF	r0x01, INDF0
_00130_DS_:
;	.line	54; lcd.c	if(cmd&0b00100000){bitSet(PORTD,D2);}
	BTFSS	r0x00, 5
	BRA	_00132_DS_
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x01
	BSF	r0x01, 6
	LFSR	0x00, 0xf83
	MOVFF	r0x01, INDF0
	BRA	_00133_DS_
_00132_DS_:
;	.line	55; lcd.c	else {bitClr(PORTD,D2);}
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x01
	BCF	r0x01, 6
	LFSR	0x00, 0xf83
	MOVFF	r0x01, INDF0
_00133_DS_:
;	.line	56; lcd.c	if(cmd&0b01000000){bitSet(PORTD,D3);}
	BTFSS	r0x00, 6
	BRA	_00135_DS_
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x01
	BSF	r0x01, 5
	LFSR	0x00, 0xf83
	MOVFF	r0x01, INDF0
	BRA	_00136_DS_
_00135_DS_:
;	.line	57; lcd.c	else {bitClr(PORTD,D3);}
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x01
	BCF	r0x01, 5
	LFSR	0x00, 0xf83
	MOVFF	r0x01, INDF0
_00136_DS_:
;	.line	58; lcd.c	if(cmd&0b10000000){bitSet(PORTD,D4);}
	BTFSS	r0x00, 7
	BRA	_00138_DS_
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x01
	BSF	r0x01, 4
	LFSR	0x00, 0xf83
	MOVFF	r0x01, INDF0
	BRA	_00139_DS_
_00138_DS_:
;	.line	59; lcd.c	else {bitClr(PORTD,D4);}
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x01
	BCF	r0x01, 4
	LFSR	0x00, 0xf83
	MOVFF	r0x01, INDF0
_00139_DS_:
;	.line	60; lcd.c	pulsoEN();
	CALL	_pulsoEN
;	.line	63; lcd.c	if(cmd&0b00000001){bitSet(PORTD,D1);}
	BTFSS	r0x00, 0
	BRA	_00141_DS_
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x01
	BSF	r0x01, 7
	LFSR	0x00, 0xf83
	MOVFF	r0x01, INDF0
	BRA	_00142_DS_
_00141_DS_:
;	.line	64; lcd.c	else {bitClr(PORTD,D1);}
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x01
	BCF	r0x01, 7
	LFSR	0x00, 0xf83
	MOVFF	r0x01, INDF0
_00142_DS_:
;	.line	65; lcd.c	if(cmd&0b00000010){bitSet(PORTD,D2);}
	BTFSS	r0x00, 1
	BRA	_00144_DS_
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x01
	BSF	r0x01, 6
	LFSR	0x00, 0xf83
	MOVFF	r0x01, INDF0
	BRA	_00145_DS_
_00144_DS_:
;	.line	66; lcd.c	else {bitClr(PORTD,D2);}
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x01
	BCF	r0x01, 6
	LFSR	0x00, 0xf83
	MOVFF	r0x01, INDF0
_00145_DS_:
;	.line	67; lcd.c	if(cmd&0b00000100){bitSet(PORTD,D3);}
	BTFSS	r0x00, 2
	BRA	_00147_DS_
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x01
	BSF	r0x01, 5
	LFSR	0x00, 0xf83
	MOVFF	r0x01, INDF0
	BRA	_00148_DS_
_00147_DS_:
;	.line	68; lcd.c	else {bitClr(PORTD,D3);}
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x01
	BCF	r0x01, 5
	LFSR	0x00, 0xf83
	MOVFF	r0x01, INDF0
_00148_DS_:
;	.line	69; lcd.c	if(cmd&0b00001000){bitSet(PORTD,D4);}
	BTFSS	r0x00, 3
	BRA	_00150_DS_
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x00
	BSF	r0x00, 4
	LFSR	0x00, 0xf83
	MOVFF	r0x00, INDF0
	BRA	_00151_DS_
_00150_DS_:
;	.line	70; lcd.c	else {bitClr(PORTD,D4);}
	LFSR	0x00, 0xf83
	MOVFF	INDF0, r0x00
	BCF	r0x00, 4
	LFSR	0x00, 0xf83
	MOVFF	r0x00, INDF0
_00151_DS_:
;	.line	71; lcd.c	pulsoEN();
	CALL	_pulsoEN
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_lcd__pulsoEN	code
_pulsoEN:
;	.line	27; lcd.c	void pulsoEN(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
;	.line	29; lcd.c	bitClr(PORTA,EN);
	LFSR	0x00, 0xf80
	MOVFF	INDF0, r0x00
	BCF	r0x00, 1
	LFSR	0x00, 0xf80
	MOVFF	r0x00, INDF0
;	.line	30; lcd.c	delay2ms();
	CALL	_delay2ms
;	.line	32; lcd.c	bitSet(PORTA,EN);   //Pulso no Enable
	LFSR	0x00, 0xf80
	MOVFF	INDF0, r0x00
	BSF	r0x00, 1
	LFSR	0x00, 0xf80
	MOVFF	r0x00, INDF0
;	.line	33; lcd.c	delay2ms();
	CALL	_delay2ms
;	.line	35; lcd.c	bitClr(PORTA,EN);
	LFSR	0x00, 0xf80
	MOVFF	INDF0, r0x00
	BCF	r0x00, 1
	LFSR	0x00, 0xf80
	MOVFF	r0x00, INDF0
;	.line	36; lcd.c	delay2ms();
	CALL	_delay2ms
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_lcd__delay2ms	code
_delay2ms:
;	.line	18; lcd.c	void delay2ms(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
;	.line	21; lcd.c	for(i=0; i < 10; i++)
	MOVLW	0x0a
	MOVWF	r0x00
_00117_DS_:
;	.line	23; lcd.c	delay40us();
	CALL	_delay40us
	DECF	r0x00, W
	MOVWF	r0x01
	MOVFF	r0x01, r0x00
;	.line	21; lcd.c	for(i=0; i < 10; i++)
	MOVF	r0x01, W
	BNZ	_00117_DS_
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_lcd__delay40us	code
_delay40us:
;	.line	13; lcd.c	void delay40us(void){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
;	.line	15; lcd.c	for(k=0; k < 25; k++); //valor aproximado 
	MOVLW	0x19
	MOVWF	r0x00
_00108_DS_:
	DECF	r0x00, W
	MOVWF	r0x01
	MOVFF	r0x01, r0x00
	MOVF	r0x01, W
	BNZ	_00108_DS_
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	



; Statistics:
; code size:	 2468 (0x09a4) bytes ( 1.88%)
;           	 1234 (0x04d2) words
; udata size:	    0 (0x0000) bytes ( 0.00%)
; access size:	    7 (0x0007) bytes


	end
