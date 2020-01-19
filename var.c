#include "var.h"
#include "rtc.h"

#define ADDRESS_STATE 400
#define ADDRESS_TIME 500
#define ADDRESS_AL0 600
#define ADDRESS_AL1 630
#define ADDRESS_AH0 700
#define ADDRESS_AH1 430
#define ADDRESS_IDIOM 650

//variáveis a serem armazenadas
static char state;
static char stateRst;
static char idiom;
static int time;
static int alarmLow;
static int alarmHigh;

void varInit(void) {   
    setState(0);    
    setIdiom(0);
    setTime(1000);
    rtcStoreInt(ADDRESS_AL0, 1000);
    rtcStoreInt(ADDRESS_AL1, 3000);     
    rtcStoreInt(ADDRESS_AH0, 7000);
    rtcStoreInt(ADDRESS_AH1, 9000);
    
}

void varTest(void) {   
    if(getAlarmHigh(0)<= getAlarmLow(0)){            
        rtcStoreInt(ADDRESS_AH0, 7000);
        rtcStoreInt(ADDRESS_AL0, 1000);
    }
    if(getAlarmHigh(1)<= getAlarmLow(1)){
        rtcStoreInt(ADDRESS_AH1, 9000);
        rtcStoreInt(ADDRESS_AL1, 3000);
    }
    if(getTime()<0)
        setTime(1000);
    if(getAlarmHigh(0)<0)
        rtcStoreInt(ADDRESS_AH0, 7000);
    if(getAlarmHigh(1)<0)
        rtcStoreInt(ADDRESS_AH1, 9000);
    if(getAlarmLow(0)<0)
        rtcStoreInt(ADDRESS_AL0, 1000);
    if(getAlarmLow(1)<0)
        rtcStoreInt(ADDRESS_AL1, 300);   
    
}

char getState(void) {    
    state = rtcRead(ADDRESS_STATE);	
    return state;
}
void setState(char newState) {   
    rtcStore(ADDRESS_STATE, newState);
    state = newState;	
}
char getStateRst(void) {
    return stateRst;
}
void setStateRst(char newStateRst) {
    stateRst = newStateRst;
}

int getTime(void) {      
	time = rtcReadInt(ADDRESS_TIME);	
    return time;
}
void setTime(int newTime) {
    if((newTime)>=0 & newTime <= 9999){
        time = newTime; 
        rtcStoreInt(ADDRESS_TIME, time);	
    }
}

int getAlarmLow(char alarm) {
    if(alarm%2 == 0)
        alarmLow = rtcReadInt(ADDRESS_AL0);	
    else
        alarmLow = rtcReadInt(ADDRESS_AL1);     
    return alarmLow;
}
void setAlarmLow(char alarm,int newAlarmLow) {    
    if(newAlarmLow < getAlarmHigh(alarm) & newAlarmLow > 0 & newAlarmLow <= 9999){
        if(alarm%2 == 0)
            rtcStoreInt(ADDRESS_AL0, newAlarmLow);	
        else
            rtcStoreInt(ADDRESS_AL1, newAlarmLow);     
    }
}
int getAlarmHigh(char alarm) {    
    if(alarm%2 == 0)
        alarmHigh = rtcReadInt(ADDRESS_AH0);	
    else
        alarmHigh = rtcReadInt(ADDRESS_AH1);        
    return alarmHigh;
}
void setAlarmHigh(char alarm, int newAlarmHigh) {
    if(newAlarmHigh > getAlarmLow(alarm) & newAlarmHigh > 0 & newAlarmHigh <= 9999){
        if(alarm%2 == 0)
           rtcStoreInt(ADDRESS_AH0, newAlarmHigh);	
        else
           rtcStoreInt(ADDRESS_AH1, newAlarmHigh);
    }	    
}

char getIdiom(void){
    idiom = rtcRead(ADDRESS_IDIOM)%2;
    return idiom;
}
void setIdiom(char newIdiom){
    //só tem 2 linguas
    //usando resto pra evitar colocar valor errado
    idiom = newIdiom%2; 
    rtcStore(ADDRESS_IDIOM, idiom);
            
}
