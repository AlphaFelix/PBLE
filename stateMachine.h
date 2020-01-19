#ifndef STATEMACHINE_H
#define	STATEMACHINE_H

    //estados da maquina de Estados
    enum {
        STATE_ALARM_HIGH_0,
        STATE_SET_AH_0,
        STATE_ALARM_LOW_0,
        STATE_SET_AL_0,
        STATE_ALARM_HIGH_1,
        STATE_SET_AH_1,
        STATE_ALARM_LOW_1,
        STATE_SET_AL_1,
        STATE_TIME,
        STATE_SET_T,
        STATE_IDIOM, 
        STATE_DATE,
        STATE_RST,
        STATE_END
    };
    
    void smInit(void);
    void smLoop(void);

#endif	/* STATEMACHINE_H */
