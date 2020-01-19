#include "led.h"
#include "pic18f4520.h"
#include "alarm.h"
#include "var.h"
#include "adc.h"
#include "rtc.h"
#include "serial.h"

static char alarmNewH0 = 0, alarmAntH0 = 1;
static char alarmNewH1 = 0, alarmAntH1 = 1;
static char alarmNewL0 = 0, alarmAntL0 = 1;
static char alarmNewL1 = 0, alarmAntL1 = 1;

char testAlarmHigh(char alarm){    
    if(adcScale(POT, 1023) >= getAlarmHigh(alarm)){
        return 1;                                 
    }
    else {
        return 0;           
    }                   
}

char testAlarmLow(char alarm){    
    if(adcScale(POT, 1023) <= getAlarmLow(alarm)){
        return 1;        
    }
    else{
        return 0;   
    }    
}

void controlAlarms(void){
    int min, hour, sec, date, month, year;  
    alarmNewH0 = testAlarmHigh(0);
    alarmNewL0 = testAlarmLow(0);
    alarmNewH1 = testAlarmHigh(1);
    alarmNewL1 = testAlarmLow(1);
    
    if(alarmNewL0 == 1)
        ledBlink(0);
    if(alarmNewH0 == 1)
        ledOn(0);
    if(alarmNewH0 != alarmAntH0 & alarmNewH0 == 1)
    {                      
        serialString("Alarm High 0 Acionado");
        serialSend(13);      
    }    
    if(alarmNewH0 != alarmAntH0 & alarmNewH0 == 0)
    {                        
        serialString("Alarm High 0 Desligado");
        serialSend(13);        
    }          
    if(alarmNewL0 != alarmAntL0 & alarmNewL0 == 1)
    {                            
        serialString("Alarm Low 0 Acionado");
        serialSend(13);      
    }       
    if(alarmNewL0 != alarmAntL0 & alarmNewL0 == 0)
    {                    
        serialString("Alarm Low 0 Desligado");
        serialSend(13);        
    } 
    if(alarmNewH0 == 0 & alarmNewL0 == 0)
    {
        ledOff(0);
    }
    if(alarmNewL1 == 1)
        ledBlink(1);
    if(alarmNewH1 == 1)
        ledOn(1); 
    if(alarmNewH1 != alarmAntH1 & alarmNewH1 == 1)
    {                       
        serialString("Alarm High 1 Acionado");
        serialSend(13);      
    }    
    if(alarmNewH1 != alarmAntH1 & alarmNewH1 == 0)
    {                        
        serialString("Alarm High 1 Desligado");
        serialSend(13);        
    }          
    if(alarmNewL1 != alarmAntL1 & alarmNewL1 == 1)
    {                            
        serialString("Alarm Low 1 Acionado");
        serialSend(13);      
    }       
    if(alarmNewL1 != alarmAntL1 & alarmNewL1 == 0)
    {                    
        serialString("Alarm Low 1 Desligado");
        serialSend(13);        
    } 
    if(alarmNewH1 == 0 & alarmNewL1 == 0)
    {
        ledOff(1);
    }
    if(alarmNewL0 != alarmAntL0 | alarmNewH0 != alarmAntH0 | alarmNewL1 != alarmAntL1 | alarmNewH1 != alarmAntH1)
    {
        min = rtcRead(0x01);
        hour = rtcRead(0x02);
        sec = rtcRead(0x00);
        date = rtcRead(0x04);
        month = rtcRead(0x05);
        year = rtcRead(0x06);
        serialString("Time: ");
        serialSend(BCD2UpperCh(hour));
		serialSend(BCD2LowerCh(hour));
		serialSend(':');
		serialSend(BCD2UpperCh(min));
		serialSend(BCD2LowerCh(min));
		serialSend(':');
		serialSend(BCD2UpperCh(sec));
		serialSend(BCD2LowerCh(sec));
		serialSend(13);
		serialString("Date: ");
		serialSend(BCD2UpperCh(date));
		serialSend(BCD2LowerCh(date));
		serialSend('/');
		serialSend(BCD2UpperCh(month));
		serialSend(BCD2LowerCh(month));
		serialSend('/');
		serialSend(BCD2UpperCh(year));
		serialSend(BCD2LowerCh(year));
        serialSend(13);
    }
    alarmAntL1 = alarmNewL1;    
    alarmAntH1 = alarmNewH1;
    alarmAntL0 = alarmNewL0;
    alarmAntH0 = alarmNewH0;          
}


    
   

