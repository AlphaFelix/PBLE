#include "adc.h"
#include "serial.h"
#include "pic18f4520.h"
#include "serial.h"

 void adcInit(void)
{	
    bitClr(TRISA,0); //Inicializa o pino conectado ao RS do LCD como output
    bitClr(TRISA,1); //Inicializa o pino conectado ao EN do LCD como output
    bitSet(TRISA,2); 	
	bitSet(TRISA,3);
    bitSet(TRISA,5);    
    ADCON0 = 0b00010000; //Desliga o ad
	ADCON1 = 0x0F; //Todos Digitais, a referencia é baseada na fonte
	ADCON2 = 0b10101010; //FOSC /32, Alinhamento à direita e tempo de conv = 12 TAD
} 

 void adcAN(void)
{		
	ADCON0 = 0b00010001; //Liga o ad
    ADCON1 = 0x06; //Até o AN8 é analogico, a referencia é baseada na fonte
	ADCON2 = 0b10101010; //FOSC /32, Alinhamento à direita e tempo de conv = 12 TAD
}

int adcRead(char ch)
{
	unsigned int ADvalor;
    
    ADCON1 = 0x06; //Até o AN8 é analogico, a referencia é baseada na fonte
	
    switch(ch){        
        case DIA: ADCON0 = 0b00001001; break;//seleciona o canal 2 e liga o ad        
        case DIB: ADCON0 = 0b00001101; break;//seleciona o canal 3 e liga o ad
        case POT: ADCON0 = 0b00010001; break;//seleciona o canal 4 e liga o ad
        case KP: ADCON0 = 0b00010101; break;//seleciona o canal 5 e liga o ad
        case AN1: ADCON0 = 0b00011101; break;  //seleciona o canal 7 e liga o ad        
    }
    
    ADCON0 |= 0b00000010;	 //inicia conversao

	while(bitTst(ADCON0,1)); // espera terminar a conversão;

	ADvalor = ADRESH ; // le o resultado
	ADvalor <<= 8;
	ADvalor += ADRESL;
    adcInit(); //Define as portas como digitais, para ser possivel utilizar o LCD
	return ADvalor;
}

int adcScale(char ch, float scale)
{	
    unsigned int ADvalor;
    float convert;     
	ADCON1 = 0x06; //Até o AN8 é analogico, a referencia é baseada na fonte
    switch(ch){        
        case DIA: ADCON0 = 0b00001001; convert = (scale*10000)/1023; break;//seleciona o canal 2 e liga o ad        
        case DIB: ADCON0 = 0b00001101; convert = (scale/1023)*10000; break;//seleciona o canal 3 e liga o ad
        case POT: ADCON0 = 0b00010001; convert = (scale/0,675); break;//seleciona o canal 4 e liga o ad       
        case AN1: ADCON0 = 0b00011101; convert = (scale/1023)*10000; break;  //seleciona o canal 7 e liga o ad        
    }
   
    ADCON0 |= 0b00000010;	 //inicia conversao

	while(bitTst(ADCON0,1)); // espera terminar a conversão;

	ADvalor = ADRESH ; // le o resultado
	ADvalor <<= 8;
	ADvalor += ADRESL;    
    ADvalor = ADvalor * 14.65; //Converte a escala de 0-675(3.3V) para 0-1023  
    adcInit(); //Define as portas como digitais, para ser possivel utilizar o LCD
    if(ADvalor>9999)
        return 9999;    
	return ADvalor;
}

