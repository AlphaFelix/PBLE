/* 
 * File:   i2c.h
 * Author: Avell
 *
 * Created on 4 de Outubro de 2017, 15:54
 */

#ifndef I2C_H
	#define I2C_H
 	
    void i2cInit(void);
    void i2cStart(void);
    void i2cRestart(void);
    void i2cStop(void);
    void i2cWait(void);
    void i2cSend(unsigned char dat);
    unsigned char i2cRead(void);    
#endif
