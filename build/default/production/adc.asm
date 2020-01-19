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
	global	_adcInit
	global	_adcAN
	global	_adcRead
	global	_adcScale

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern	___uint2fs
	extern	___fsmul
	extern	___fs2uint

;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
STATUS	equ	0xfd8
PCL	equ	0xff9
PCLATH	equ	0xffa
PCLATU	equ	0xffb
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
PRODH	equ	0xff4


; Internal registers
.registers	udata_ovr	0x0000
r0x00	res	1
r0x01	res	1
r0x02	res	1
r0x03	res	1
r0x04	res	1
r0x05	res	1

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_adc__adcScale	code
_adcScale:
;	.line	50; adc.c	int adcScale(char ch, float scale)
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
;	.line	54; adc.c	ADCON1 = 0x06; //Até o AN8 é analogico, a referencia é baseada na fonte
	LFSR	0x00, 0xfc1
	MOVLW	0x06
	MOVWF	INDF0
;	.line	55; adc.c	switch(ch){        
	MOVF	r0x00, W
	BZ	_00143_DS_
	MOVF	r0x00, W
	XORLW	0x01
	BZ	_00144_DS_
	MOVF	r0x00, W
	XORLW	0x02
	BZ	_00145_DS_
	MOVF	r0x00, W
	XORLW	0x04
	BZ	_00146_DS_
	BRA	_00147_DS_
_00143_DS_:
;	.line	56; adc.c	case DIA: ADCON0 = 0b00001001; convert = (scale*10000)/1023; break;//seleciona o canal 2 e liga o ad        
	LFSR	0x00, 0xfc2
	MOVLW	0x09
	MOVWF	INDF0
	BRA	_00147_DS_
_00144_DS_:
;	.line	57; adc.c	case DIB: ADCON0 = 0b00001101; convert = (scale/1023)*10000; break;//seleciona o canal 3 e liga o ad
	LFSR	0x00, 0xfc2
	MOVLW	0x0d
	MOVWF	INDF0
	BRA	_00147_DS_
_00145_DS_:
;	.line	58; adc.c	case POT: ADCON0 = 0b00010001; convert = (scale/0,675); break;//seleciona o canal 4 e liga o ad       
	LFSR	0x00, 0xfc2
	MOVLW	0x11
	MOVWF	INDF0
	BRA	_00147_DS_
_00146_DS_:
;	.line	59; adc.c	case AN1: ADCON0 = 0b00011101; convert = (scale/1023)*10000; break;  //seleciona o canal 7 e liga o ad        
	LFSR	0x00, 0xfc2
	MOVLW	0x1d
	MOVWF	INDF0
_00147_DS_:
;	.line	62; adc.c	ADCON0 |= 0b00000010;	 //inicia conversao
	LFSR	0x00, 0xfc2
	MOVFF	INDF0, r0x00
	BSF	r0x00, 1
	LFSR	0x00, 0xfc2
	MOVFF	r0x00, INDF0
_00148_DS_:
;	.line	64; adc.c	while(bitTst(ADCON0,1)); // espera terminar a conversão;
	LFSR	0x00, 0xfc2
	MOVFF	INDF0, r0x00
	BTFSC	r0x00, 1
	BRA	_00148_DS_
;	.line	66; adc.c	ADvalor = ADRESH ; // le o resultado
	LFSR	0x00, 0xfc4
	MOVFF	INDF0, r0x00
	CLRF	r0x01
;	.line	67; adc.c	ADvalor <<= 8;
	MOVF	r0x00, W
	MOVWF	r0x01
	CLRF	r0x00
;	.line	68; adc.c	ADvalor += ADRESL;    
	LFSR	0x00, 0xfc3
	MOVFF	INDF0, r0x02
	CLRF	r0x03
	MOVF	r0x02, W
	ADDWF	r0x00, F
	MOVF	r0x03, W
	ADDWFC	r0x01, F
;	.line	69; adc.c	ADvalor = ADvalor * 14.65; //Converte a escala de 0-675(3.3V) para 0-1023  
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	___uint2fs
	MOVWF	r0x02
	MOVFF	PRODL, r0x03
	MOVFF	PRODH, r0x04
	MOVFF	FSR0L, r0x05
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVLW	0x41
	MOVWF	POSTDEC1
	MOVLW	0x6a
	MOVWF	POSTDEC1
	MOVLW	0x66
	MOVWF	POSTDEC1
	MOVLW	0x66
	MOVWF	POSTDEC1
	CALL	___fsmul
	MOVWF	r0x02
	MOVFF	PRODL, r0x03
	MOVFF	PRODH, r0x04
	MOVFF	FSR0L, r0x05
	MOVLW	0x08
	ADDWF	FSR1L, F
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	___fs2uint
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVLW	0x04
	ADDWF	FSR1L, F
;	.line	70; adc.c	adcInit(); //Define as portas como digitais, para ser possivel utilizar o LCD
	CALL	_adcInit
;	.line	71; adc.c	if(ADvalor>9999)
	MOVLW	0x27
	SUBWF	r0x01, W
	BNZ	_00186_DS_
	MOVLW	0x10
	SUBWF	r0x00, W
_00186_DS_:
	BNC	_00152_DS_
;	.line	72; adc.c	return 9999;    
	MOVLW	0x27
	MOVWF	PRODL
	MOVLW	0x0f
	BRA	_00153_DS_
_00152_DS_:
;	.line	73; adc.c	return ADvalor;
	MOVFF	r0x01, PRODL
	MOVF	r0x00, W
_00153_DS_:
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_adc__adcRead	code
_adcRead:
;	.line	25; adc.c	int adcRead(char ch)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	29; adc.c	ADCON1 = 0x06; //Até o AN8 é analogico, a referencia é baseada na fonte
	LFSR	0x00, 0xfc1
	MOVLW	0x06
	MOVWF	INDF0
;	.line	31; adc.c	switch(ch){        
	MOVLW	0x05
	SUBWF	r0x00, W
	BC	_00120_DS_
	CLRF	PCLATH
	CLRF	PCLATU
	RLCF	r0x00, W
	RLCF	PCLATH, F
	RLCF	WREG, W
	RLCF	PCLATH, F
	ANDLW	0xfc
	ADDLW	LOW(_00136_DS_)
	MOVWF	POSTDEC1
	MOVLW	HIGH(_00136_DS_)
	ADDWFC	PCLATH, F
	MOVLW	UPPER(_00136_DS_)
	ADDWFC	PCLATU, F
	MOVF	PREINC1, W
	MOVWF	PCL
_00136_DS_:
	GOTO	_00115_DS_
	GOTO	_00116_DS_
	GOTO	_00117_DS_
	GOTO	_00118_DS_
	GOTO	_00119_DS_
_00115_DS_:
;	.line	32; adc.c	case DIA: ADCON0 = 0b00001001; break;//seleciona o canal 2 e liga o ad        
	LFSR	0x00, 0xfc2
	MOVLW	0x09
	MOVWF	INDF0
	BRA	_00120_DS_
_00116_DS_:
;	.line	33; adc.c	case DIB: ADCON0 = 0b00001101; break;//seleciona o canal 3 e liga o ad
	LFSR	0x00, 0xfc2
	MOVLW	0x0d
	MOVWF	INDF0
	BRA	_00120_DS_
_00117_DS_:
;	.line	34; adc.c	case POT: ADCON0 = 0b00010001; break;//seleciona o canal 4 e liga o ad
	LFSR	0x00, 0xfc2
	MOVLW	0x11
	MOVWF	INDF0
	BRA	_00120_DS_
_00118_DS_:
;	.line	35; adc.c	case KP: ADCON0 = 0b00010101; break;//seleciona o canal 5 e liga o ad
	LFSR	0x00, 0xfc2
	MOVLW	0x15
	MOVWF	INDF0
	BRA	_00120_DS_
_00119_DS_:
;	.line	36; adc.c	case AN1: ADCON0 = 0b00011101; break;  //seleciona o canal 7 e liga o ad        
	LFSR	0x00, 0xfc2
	MOVLW	0x1d
	MOVWF	INDF0
_00120_DS_:
;	.line	39; adc.c	ADCON0 |= 0b00000010;	 //inicia conversao
	LFSR	0x00, 0xfc2
	MOVFF	INDF0, r0x00
	BSF	r0x00, 1
	LFSR	0x00, 0xfc2
	MOVFF	r0x00, INDF0
_00121_DS_:
;	.line	41; adc.c	while(bitTst(ADCON0,1)); // espera terminar a conversão;
	LFSR	0x00, 0xfc2
	MOVFF	INDF0, r0x00
	BTFSC	r0x00, 1
	BRA	_00121_DS_
;	.line	43; adc.c	ADvalor = ADRESH ; // le o resultado
	LFSR	0x00, 0xfc4
	MOVFF	INDF0, r0x00
	CLRF	r0x01
;	.line	44; adc.c	ADvalor <<= 8;
	MOVF	r0x00, W
	MOVWF	r0x01
	CLRF	r0x00
;	.line	45; adc.c	ADvalor += ADRESL;
	LFSR	0x00, 0xfc3
	MOVFF	INDF0, r0x02
	CLRF	r0x03
	MOVF	r0x02, W
	ADDWF	r0x00, F
	MOVF	r0x03, W
	ADDWFC	r0x01, F
;	.line	46; adc.c	adcInit(); //Define as portas como digitais, para ser possivel utilizar o LCD
	CALL	_adcInit
;	.line	47; adc.c	return ADvalor;
	MOVFF	r0x01, PRODL
	MOVF	r0x00, W
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_adc__adcAN	code
_adcAN:
;	.line	18; adc.c	void adcAN(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	20; adc.c	ADCON0 = 0b00010001; //Liga o ad
	LFSR	0x00, 0xfc2
	MOVLW	0x11
	MOVWF	INDF0
;	.line	21; adc.c	ADCON1 = 0x06; //Até o AN8 é analogico, a referencia é baseada na fonte
	LFSR	0x00, 0xfc1
	MOVLW	0x06
	MOVWF	INDF0
;	.line	22; adc.c	ADCON2 = 0b10101010; //FOSC /32, Alinhamento à direita e tempo de conv = 12 TAD
	LFSR	0x00, 0xfc0
	MOVLW	0xaa
	MOVWF	INDF0
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_adc__adcInit	code
_adcInit:
;	.line	6; adc.c	void adcInit(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
;	.line	8; adc.c	bitClr(TRISA,0); //Inicializa o pino conectado ao RS do LCD como output
	LFSR	0x00, 0xf92
	MOVFF	INDF0, r0x00
	BCF	r0x00, 0
	LFSR	0x00, 0xf92
	MOVFF	r0x00, INDF0
;	.line	9; adc.c	bitClr(TRISA,1); //Inicializa o pino conectado ao EN do LCD como output
	LFSR	0x00, 0xf92
	MOVFF	INDF0, r0x00
	BCF	r0x00, 1
	LFSR	0x00, 0xf92
	MOVFF	r0x00, INDF0
;	.line	10; adc.c	bitSet(TRISA,2); 	
	LFSR	0x00, 0xf92
	MOVFF	INDF0, r0x00
	BSF	r0x00, 2
	LFSR	0x00, 0xf92
	MOVFF	r0x00, INDF0
;	.line	11; adc.c	bitSet(TRISA,3);
	LFSR	0x00, 0xf92
	MOVFF	INDF0, r0x00
	BSF	r0x00, 3
	LFSR	0x00, 0xf92
	MOVFF	r0x00, INDF0
;	.line	12; adc.c	bitSet(TRISA,5);    
	LFSR	0x00, 0xf92
	MOVFF	INDF0, r0x00
	BSF	r0x00, 5
	LFSR	0x00, 0xf92
	MOVFF	r0x00, INDF0
;	.line	13; adc.c	ADCON0 = 0b00010000; //Desliga o ad
	LFSR	0x00, 0xfc2
	MOVLW	0x10
	MOVWF	INDF0
;	.line	14; adc.c	ADCON1 = 0x0F; //Todos Digitais, a referencia é baseada na fonte
	LFSR	0x00, 0xfc1
	MOVLW	0x0f
	MOVWF	INDF0
;	.line	15; adc.c	ADCON2 = 0b10101010; //FOSC /32, Alinhamento à direita e tempo de conv = 12 TAD
	LFSR	0x00, 0xfc0
	MOVLW	0xaa
	MOVWF	INDF0
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	



; Statistics:
; code size:	  758 (0x02f6) bytes ( 0.58%)
;           	  379 (0x017b) words
; udata size:	    0 (0x0000) bytes ( 0.00%)
; access size:	    6 (0x0006) bytes


	end
