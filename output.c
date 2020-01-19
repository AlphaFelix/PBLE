#include "output.h"
#include "lcd.h"
#include "stateMachine.h"
#include "var.h"
#include "adc.h"
#include "serial.h"
#include "alarm.h"
#include "rtc.h"

#define NUM_IDIOMS 2
#define VARIABLES 5
#define SERIAL_S 0
#define SERIAL_AH 1
#define SERIAL_AL 2
#define SERIAL_T 3
#define SERIAL_L 4
//msgs com 16 caracteres
//1 msg por estado (apenas linha de cima)
static char * msgs[STATE_END][NUM_IDIOMS] = {
    {"<I   AL_A_0 AB0>", "<I   AL_H_0 AL0>"},
    {"ALARME ALTO 0:  ", "ALARM HIGH 0:   "},
    {"<AA0 AL_B_0 AA1>", "<AH0 AL_L_0 AH1>"},
    {"ALARME BAIXO 0: ", "ALARM LOW 0:    "},
    {"<AB0 AL_A_1 AB1>", "<AL0 AL_H_1 AL1>"},
    {"ALARME ALTO 1:  ", "ALARM HIGH 1:   "},
    {"<AA1 AL_B_1   T>", "<AH1 AL_L_1   T>"},
    {"ALARME BAIXO 1: ", "ALARM LOW 1:    "},
    {"<AB1 TEMPO    I>", "<AL1  TIME    I>"},
    {"ALTERAR TEMPO:  ", "CHANGE TIME:    "},
    {"<T   IDIOMA   D>", "<T   IDIOM    D>"},
    {"<I   DATA   AA0>", "<T   DATE   AH0>"},    
    {"Resetar?        ", "Reset?          "}
};

static char * serial[VARIABLES][NUM_IDIOMS] = {
    {"Estado = ", "State = "},
    {"Alarme Alto = ", "Alarm High = "},
    {"Alarme Baixo = ", "Alarm Low = "},
    {"Tempo = ", "Time = "},
    {"Idioma = ", "Idiom = "}     
};

static unsigned char state_ant, language_ant;
static unsigned int time_ant, alarmLow_ant, alarmHigh_ant;

void outputInit(void) {   
    lcdInit();
    adcInit();
    serialInit();
    state_ant = 0;
    language_ant = 0;
    time_ant = 0;
    alarmLow_ant = 0;
    alarmHigh_ant = 0;
}



