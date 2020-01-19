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

    //m�quina de estados
    event = eventRead();

    switch (getState()) {
        case STATE_ALARM_HIGH_0:
            //execu��o de atividade
            if (event == EV_RIGHT) {
                setState(STATE_ALARM_LOW_0);
            }
            if (event == EV_LEFT) {
                setState(STATE_DATE);
            }

            //gest�o da maquina de estado
            if (event == EV_ENTER) {
                setState(STATE_SET_AH_0);
            }            
            if (event == EV_RESET) {
                setStateRst(STATE_ALARM_HIGH_0);
                setState(STATE_RST);
            }
            break; 
        case STATE_SET_AH_0:
            //execu��o de atividade
            if (event == EV_RIGHT) {
                setAlarmHigh(0, getAlarmHigh(0) + 1);
            }
            if (event == EV_LEFT) {
                setAlarmHigh(0, getAlarmHigh(0) - 1);
            }

            //gest�o da maquina de estado
            if (event == EV_ENTER) {
                setState(STATE_ALARM_HIGH_0);
            }         
            if (event == EV_RESET) {
                setStateRst(STATE_SET_AH_0);
                setState(STATE_RST);
            }
            break;
            
        case STATE_ALARM_LOW_0:
            //execu��o de atividade
            if (event == EV_RIGHT) {
                setState(STATE_ALARM_HIGH_1);
            }
            if (event == EV_LEFT) {
                setState(STATE_ALARM_HIGH_0);
            }

            //gest�o da maquina de estado
            if (event == EV_ENTER) {
                setState(STATE_SET_AL_0);
            }        
            if (event == EV_RESET) {
                setStateRst(STATE_ALARM_LOW_0);
                setState(STATE_RST);
            }
            break;            
        case STATE_SET_AL_0:
            //execu��o de atividade
            if (event == EV_RIGHT) {
                setAlarmLow(0, getAlarmLow(0) + 1);
            }
            if (event == EV_LEFT) {
                setAlarmLow(0, getAlarmLow(0) - 1);
            }

            //gest�o da maquina de estado
            if (event == EV_ENTER) {
                setState(STATE_ALARM_LOW_0);
            }                
            if (event == EV_RESET) {
                setStateRst(STATE_SET_AL_0);
                setState(STATE_RST);
            }
            break;
            
        case STATE_ALARM_HIGH_1:
            //execu��o de atividade
            if (event == EV_RIGHT) {
                setState(STATE_ALARM_LOW_1);
            }
            if (event == EV_LEFT) {
                setState(STATE_ALARM_LOW_0);
            }

            //gest�o da maquina de estado
            if (event == EV_ENTER) {
                setState(STATE_SET_AH_1);
            }            
            if (event == EV_RESET) {
                setStateRst(STATE_ALARM_HIGH_1);
                setState(STATE_RST);
            }
            break; 
        case STATE_SET_AH_1:
            //execu��o de atividade
            if (event == EV_RIGHT) {
                setAlarmHigh(1, getAlarmHigh(1) + 1);
            }
            if (event == EV_LEFT) {
                setAlarmHigh(1, getAlarmHigh(1) - 1);
            }

            //gest�o da maquina de estado
            if (event == EV_ENTER) {
                setState(STATE_ALARM_HIGH_1);
            }         
            if (event == EV_RESET) {
                setStateRst(STATE_SET_AH_1);
                setState(STATE_RST);
            }
            break;
            
        case STATE_ALARM_LOW_1:
            //execu��o de atividade
            if (event == EV_RIGHT) {
                setState(STATE_TIME);
            }
            if (event == EV_LEFT) {
                setState(STATE_ALARM_HIGH_1);
            }

            //gest�o da maquina de estado
            if (event == EV_ENTER) {
                setState(STATE_SET_AL_1);
            }        
            if (event == EV_RESET) {
                setStateRst(STATE_ALARM_LOW_1);
                setState(STATE_RST);
            }
            break;
            
        case STATE_SET_AL_1:
            //execu��o de atividade
            if (event == EV_RIGHT) {
                setAlarmLow(1, getAlarmLow(1) + 1);
            }
            if (event == EV_LEFT) {
                setAlarmLow(1, getAlarmLow(1) - 1);
            }

            //gest�o da maquina de estado
            if (event == EV_ENTER) {
                setState(STATE_ALARM_LOW_1);
            }                
            if (event == EV_RESET) {
                setStateRst(STATE_SET_AL_1);
                setState(STATE_RST);
            }
            break;
            
        case STATE_TIME:
            //execu��o de atividade
            if (event == EV_RIGHT) {
                setState(STATE_IDIOM);
            }
            if (event == EV_LEFT) {
                setState(STATE_ALARM_LOW_1);
            }

            //gest�o da maquina de estado
            if (event == EV_ENTER) {
                setState(STATE_SET_T);
            }
            if (event == EV_RESET) {
                setStateRst(STATE_TIME);
                setState(STATE_RST);
            }            
            break;    
        case STATE_SET_T:
            //execu��o de atividade
            if (event == EV_RIGHT) {
                setTime(getTime() + 1);
            }
            if (event == EV_LEFT) {
                setTime(getTime() - 1);
            }

            //gest�o da maquina de estado
            if (event == EV_ENTER) {
                setState(STATE_TIME);
            }
            if (event == EV_RESET) {
                setStateRst(STATE_SET_T);
                setState(STATE_RST);
            }
            break;

        case STATE_IDIOM:
            //execu��o de atividade
            if (event == EV_RIGHT) {
                setState(STATE_DATE);
            }
            if (event == EV_LEFT) {
                setState(STATE_TIME);
            }

            //gest�o da maquina de estado
            if (event == EV_ENTER) {
                setIdiom(getIdiom() + 1);
            }
            if (event == EV_RESET) {
                setStateRst(STATE_IDIOM);
                setState(STATE_RST);
            }
            break; 
        case STATE_DATE:
            //execu��o de atividade
            if (event == EV_RIGHT) {
                setState(STATE_ALARM_HIGH_0);
            }
            if (event == EV_LEFT) {
                setState(STATE_IDIOM);
            }
            //gest�o da maquina de estado
           
            if (event == EV_RESET) {
                setStateRst(STATE_DATE);
                setState(STATE_RST);
            }
            break; 
         
            
        case STATE_RST:
            //execu��o de atividade
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

