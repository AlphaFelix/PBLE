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
	global	_i2cInit
	global	_i2cStart
	global	_i2cRestart
	global	_i2cStop
	global	_i2cWait
	global	_i2cSend
	global	_i2cRead

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern	_SPPCFGbits
	extern	_SPPEPSbits
	extern	_SPPCONbits
	extern	_UFRMLbits
	extern	_UFRMHbits
	extern	_UIRbits
	extern	_UIEbits
	extern	_UEIRbits
	extern	_UEIEbits
	extern	_USTATbits
	extern	_UCONbits
	extern	_UADDRbits
	extern	_UCFGbits
	extern	_UEP0bits
	extern	_UEP1bits
	extern	_UEP2bits
	extern	_UEP3bits
	extern	_UEP4bits
	extern	_UEP5bits
	extern	_UEP6bits
	extern	_UEP7bits
	extern	_UEP8bits
	extern	_UEP9bits
	extern	_UEP10bits
	extern	_UEP11bits
	extern	_UEP12bits
	extern	_UEP13bits
	extern	_UEP14bits
	extern	_UEP15bits
	extern	_PORTAbits
	extern	_PORTBbits
	extern	_PORTCbits
	extern	_PORTDbits
	extern	_PORTEbits
	extern	_LATAbits
	extern	_LATBbits
	extern	_LATCbits
	extern	_LATDbits
	extern	_LATEbits
	extern	_DDRAbits
	extern	_TRISAbits
	extern	_DDRBbits
	extern	_TRISBbits
	extern	_DDRCbits
	extern	_TRISCbits
	extern	_DDRDbits
	extern	_TRISDbits
	extern	_DDREbits
	extern	_TRISEbits
	extern	_OSCTUNEbits
	extern	_PIE1bits
	extern	_PIR1bits
	extern	_IPR1bits
	extern	_PIE2bits
	extern	_PIR2bits
	extern	_IPR2bits
	extern	_EECON1bits
	extern	_RCSTAbits
	extern	_TXSTAbits
	extern	_T3CONbits
	extern	_CMCONbits
	extern	_CVRCONbits
	extern	_CCP1ASbits
	extern	_ECCP1ASbits
	extern	_CCP1DELbits
	extern	_ECCP1DELbits
	extern	_BAUDCONbits
	extern	_BAUDCTLbits
	extern	_CCP2CONbits
	extern	_CCP1CONbits
	extern	_ECCP1CONbits
	extern	_ADCON2bits
	extern	_ADCON1bits
	extern	_ADCON0bits
	extern	_SSPCON2bits
	extern	_SSPCON1bits
	extern	_SSPSTATbits
	extern	_T2CONbits
	extern	_T1CONbits
	extern	_RCONbits
	extern	_WDTCONbits
	extern	_HLVDCONbits
	extern	_LVDCONbits
	extern	_OSCCONbits
	extern	_T0CONbits
	extern	_STATUSbits
	extern	_INTCON3bits
	extern	_INTCON2bits
	extern	_INTCONbits
	extern	_STKPTRbits
	extern	_SPPDATA
	extern	_SPPCFG
	extern	_SPPEPS
	extern	_SPPCON
	extern	_UFRM
	extern	_UFRML
	extern	_UFRMH
	extern	_UIR
	extern	_UIE
	extern	_UEIR
	extern	_UEIE
	extern	_USTAT
	extern	_UCON
	extern	_UADDR
	extern	_UCFG
	extern	_UEP0
	extern	_UEP1
	extern	_UEP2
	extern	_UEP3
	extern	_UEP4
	extern	_UEP5
	extern	_UEP6
	extern	_UEP7
	extern	_UEP8
	extern	_UEP9
	extern	_UEP10
	extern	_UEP11
	extern	_UEP12
	extern	_UEP13
	extern	_UEP14
	extern	_UEP15
	extern	_PORTA
	extern	_PORTB
	extern	_PORTC
	extern	_PORTD
	extern	_PORTE
	extern	_LATA
	extern	_LATB
	extern	_LATC
	extern	_LATD
	extern	_LATE
	extern	_DDRA
	extern	_TRISA
	extern	_DDRB
	extern	_TRISB
	extern	_DDRC
	extern	_TRISC
	extern	_DDRD
	extern	_TRISD
	extern	_DDRE
	extern	_TRISE
	extern	_OSCTUNE
	extern	_PIE1
	extern	_PIR1
	extern	_IPR1
	extern	_PIE2
	extern	_PIR2
	extern	_IPR2
	extern	_EECON1
	extern	_EECON2
	extern	_EEDATA
	extern	_EEADR
	extern	_RCSTA
	extern	_TXSTA
	extern	_TXREG
	extern	_RCREG
	extern	_SPBRG
	extern	_SPBRGH
	extern	_T3CON
	extern	_TMR3
	extern	_TMR3L
	extern	_TMR3H
	extern	_CMCON
	extern	_CVRCON
	extern	_CCP1AS
	extern	_ECCP1AS
	extern	_CCP1DEL
	extern	_ECCP1DEL
	extern	_BAUDCON
	extern	_BAUDCTL
	extern	_CCP2CON
	extern	_CCPR2
	extern	_CCPR2L
	extern	_CCPR2H
	extern	_CCP1CON
	extern	_ECCP1CON
	extern	_CCPR1
	extern	_CCPR1L
	extern	_CCPR1H
	extern	_ADCON2
	extern	_ADCON1
	extern	_ADCON0
	extern	_ADRES
	extern	_ADRESL
	extern	_ADRESH
	extern	_SSPCON2
	extern	_SSPCON1
	extern	_SSPSTAT
	extern	_SSPADD
	extern	_SSPBUF
	extern	_T2CON
	extern	_PR2
	extern	_TMR2
	extern	_T1CON
	extern	_TMR1
	extern	_TMR1L
	extern	_TMR1H
	extern	_RCON
	extern	_WDTCON
	extern	_HLVDCON
	extern	_LVDCON
	extern	_OSCCON
	extern	_T0CON
	extern	_TMR0
	extern	_TMR0L
	extern	_TMR0H
	extern	_STATUS
	extern	_FSR2L
	extern	_FSR2H
	extern	_PLUSW2
	extern	_PREINC2
	extern	_POSTDEC2
	extern	_POSTINC2
	extern	_INDF2
	extern	_BSR
	extern	_FSR1L
	extern	_FSR1H
	extern	_PLUSW1
	extern	_PREINC1
	extern	_POSTDEC1
	extern	_POSTINC1
	extern	_INDF1
	extern	_WREG
	extern	_FSR0L
	extern	_FSR0H
	extern	_PLUSW0
	extern	_PREINC0
	extern	_POSTDEC0
	extern	_POSTINC0
	extern	_INDF0
	extern	_INTCON3
	extern	_INTCON2
	extern	_INTCON
	extern	_PROD
	extern	_PRODL
	extern	_PRODH
	extern	_TABLAT
	extern	_TBLPTR
	extern	_TBLPTRL
	extern	_TBLPTRH
	extern	_TBLPTRU
	extern	_PC
	extern	_PCL
	extern	_PCLATH
	extern	_PCLATU
	extern	_STKPTR
	extern	_TOS
	extern	_TOSL
	extern	_TOSH
	extern	_TOSU

