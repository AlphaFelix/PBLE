#ifndef VAR_H
    #define	VAR_H

    void varInit(void);
    void varTest(void);
    char getState(void);
    void setState(char newState);
    char getStateRst(void);
    void setStateRst(char newStateRst);
    int getTime(void);
    void setTime(int newTime);
    int getAlarmLow(char alarm);
    void setAlarmLow(char alarm, int newAlarmLow);
    int getAlarmHigh(char alarm);
    void setAlarmHigh(char alarm, int newAlarmHigh);
    char getIdiom(void);
    void setIdiom(char newIdiom);
    
#endif	/* VAR_H */
