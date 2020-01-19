#include "keypad.h"
#include "event.h"
#include "pic18f4520.h"
#include "serial.h"

static unsigned char key_ant;

void eventInit(void) {
    kpInit();
    serialInit();
    key_ant = 0;    
}

unsigned int eventRead(void) {
    int key, serial;
    int ev = EV_NOEVENT;
    key = kpRead();
    serial = serialProtocol();
    if ((key != 0) || (serial !=0)) {
        if ((key == 1)|| (serial == 'A')) {
            ev = EV_LEFT;
        }

        if ((key == 2)||(serial== 'S')) {
            ev = EV_ENTER;
        }

        if ((key == 3)||(serial=='D')) {
            ev = EV_RIGHT;
        }
        
        if ((key == 4)||(serial=='@')) {
            ev = EV_RESET;
        }
    }

    key_ant = key; 
    return ev;
}
