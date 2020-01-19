#include "keypad.h"
#include "pic18f4520.h"
#include "adc.h"

void kpInit(void)   //Inicia o teclado a partir dos registros necessarios 
{
    bitClr(INTCON2, 7); //liga pull up   
    bitSet(TRISE, 0);
#ifdef PIC18F4550
    SPPCFG = 0x00;          // SFR nao presente no PIC18F4520
#endif
}

 unsigned char tecla_pressionada;

unsigned char kpRead (void) {
    unsigned int Vteclado = 0, i; 
   	
	for(i=0; i<50; i++) {
		Vteclado += adcRead(KP);
	}
	
	Vteclado = Vteclado/50;
	
    if((Vteclado>=0)&&(Vteclado<170)) 
    {
        
        if(tecla_pressionada!=1) {
                tecla_pressionada = 1;            
        }
    }
    else if((Vteclado>200)&&(Vteclado<=370)) 
    {
        
        if(tecla_pressionada!=2) {
                tecla_pressionada = 2;           
        }
    }   
    
    else if((Vteclado>450)&&(Vteclado<=500)) 
    {
        
        if(tecla_pressionada!=3) {
           tecla_pressionada = 3;           
        }
        
    }
    
    else if((Vteclado>650)&&(Vteclado<=690)) 
    {
        if(tecla_pressionada!=4) {
                tecla_pressionada = 4;           
        }
    }
    
    else if((Vteclado>720)&&(Vteclado<=780))
    {
        if(tecla_pressionada!=5) {
                tecla_pressionada = 5;            
        }
    }  
    else
        tecla_pressionada = 0;
   
    return tecla_pressionada;    
}
    
    
    
    
    

    
