

#ifndef EVENT_H
    #define	EVENT_H
    enum{
        EV_UP,
        EV_DOWN,
        EV_LEFT,
        EV_RIGHT,
        EV_ENTER,
        EV_RESET,
        EV_NOEVENT
    };
    
    void eventInit(void);
    unsigned int eventRead(void);

#endif	
