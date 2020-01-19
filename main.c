#include "config.h"
#include "pic18f4520.h"
#include "timer.h"
#include "event.h"
#include "var.h"
#include "stateMachine.h"
#include "output.h"
#include "led.h"
#include "alarm.h"
#include "rtc.h"

void main(void) {
     
    //init das bibliotecas    
    timerInit();    
    eventInit();
    outputInit();
    rtcInit();
    ledInit();  
    rtcMin(0x30);    
    rtcHour(0x14);
    rtcDate(0x29);
    rtcMonth(0x11);
    rtcYear(0x17);    
    rtcStart();    
                
    for (;;) {    
        varTest();
        timerReset(getTime());      
        //infraestrutura da placa       
        countTime();
        controlAlarms();
        //máquina de estados
        smLoop();
        timerWait();

    }
}