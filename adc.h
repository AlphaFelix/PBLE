#ifndef ADC_H
	#define ADC_H
    enum{
        DIA,
        DIB,
        POT,
        KP,
        AN1       
    };    
	void adcInit(void);
    void adcAN(void);    
	int adcRead(char ch);
    int adcScale(char ch, float scale);
    int readPot(void);
      

#endif
