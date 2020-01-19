#ifndef SERIAL_H
	#define SERIAL_H

	void serialSend(unsigned char c);
    void serialInt(int val);
    void serialString(char vector[]);
	unsigned char serialRead(void);
	void serialInit(void);
    unsigned char serialProtocol(void);    
    

#endif