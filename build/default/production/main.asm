;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.6.0 #9615 (MINGW64)
;--------------------------------------------------------
; PIC16 port for the Microchip 16-bit core micros
;--------------------------------------------------------
	list	p=18f4550
	radix	dec
	CONFIG	MCLRE=ON
	CONFIG	FOSC=HS
	CONFIG	WDT=OFF
	CONFIG	LVP=OFF
	CONFIG	ICPRT=ON
	CONFIG	XINST=OFF


;--------------------------------------------------------
; public variables in this module
;--------------------------------------------------------
	global	_main

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern	_timerWait
	extern	_countTime
	extern	_timerReset
	extern	_timerInit
	extern	_eventInit
	extern	_varTest
	extern	_getTime
	extern	_smLoop
	extern	_outputInit
	extern	_ledInit
	extern	_controlAlarms
	extern	_rtcInit
	extern	_rtcStart
	extern	_rtcMin
	extern	_rtcHour
	extern	_rtcDate
	extern	_rtcMonth
	extern	_rtcYear

;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
POSTINC1	equ	0xfe6
POSTDEC1	equ	0xfe5
PRODL	equ	0xff3


; Internal registers
.registers	udata_ovr	0x0000
r0x00	res	1
r0x01	res	1

;--------------------------------------------------------
; interrupt vector
;--------------------------------------------------------

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_main__main	code
_main:
;	.line	15; main.c	timerInit();    
	CALL	_timerInit
;	.line	16; main.c	eventInit();
	CALL	_eventInit
;	.line	17; main.c	outputInit();
	CALL	_outputInit
;	.line	18; main.c	rtcInit();
	CALL	_rtcInit
;	.line	19; main.c	ledInit();  
	CALL	_ledInit
;	.line	20; main.c	rtcMin(0x30);    
	MOVLW	0x30
	MOVWF	POSTDEC1
	CALL	_rtcMin
	MOVF	POSTINC1, F
;	.line	21; main.c	rtcHour(0x14);
	MOVLW	0x14
	MOVWF	POSTDEC1
	CALL	_rtcHour
	MOVF	POSTINC1, F
;	.line	22; main.c	rtcDate(0x29);
	MOVLW	0x29
	MOVWF	POSTDEC1
	CALL	_rtcDate
	MOVF	POSTINC1, F
;	.line	23; main.c	rtcMonth(0x11);
	MOVLW	0x11
	MOVWF	POSTDEC1
	CALL	_rtcMonth
	MOVF	POSTINC1, F
;	.line	24; main.c	rtcYear(0x17);    
	MOVLW	0x17
	MOVWF	POSTDEC1
	CALL	_rtcYear
	MOVF	POSTINC1, F
;	.line	25; main.c	rtcStart();    
	CALL	_rtcStart
_00106_DS_:
;	.line	28; main.c	varTest();
	CALL	_varTest
;	.line	29; main.c	timerReset(getTime());      
	CALL	_getTime
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_timerReset
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	31; main.c	countTime();
	CALL	_countTime
;	.line	32; main.c	controlAlarms();
	CALL	_controlAlarms
;	.line	34; main.c	smLoop();
	CALL	_smLoop
;	.line	35; main.c	timerWait();
	CALL	_timerWait
	BRA	_00106_DS_
	RETURN	



; Statistics:
; code size:	  124 (0x007c) bytes ( 0.09%)
;           	   62 (0x003e) words
; udata size:	    0 (0x0000) bytes ( 0.00%)
; access size:	    2 (0x0002) bytes


	end