void outputPrint(int numTela, char idiom) {
    char testHigh0, testLow0, testHigh1, testLow1;
    int sec, min, hour, date, month, year;
    adcInit();
    testHigh0 = testAlarmHigh(0);
    testLow0 = testAlarmLow(0);
    testHigh1 = testAlarmHigh(1);
    testLow1 = testAlarmLow(1);
    
    if (numTela == STATE_ALARM_HIGH_0) {
        lcdCommand(0x80);
        lcdString(msgs[numTela][idiom]);
        lcdCommand(0xC0);         
        lcdInt(getAlarmHigh(0));
        lcdString("         ");
        if(testHigh0 == 1)
            lcdString(" ON ");
        else
            lcdString("OFF ");       
    }
    if (numTela == STATE_SET_AH_0) {
        lcdCommand(0x80);
        lcdString(msgs[numTela][idiom]);
        lcdCommand(0xC0);        
        lcdInt(getAlarmHigh(0));        
        if(testHigh0 == 1)
            lcdString(" ON  ");
        else
            lcdString(" OFF ");
        lcdString("A0:");
        lcdInt(adcScale(POT, 1000));
    }
    if (numTela == STATE_ALARM_LOW_0) {
        lcdCommand(0x80);
        lcdString(msgs[numTela][idiom]);
        lcdCommand(0xC0);
        lcdInt(getAlarmLow(0));
        lcdString("         ");
        if(testLow0 == 1)
            lcdString(" ON ");
        else
            lcdString("OFF "); 
    }
    if (numTela == STATE_SET_AL_0) {
        lcdCommand(0x80);
        lcdString(msgs[numTela][idiom]);
        lcdCommand(0xC0);
        lcdInt(getAlarmLow(0));        
        if(testLow0 == 1)
            lcdString(" ON  ");
        else
            lcdString(" OFF ");
        lcdString("A0:");
        lcdInt(adcScale(POT, 1020));
    }
    if (numTela == STATE_ALARM_HIGH_1) {
        lcdCommand(0x80);
        lcdString(msgs[numTela][idiom]);
        lcdCommand(0xC0);
        lcdInt(getAlarmHigh(1));
        lcdString("         ");
        if(testHigh1 == 1)
            lcdString(" ON ");
        else
            lcdString("OFF "); 
    }
    if (numTela == STATE_SET_AH_1) {
        lcdCommand(0x80);
        lcdString(msgs[numTela][idiom]);
        lcdCommand(0xC0);
        lcdInt(getAlarmHigh(1));
        if(testHigh1 == 1)
            lcdString(" ON  ");
        else
            lcdString(" OFF ");
        lcdString("A1:");
        lcdInt(adcScale(POT, 1020));         
    }
    if (numTela == STATE_ALARM_LOW_1) {
        lcdCommand(0x80);
        lcdString(msgs[numTela][idiom]);
        lcdCommand(0xC0);
        
        lcdInt(getAlarmLow(1));
        lcdString("         ");
        if(testLow1 == 1)
            lcdString(" ON ");
        else
            lcdString("OFF "); 
    }
    if (numTela == STATE_SET_AL_1) {
        lcdCommand(0x80);
        lcdString(msgs[numTela][idiom]);
        lcdCommand(0xC0);
        lcdInt(getAlarmLow(1));
        if(testLow1 == 1)
            lcdString(" ON  ");
        else
            lcdString(" OFF ");
        lcdString("A1:");
        lcdInt(adcScale(POT, 1020));         
    }
    if (numTela == STATE_TIME) {
        lcdCommand(0x80);
        lcdString(msgs[numTela][idiom]);
        lcdCommand(0xC0);
        lcdInt(getTime());
        lcdString(" ms");
        lcdString("            ");//para apagar os textos depois do numero
    }
    if (numTela == STATE_SET_T) {
        lcdCommand(0x80);
        lcdString(msgs[numTela][idiom]);
        lcdCommand(0xC0);
        lcdInt(getTime());
        lcdString(" ms");
        lcdString("           ");//para apagar os textos depois do numero
    }
    if (numTela == STATE_IDIOM) {
        lcdCommand(0x80);
        lcdString(msgs[numTela][idiom]);
        lcdCommand(0xC0);
        if (getIdiom() == 0) {
            lcdString("Portugues       ");
        }
        if (getIdiom() == 1) {
            lcdString("English         ");
        }
    }
    
    if (numTela == STATE_DATE) {
        lcdCommand(0x80);
        lcdString(msgs[numTela][idiom]);
        lcdCommand(0xC0);
        
        sec = rtcRead(0x00);
        min = rtcRead(0x01);
        hour = rtcRead(0x02);        
        date = rtcRead(0x04);
        month = rtcRead(0x05);
        year = rtcRead(0x06);
        
        lcdData(BCD2UpperCh(hour));
		lcdData(BCD2LowerCh(hour));
		lcdData(':');
		lcdData(BCD2UpperCh(min));
		lcdData(BCD2LowerCh(min));
		lcdData(':');
		lcdData(BCD2UpperCh(sec));
		lcdData(BCD2LowerCh(sec));
        lcdString("   ");
		lcdData(BCD2UpperCh(date));
		lcdData(BCD2LowerCh(date));
		lcdData('/');
		lcdData(BCD2UpperCh(month));
		lcdData(BCD2LowerCh(month));
		
        
    }
    
    if (numTela == STATE_RST) {
        lcdCommand(0x80);
        lcdString(msgs[numTela][idiom]);  
        lcdCommand(0xC0);
        if (getIdiom() == 0) {
            lcdString(" (<-) S/N (->)  ");
        }
        if (getIdiom() == 1) {
            lcdString(" (<-) Y/N (->)  ");
        }
    }    

}

void outputSerial(int numTela, char idiom) {    
    char state, language;
    int time, alarmLow, alarmHigh;
    state = getState();
    language = getIdiom();
    time = getTime();
    alarmLow = getAlarmLow(0);
    alarmHigh = getAlarmHigh(0);
    
    if (state != state_ant) {
        serialString(serial[SERIAL_S][idiom]);
        serialString(msgs[numTela][idiom]);
        serialSend(13);
    }     
    if (alarmHigh != alarmHigh_ant) {
        serialString(serial[SERIAL_AH][idiom]);
        serialInt(alarmHigh);
        serialSend(13);
    }
    if (alarmLow != alarmLow_ant) {
        serialString(serial[SERIAL_AL][idiom]);
        serialInt(alarmLow);
        serialSend(13);
    }
    if (time != time_ant) {
        serialString(serial[SERIAL_T][idiom]);
        serialInt(time);
        serialSend(13);
    }
    
   
    state_ant = state;
    language_ant = language;
    time_ant = time;
    alarmLow_ant = alarmLow;
    alarmHigh_ant = alarmHigh;
    
            
}


