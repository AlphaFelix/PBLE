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
	global	_rtcInit
	global	_BCD2UpperCh
	global	_BCD2LowerCh
	global	_rtcStore
	global	_rtcStoreInt
	global	_rtcRead
	global	_rtcReadInt
	global	_rtcStart
	global	_rtcMin
	global	_rtcHour
	global	_rtcDay
	global	_rtcDate
	global	_rtcMonth
	global	_rtcYear

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
	extern	_i2cInit
	extern	_i2cStart
	extern	_i2cRestart
	extern	_i2cStop
	extern	_i2cSend
	extern	_i2cRead
	extern	_lcdCommand

;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
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
r0x05	res	1

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_rtc__rtcYear	code
_rtcYear:
;	.line	123; rtc.c	void rtcYear(unsigned char year){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	124; rtc.c	i2cStart();
	CALL	_i2cStart
;	.line	125; rtc.c	i2cSend(0xD0);
	MOVLW	0xd0
	MOVWF	POSTDEC1
	CALL	_i2cSend
	MOVF	POSTINC1, F
;	.line	126; rtc.c	i2cSend(0x06);
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	_i2cSend
	MOVF	POSTINC1, F
;	.line	127; rtc.c	i2cSend(year);	
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_i2cSend
	MOVF	POSTINC1, F
;	.line	128; rtc.c	i2cStop();
	CALL	_i2cStop
;	.line	129; rtc.c	lcdCommand(0x01);
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_rtc__rtcMonth	code
_rtcMonth:
;	.line	114; rtc.c	void rtcMonth(unsigned char month){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	115; rtc.c	i2cStart();
	CALL	_i2cStart
;	.line	116; rtc.c	i2cSend(0xD0);
	MOVLW	0xd0
	MOVWF	POSTDEC1
	CALL	_i2cSend
	MOVF	POSTINC1, F
;	.line	117; rtc.c	i2cSend(0x05);
	MOVLW	0x05
	MOVWF	POSTDEC1
	CALL	_i2cSend
	MOVF	POSTINC1, F
;	.line	118; rtc.c	i2cSend(month);	
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_i2cSend
	MOVF	POSTINC1, F
;	.line	119; rtc.c	i2cStop();
	CALL	_i2cStop
;	.line	120; rtc.c	lcdCommand(0x01);
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_rtc__rtcDate	code
_rtcDate:
;	.line	105; rtc.c	void rtcDate(unsigned char date){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	106; rtc.c	i2cStart();
	CALL	_i2cStart
;	.line	107; rtc.c	i2cSend(0xD0);
	MOVLW	0xd0
	MOVWF	POSTDEC1
	CALL	_i2cSend
	MOVF	POSTINC1, F
;	.line	108; rtc.c	i2cSend(0x04);
	MOVLW	0x04
	MOVWF	POSTDEC1
	CALL	_i2cSend
	MOVF	POSTINC1, F
;	.line	109; rtc.c	i2cSend(date);	
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_i2cSend
	MOVF	POSTINC1, F
;	.line	110; rtc.c	i2cStop();
	CALL	_i2cStop
;	.line	111; rtc.c	lcdCommand(0x01);
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_rtc__rtcDay	code
_rtcDay:
;	.line	96; rtc.c	void rtcDay(unsigned char day){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	97; rtc.c	i2cStart();
	CALL	_i2cStart
;	.line	98; rtc.c	i2cSend(0xD0);
	MOVLW	0xd0
	MOVWF	POSTDEC1
	CALL	_i2cSend
	MOVF	POSTINC1, F
;	.line	99; rtc.c	i2cSend(0x03);
	MOVLW	0x03
	MOVWF	POSTDEC1
	CALL	_i2cSend
	MOVF	POSTINC1, F
;	.line	100; rtc.c	i2cSend(day);	
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_i2cSend
	MOVF	POSTINC1, F
;	.line	101; rtc.c	i2cStop();
	CALL	_i2cStop
;	.line	102; rtc.c	lcdCommand(0x01);
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_rtc__rtcHour	code
_rtcHour:
;	.line	87; rtc.c	void rtcHour(unsigned char hour){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	88; rtc.c	i2cStart();
	CALL	_i2cStart
;	.line	89; rtc.c	i2cSend(0xD0);
	MOVLW	0xd0
	MOVWF	POSTDEC1
	CALL	_i2cSend
	MOVF	POSTINC1, F
;	.line	90; rtc.c	i2cSend(0x02);
	MOVLW	0x02
	MOVWF	POSTDEC1
	CALL	_i2cSend
	MOVF	POSTINC1, F
;	.line	91; rtc.c	i2cSend(hour);	
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_i2cSend
	MOVF	POSTINC1, F
;	.line	92; rtc.c	i2cStop();
	CALL	_i2cStop
;	.line	93; rtc.c	lcdCommand(0x01);
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_rtc__rtcMin	code
_rtcMin:
;	.line	78; rtc.c	void rtcMin(unsigned char min){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	79; rtc.c	i2cStart();
	CALL	_i2cStart
;	.line	80; rtc.c	i2cSend(0xD0);
	MOVLW	0xd0
	MOVWF	POSTDEC1
	CALL	_i2cSend
	MOVF	POSTINC1, F
;	.line	81; rtc.c	i2cSend(0x01);
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_i2cSend
	MOVF	POSTINC1, F
;	.line	82; rtc.c	i2cSend(min);	
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_i2cSend
	MOVF	POSTINC1, F
;	.line	83; rtc.c	i2cStop();
	CALL	_i2cStop
;	.line	84; rtc.c	lcdCommand(0x01);
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_rtc__rtcStart	code
_rtcStart:
;	.line	68; rtc.c	void rtcStart(void){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	69; rtc.c	i2cStart();
	CALL	_i2cStart
;	.line	70; rtc.c	i2cSend(0xD0);
	MOVLW	0xd0
	MOVWF	POSTDEC1
	CALL	_i2cSend
	MOVF	POSTINC1, F
;	.line	71; rtc.c	i2cSend(0x00);
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_i2cSend
	MOVF	POSTINC1, F
;	.line	72; rtc.c	i2cSend(0x00);	
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_i2cSend
	MOVF	POSTINC1, F
;	.line	73; rtc.c	i2cStop();
	CALL	_i2cStop
;	.line	74; rtc.c	lcdCommand(0x01);
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_rtc__rtcReadInt	code
_rtcReadInt:
;	.line	56; rtc.c	int rtcReadInt(unsigned char address){
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
;	.line	60; rtc.c	valH = rtcRead(address);  
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_rtcRead
	MOVWF	r0x01
	MOVF	POSTINC1, F
;	.line	61; rtc.c	valL = rtcRead(address+1);	
	INCF	r0x00, F
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_rtcRead
	MOVWF	r0x00
	MOVF	POSTINC1, F
;	.line	62; rtc.c	val = (valH << 8);
	CLRF	r0x02
	MOVF	r0x01, W
	MOVWF	r0x04
	CLRF	r0x03
;	.line	63; rtc.c	val = val + valL;      
	CLRF	r0x05
	MOVF	r0x00, W
	ADDWF	r0x03, F
	MOVF	r0x05, W
	ADDWFC	r0x04, F
;	.line	65; rtc.c	return val;
	MOVFF	r0x04, PRODL
	MOVF	r0x03, W
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_rtc__rtcRead	code
_rtcRead:
;	.line	44; rtc.c	char rtcRead(unsigned char address){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	46; rtc.c	i2cStart();
	CALL	_i2cStart
;	.line	47; rtc.c	i2cSend(0xD0);
	MOVLW	0xd0
	MOVWF	POSTDEC1
	CALL	_i2cSend
	MOVF	POSTINC1, F
;	.line	48; rtc.c	i2cSend(address);
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_i2cSend
	MOVF	POSTINC1, F
;	.line	49; rtc.c	i2cRestart();
	CALL	_i2cRestart
;	.line	50; rtc.c	i2cSend(0xD1);
	MOVLW	0xd1
	MOVWF	POSTDEC1
	CALL	_i2cSend
	MOVF	POSTINC1, F
;	.line	51; rtc.c	val = i2cRead();
	CALL	_i2cRead
	MOVWF	r0x00
;	.line	52; rtc.c	i2cStop();	
	CALL	_i2cStop
;	.line	53; rtc.c	return val;
	MOVF	r0x00, W
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_rtc__rtcStoreInt	code
_rtcStoreInt:
;	.line	34; rtc.c	void rtcStoreInt(unsigned char address, int val)
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
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
;	.line	36; rtc.c	i2cStart();
	CALL	_i2cStart
;	.line	37; rtc.c	i2cSend(0xD0);
	MOVLW	0xd0
	MOVWF	POSTDEC1
	CALL	_i2cSend
	MOVF	POSTINC1, F
;	.line	38; rtc.c	i2cSend(address);	
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_i2cSend
	MOVF	POSTINC1, F
;	.line	39; rtc.c	i2cSend(val >> 8);    
	MOVF	r0x02, W
	MOVWF	r0x00
	CLRF	r0x03
	BTFSC	r0x00, 7
	SETF	r0x03
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_i2cSend
	MOVF	POSTINC1, F
;	.line	40; rtc.c	i2cSend(val & 0x00FF);
	CLRF	r0x02
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_i2cSend
	MOVF	POSTINC1, F
;	.line	41; rtc.c	i2cStop();
	CALL	_i2cStop
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_rtc__rtcStore	code
_rtcStore:
;	.line	25; rtc.c	void rtcStore(unsigned char address, char val)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
;	.line	27; rtc.c	i2cStart();
	CALL	_i2cStart
;	.line	28; rtc.c	i2cSend(0xD0);
	MOVLW	0xd0
	MOVWF	POSTDEC1
	CALL	_i2cSend
	MOVF	POSTINC1, F
;	.line	29; rtc.c	i2cSend(address);	
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_i2cSend
	MOVF	POSTINC1, F
;	.line	30; rtc.c	i2cSend(val);
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_i2cSend
	MOVF	POSTINC1, F
;	.line	31; rtc.c	i2cStop();   
	CALL	_i2cStop
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_rtc__BCD2LowerCh	code
_BCD2LowerCh:
;	.line	17; rtc.c	unsigned char BCD2LowerCh(unsigned char bcd)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	20; rtc.c	temp = bcd & 0x0F; //Making the Upper 4-bits
	MOVLW	0x0f
	ANDWF	r0x00, F
;	.line	21; rtc.c	temp = temp | 0x30;
	MOVLW	0x30
	IORWF	r0x00, F
;	.line	22; rtc.c	return(temp);
	MOVF	r0x00, W
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_rtc__BCD2UpperCh	code
_BCD2UpperCh:
;	.line	10; rtc.c	unsigned char BCD2UpperCh(unsigned char bcd)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	13; rtc.c	temp = bcd >> 4;
	SWAPF	r0x00, W
	ANDLW	0x0f
	MOVWF	r0x00
;	.line	14; rtc.c	temp = temp | 0x30;
	MOVLW	0x30
	IORWF	r0x00, F
;	.line	15; rtc.c	return(temp);	
	MOVF	r0x00, W
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_rtc__rtcInit	code
_rtcInit:
;	.line	6; rtc.c	void rtcInit(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	7; rtc.c	i2cInit();
	CALL	_i2cInit
	MOVFF	PREINC1, FSR2L
	RETURN	



; Statistics:
; code size:	 1014 (0x03f6) bytes ( 0.77%)
;           	  507 (0x01fb) words
; udata size:	    0 (0x0000) bytes ( 0.00%)
; access size:	    6 (0x0006) bytes


	end