;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
WREG	equ	0xfe8
FSR1L	equ	0xfe1
FSR2L	equ	0xfd9
POSTDEC1	equ	0xfe5
PREINC1	equ	0xfe4
PLUSW2	equ	0xfdb


; Internal registers
.registers	udata_ovr	0x0000
r0x00	res	1
r0x01	res	1

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_i2c__i2cRead	code
_i2cRead:
;	.line	68; i2c.c	unsigned char i2cRead(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
;	.line	71; i2c.c	SSPCON2bits.RCEN = 1;        /* Enable data reception */
	BSF	_SSPCON2bits, 3
_00184_DS_:
;	.line	72; i2c.c	while(SSPSTATbits.BF == 0)      /* wait for buffer full */
	BTFSS	_SSPSTATbits, 0
	BRA	_00184_DS_
;	.line	74; i2c.c	temp = SSPBUF;   /* Read serial buffer and store in temp register */
	MOVFF	_SSPBUF, r0x00
;	.line	75; i2c.c	i2cWait();       /* wait to check any pending transfer */
	CALL	_i2cWait
;	.line	76; i2c.c	SSPCON2bits.ACKDT=1;				//send not acknowledge
	BSF	_SSPCON2bits, 5
;	.line	77; i2c.c	SSPCON2bits.ACKEN=1;
	BSF	_SSPCON2bits, 4
_00187_DS_:
;	.line	78; i2c.c	while(SSPCON2bits.ACKEN == 1) 
	CLRF	r0x01
	BTFSC	_SSPCON2bits, 4
	INCF	r0x01, F
	MOVF	r0x01, W
	XORLW	0x01
	BZ	_00187_DS_
;	.line	81; i2c.c	return temp;     /* Return the read data from bus */
	MOVF	r0x00, W
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_i2c__i2cSend	code
_i2cSend:
;	.line	61; i2c.c	void i2cSend(unsigned char dat)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVLW	0x02
	MOVFF	PLUSW2, _SSPBUF
_00176_DS_:
;	.line	64; i2c.c	while(SSPSTATbits.BF);       /* wait till complete data is sent from buffer */
	BTFSC	_SSPSTATbits, 0
	BRA	_00176_DS_
;	.line	65; i2c.c	i2cWait();       /* wait for any pending transfer */
	CALL	_i2cWait
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_i2c__i2cWait	code
_i2cWait:
;	.line	49; i2c.c	void i2cWait(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
_00152_DS_:
;	.line	51; i2c.c	while(SSPSTATbits.R_NOT_W == 1)
	CLRF	r0x00
	BTFSC	_SSPSTATbits, 2
	INCF	r0x00, F
	MOVF	r0x00, W
	XORLW	0x01
	BZ	_00152_DS_
;	.line	53; i2c.c	if(SSPCON2bits.ACKSTAT == 1)
	CLRF	r0x00
	BTFSC	_SSPCON2bits, 6
	INCF	r0x00, F
	MOVF	r0x00, W
	XORLW	0x01
	BNZ	_00157_DS_
;	.line	55; i2c.c	i2cStop();
	CALL	_i2cStop
_00157_DS_:
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_i2c__i2cStop	code
_i2cStop:
;	.line	42; i2c.c	void i2cStop(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
;	.line	44; i2c.c	SSPCON2bits.PEN=1;
	BSF	_SSPCON2bits, 2
_00138_DS_:
;	.line	45; i2c.c	while(SSPCON2bits.PEN==1)
	CLRF	r0x00
	BTFSC	_SSPCON2bits, 2
	INCF	r0x00, F
	MOVF	r0x00, W
	XORLW	0x01
	BZ	_00138_DS_
;	.line	46; i2c.c	continue;
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_i2c__i2cRestart	code
_i2cRestart:
;	.line	32; i2c.c	void i2cRestart(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
;	.line	34; i2c.c	SSPCON2bits.RSEN = 1;
	BSF	_SSPCON2bits, 1
_00124_DS_:
;	.line	36; i2c.c	while (SSPCON2bits.RSEN == 1)
	CLRF	r0x00
	BTFSC	_SSPCON2bits, 1
	INCF	r0x00, F
	MOVF	r0x00, W
	XORLW	0x01
	BZ	_00124_DS_
;	.line	37; i2c.c	continue;
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_i2c__i2cStart	code
_i2cStart:
;	.line	21; i2c.c	void i2cStart(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
;	.line	23; i2c.c	SSPCON2bits.SEN = 1;
	BSF	_SSPCON2bits, 0
_00110_DS_:
;	.line	25; i2c.c	while (SSPCON2bits.SEN == 1)
	CLRF	r0x00
	BTFSC	_SSPCON2bits, 0
	INCF	r0x00, F
	MOVF	r0x00, W
	XORLW	0x01
	BZ	_00110_DS_
;	.line	26; i2c.c	continue;
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_i2c__i2cInit	code
_i2cInit:
;	.line	4; i2c.c	void i2cInit()
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	6; i2c.c	TRISB |= 0x03;
	MOVLW	0x03
	IORWF	_TRISB, F
;	.line	7; i2c.c	SSPSTAT |= 0x80; //Slew Rate Disabled
	BSF	_SSPSTAT, 7
;	.line	8; i2c.c	SSPADD = 119;
	MOVLW	0x77
	MOVWF	_SSPADD
;	.line	10; i2c.c	SSPCON1 = 0b00101000;			//Master mode
	MOVLW	0x28
	MOVWF	_SSPCON1
;	.line	11; i2c.c	SSPADD = 119;
	MOVLW	0x77
	MOVWF	_SSPADD
	MOVFF	PREINC1, FSR2L
	RETURN	



; Statistics:
; code size:	  280 (0x0118) bytes ( 0.21%)
;           	  140 (0x008c) words
; udata size:	    0 (0x0000) bytes ( 0.00%)
; access size:	    2 (0x0002) bytes


	end
