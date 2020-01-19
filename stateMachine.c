#include "stateMachine.h"
#include "var.h"
#include "event.h"
#include "output.h"

static char stateRST;

void smInit(void) {
    setState(STATE_TIME);    
}

void smLoop(void) {
    unsigned char event;

    //máquina de estados
    event = eventRead();

    switch (getState()) {
        case STATE_ALARM_HIGH_0:
            //execução de atividade
            if (event == EV_RIGHT) {
                setState(STATE_ALARM_LOW_0);
            }
            if (event == EV_LEFT) {
                setState(STATE_DATE);
            }

            //gestão da maquina de estado
            if (event == EV_ENTER) {
                setState(STATE_SET_AH_0);
            }            
            if (event == EV_RESET) {
                setStateRst(STATE_ALARM_HIGH_0);
                setState(STATE_RST);
            }
            break; 
        case STATE_SET_AH_0:
            //execução de atividade
            if (event == EV_RIGHT) {
                setAlarmHigh(0, getAlarmHigh(0) + 1);
            }
            if (event == EV_LEFT) {
                setAlarmHigh(0, getAlarmHigh(0) - 1);
            }

            //gestão da maquina de estado
            if (event == EV_ENTER) {
                setState(STATE_ALARM_HIGH_0);
            }         
            if (event == EV_RESET) {
                setStateRst(STATE_SET_AH_0);
                setState(STATE_RST);
            }
            break;
            
        case STATE_ALARM_LOW_0:
            //execução de atividade
            if (event == EV_RIGHT) {
                setState(STATE_ALARM_HIGH_1);
            }
            if (event == EV_LEFT) {
                setState(STATE_ALARM_HIGH_0);
            }

            //gestão da maquina de estado
            if (event == EV_ENTER) {
                setState(STATE_SET_AL_0);
            }        
            if (event == EV_RESET) {
                setStateRst(STATE_ALARM_LOW_0);
                setState(STATE_RST);
            }
            break;            
        case STATE_SET_AL_0:
            //execução de atividade
            if (event == EV_RIGHT) {
                setAlarmLow(0, getAlarmLow(0) + 1);
            }
            if (event == EV_LEFT) {
                setAlarmLow(0, getAlarmLow(0) - 1);
            }

            //gestão da maquina de estado
            if (event == EV_ENTER) {
                setState(STATE_ALARM_LOW_0);
            }                
            if (event == EV_RESET) {
                setStateRst(STATE_SET_AL_0);
                setState(STATE_RST);
            }
            break;
            
        case STATE_ALARM_HIGH_1:
            //execução de atividade
            if (event == EV_RIGHT) {
                setState(STATE_ALARM_LOW_1);
            }
            if (event == EV_LEFT) {
                setState(STATE_ALARM_LOW_0);
            }

            //gestão da maquina de estado
            if (event == EV_ENTER) {
                setState(STATE_SET_AH_1);
            }            
            if (event == EV_RESET) {
                setStateRst(STATE_ALARM_HIGH_1);
                setState(STATE_RST);
            }
            break; 
        case STATE_SET_AH_1:
            //execução de atividade
            if (event == EV_RIGHT) {
                setAlarmHigh(1, getAlarmHigh(1) + 1);
            }
            if (event == EV_LEFT) {
                setAlarmHigh(1, getAlarmHigh(1) - 1);
            }

            //gestão da maquina de estado
            if (event == EV_ENTER) {
                setState(STATE_ALARM_HIGH_1);
            }         
            if (event == EV_RESET) {
                setStateRst(STATE_SET_AH_1);
                setState(STATE_RST);
            }
            break;
            
        case STATE_ALARM_LOW_1:
            //execução de atividade
            if (event == EV_RIGHT) {
                setState(STATE_TIME);
            }
            if (event == EV_LEFT) {
                setState(STATE_ALARM_HIGH_1);
            }

            //gestão da maquina de estado
            if (event == EV_ENTER) {
                setState(STATE_SET_AL_1);
            }        
            if (event == EV_RESET) {
                setStateRst(STATE_ALARM_LOW_1);
                setState(STATE_RST);
            }
            break;
            
        case STATE_SET_AL_1:
            //execução de atividade
            if (event == EV_RIGHT) {
                setAlarmLow(1, getAlarmLow(1) + 1);
            }
            if (event == EV_LEFT) {
                setAlarmLow(1, getAlarmLow(1) - 1);
            }

            //gestão da maquina de estado
            if (event == EV_ENTER) {
                setState(STATE_ALARM_LOW_1);
            }                
            if (event == EV_RESET) {
                setStateRst(STATE_SET_AL_1);
                setState(STATE_RST);
            }
            break;
            
        case STATE_TIME:
            //execução de atividade
            if (event == EV_RIGHT) {
                setState(STATE_IDIOM);
            }
            if (event == EV_LEFT) {
                setState(STATE_ALARM_LOW_1);
            }

            //gestão da maquina de estado
            if (event == EV_ENTER) {
                setState(STATE_SET_T);
            }
            if (event == EV_RESET) {
                setStateRst(STATE_TIME);
                setState(STATE_RST);
            }            
            break;    
        case STATE_SET_T:
            //execução de atividade
            if (event == EV_RIGHT) {
                setTime(getTime() + 1);
            }
            if (event == EV_LEFT) {
                setTime(getTime() - 1);
            }

            //gestão da maquina de estado
            if (event == EV_ENTER) {
                setState(STATE_TIME);
            }
            if (event == EV_RESET) {
                setStateRst(STATE_SET_T);
                setState(STATE_RST);
            }
            break;

        case STATE_IDIOM:
            //execução de atividade
            if (event == EV_RIGHT) {
                setState(STATE_DATE);
            }
            if (event == EV_LEFT) {
                setState(STATE_TIME);
            }

            //gestão da maquina de estado
            if (event == EV_ENTER) {
                setIdiom(getIdiom() + 1);
            }
            if (event == EV_RESET) {
                setStateRst(STATE_IDIOM);
                setState(STATE_RST);
            }
            break; 
        case STATE_DATE:
            //execução de atividade
            if (event == EV_RIGHT) {
                setState(STATE_ALARM_HIGH_0);
            }
            if (event == EV_LEFT) {
                setState(STATE_IDIOM);
            }
            //gestão da maquina de estado
           
            if (event == EV_RESET) {
                setStateRst(STATE_DATE);
                setState(STATE_RST);
            }
            break; 
         
            
        case STATE_RST:
            //execução de atividade
            if (event == EV_RIGHT) {
                setState(getStateRst());
            }
            if (event == EV_LEFT) {
                varInit();
            }
            break;
            
        default: setState(STATE_ALARM_HIGH_0);
            break;
        
    }
    outputPrint(getState(), getIdiom());
    outputSerial(getState(), getIdiom());
    
}

