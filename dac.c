#include "i2c.h"

void dacI2c(unsigned int sample){
    i2cStart();    
    i2cSend(0xC0);
    i2cSend(0x40);
    i2cSend((sample & 0xFF0) >> 4);
    i2cSend((sample & 0xF) << 4);
    i2cStop();
 
}
