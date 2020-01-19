#ifndef LCD_H
	#define LCD_H
	void delay40us(void);
    void delay2ms(void);
    void pulsoEN(void);
    void lcdCommand(unsigned char cmd);       
    void lcdLine(int valor);
    void lcdData(unsigned char valor);
    void lcdInt(int val);
    void lcdString(char vector[]);  
    void lcdInit(void);
#endif
