#include "rtc.h"
#include "i2c.h"
#include "lcd.h"
#include<pic18f4550.h>

void rtcInit(void) {
    i2cInit();
}

unsigned char BCD2UpperCh(unsigned char bcd)
{
	unsigned char temp;
 	temp = bcd >> 4;
 	temp = temp | 0x30;
 	return(temp);	
}
unsigned char BCD2LowerCh(unsigned char bcd)
{
	unsigned char temp;
 	temp = bcd & 0x0F; //Making the Upper 4-bits
 	temp = temp | 0x30;
 	return(temp);
}

void rtcStore(unsigned char address, char val)
{	
	i2cStart();
    i2cSend(0xD0);
    i2cSend(address);	
    i2cSend(val);
    i2cStop();   
}

void rtcStoreInt(unsigned char address, int val)
{	
	i2cStart();
    i2cSend(0xD0);
    i2cSend(address);	
    i2cSend(val >> 8);    
    i2cSend(val & 0x00FF);
    i2cStop();
}

char rtcRead(unsigned char address){
    char val;
    i2cStart();
	i2cSend(0xD0);
	i2cSend(address);
	i2cRestart();
	i2cSend(0xD1);
	val = i2cRead();
	i2cStop();	
    return val;
}

int rtcReadInt(unsigned char address){
    unsigned char valH, valL;
    int val;
    
    valH = rtcRead(address);  
	valL = rtcRead(address+1);	
    val = (valH << 8);
    val = val + valL;      
    
    return val;
}

void rtcStart(void){
    i2cStart();
    i2cSend(0xD0);
    i2cSend(0x00);
    i2cSend(0x00);	
    i2cStop();
    lcdCommand(0x01);
    
}

void rtcMin(unsigned char min){
    i2cStart();
    i2cSend(0xD0);
    i2cSend(0x01);
    i2cSend(min);	
    i2cStop();
    lcdCommand(0x01);
}

void rtcHour(unsigned char hour){
    i2cStart();
    i2cSend(0xD0);
    i2cSend(0x02);
    i2cSend(hour);	
    i2cStop();
    lcdCommand(0x01);
}

void rtcDay(unsigned char day){
    i2cStart();
    i2cSend(0xD0);
    i2cSend(0x03);
    i2cSend(day);	
    i2cStop();
    lcdCommand(0x01);
}

void rtcDate(unsigned char date){
    i2cStart();
    i2cSend(0xD0);
    i2cSend(0x04);
    i2cSend(date);	
    i2cStop();
    lcdCommand(0x01);
}

void rtcMonth(unsigned char month){
    i2cStart();
    i2cSend(0xD0);
    i2cSend(0x05);
    i2cSend(month);	
    i2cStop();
    lcdCommand(0x01);
}

void rtcYear(unsigned char year){
    i2cStart();
    i2cSend(0xD0);
    i2cSend(0x06);
    i2cSend(year);	
    i2cStop();
    lcdCommand(0x01);
}