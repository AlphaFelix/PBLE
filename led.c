#include "pic18f4520.h"
#include "led.h"
#include "timer.h"

static unsigned int time0, time1;

void ledInit(void){    
    bitClr(TRISB,5);
    bitClr(TRISB,6);
    bitClr(PORTB,5);
    bitClr(PORTB,6);    
}

void ledOn(char x){
    bitSet(PORTB,((x%2)+5));   
}

void ledOff(char x){
    bitClr(PORTB,((x%2)+5));      
}

void ledBlink(char x){   
   
    if(getCount() == 0)
      bitFlp(PORTB,((x%2)+5));    
           
}


