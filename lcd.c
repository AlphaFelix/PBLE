#include "lcd.h"
#include "pic18f4520.h"

#define RS 0
#define EN 1

#define D1 7
#define D2 6
#define D3 5
#define D4 4


void delay40us(void){
	unsigned char k;
	for(k=0; k < 25; k++); //valor aproximado 
}

void delay2ms(void)
{
	unsigned char i;
	for(i=0; i < 10; i++)
	{
		delay40us();
	}   
}

void pulsoEN(void)
{
    bitClr(PORTA,EN);
    delay2ms();
        
    bitSet(PORTA,EN);   //Pulso no Enable
    delay2ms();
           
	bitClr(PORTA,EN);
    delay2ms();
      
}

void lcdCommand(unsigned char cmd)
{
	
    delay2ms();

    bitClr(PORTA,RS);
    bitClr(PORTA,EN);	//comando
	//BitClr(PORTB,RW);	// habilita escrita
	
    delay2ms();
    
        //Seleciona pinos de Dados: Nibble-High
	if(cmd&0b00010000){bitSet(PORTD,D1);}
	else {bitClr(PORTD,D1);}
	if(cmd&0b00100000){bitSet(PORTD,D2);}
	else {bitClr(PORTD,D2);}
	if(cmd&0b01000000){bitSet(PORTD,D3);}
	else {bitClr(PORTD,D3);}
	if(cmd&0b10000000){bitSet(PORTD,D4);}
	else {bitClr(PORTD,D4);}
    pulsoEN();
    
        //Seleciona pinos de Dados: Nibble-Low
    if(cmd&0b00000001){bitSet(PORTD,D1);}
	else {bitClr(PORTD,D1);}
	if(cmd&0b00000010){bitSet(PORTD,D2);}
	else {bitClr(PORTD,D2);}
	if(cmd&0b00000100){bitSet(PORTD,D3);}
	else {bitClr(PORTD,D3);}
	if(cmd&0b00001000){bitSet(PORTD,D4);}
	else {bitClr(PORTD,D4);}
    pulsoEN();
    
 } 

void lcdLine(int linha)
{
    if(linha==2)
        {
            lcdCommand(0xC0);
        }
        else
        {
            lcdCommand(0x80);
        }
}    
    
void lcdData(unsigned char valor)
{
    delay2ms();
    
    bitSet(PORTA,RS);
    bitClr(PORTA,EN);	//comando
	//BitClr(PORTB,RW);	// habilita escrita

    delay2ms();
    
        //Seleciona pinos de Dados: Nibble-High
    	if(valor&0b00010000){bitSet(PORTD,D1);}
	else {bitClr(PORTD,D1);}
	if(valor&0b00100000){bitSet(PORTD,D2);}
	else {bitClr(PORTD,D2);}
	if(valor&0b01000000){bitSet(PORTD,D3);}
	else {bitClr(PORTD,D3);}
	if(valor&0b10000000){bitSet(PORTD,D4);}
	else {bitClr(PORTD,D4);}    
    pulsoEN();
    
        //Seleciona pinos de Dados: Nibble-Low
    	if(valor&0b00000001){bitSet(PORTD,D1);}
	else {bitClr(PORTD,D1);}
	if(valor&0b00000010){bitSet(PORTD,D2);}
	else {bitClr(PORTD,D2);}
	if(valor&0b00000100){bitSet(PORTD,D3);}
	else {bitClr(PORTD,D3);}
	if(valor&0b00001000){bitSet(PORTD,D4);}
	else {bitClr(PORTD,D4);}
    pulsoEN();
    
    
    bitClr(PORTA,RS);
}

void lcdInt(int val) {
    if (val < 0) {
        val = val * (-1);
        lcdData('-');
    }    
    lcdData((val / 1000) % 10 + 48);
    lcdData((val / 100) % 10 + 48);
    lcdData((val / 10) % 10 + 48);
    lcdData((val / 1) % 10 + 48);

}


void lcdString(char vector[])
{
	char i = 0;
    
    while(vector[i])
    {
        lcdData(vector[i]);
        i++;
    }
}

void lcdInit(void)
{
// Inicializa o LCD
    
	// garante inicialização do LCD (+-10ms)
	delay2ms();
	delay2ms();
	delay2ms();

	// configurações de direção dos terminais
	bitClr(TRISA,RS);	//RS
	bitClr(TRISA,EN);	//EN
	//BitClr(TRISB,RW);	//RW
    
    //CONFIGURA AS PORTAS COMO SAÍDA
    bitClr(TRISD,D1);
	bitClr(TRISD,D2);
	bitClr(TRISD,D3);
	bitClr(TRISD,D4);
    
    bitClr(PORTA,RS);
	bitClr(PORTA,EN);
    
	delay2ms();
    
        //***********   INICIALIZAÇÃO	***********
    
    //3
    bitClr(PORTD,D4);
	bitClr(PORTD,D3);
    bitSet(PORTD,D2);	
    bitSet(PORTD,D1);
   
    pulsoEN();
        
    bitClr(PORTD,D4);
	bitClr(PORTD,D3);
    bitSet(PORTD,D2);	
    bitSet(PORTD,D1);
   
    pulsoEN();
    
    bitClr(PORTD,D4);
	bitClr(PORTD,D3);
    bitSet(PORTD,D2);	
    bitSet(PORTD,D1);
   
    pulsoEN();
    
    bitClr(PORTD,D4);
	bitClr(PORTD,D3);
    bitSet(PORTD,D2);	
    bitClr(PORTD,D1);
    
    pulsoEN();
    
    bitClr(PORTD,D4);
	bitClr(PORTD,D3);
    bitSet(PORTD,D2);	
    bitClr(PORTD,D1);
    
    pulsoEN();
    
    bitClr(PORTD,D4);
	bitClr(PORTD,D3);
    bitClr(PORTD,D1);
    bitSet(PORTD,D2);
	
    pulsoEN();
    
    bitClr(PORTD,D4);
	bitClr(PORTD,D3);
    bitClr(PORTD,D2);	
    bitClr(PORTD,D1);
    
    pulsoEN();
    
    bitSet(PORTD,D4);
	bitSet(PORTD,D3);
    bitSet(PORTD,D2);	
    bitSet(PORTD,D1);
    
    pulsoEN();
    
        //***********   CONFIGURAÇÃO	***********
    
    lcdCommand(0x01); //limpa o display
    
    lcdCommand(0x2b); //4bits, 2 linhas, 5x8 tamanho
    
    lcdCommand(0x0f); //display on, cursor e blink off
    
    lcdCommand(0b00000110);	// Entry mode set: Increment, Shift OFF
    
    lcdCommand(0b00010100);	// Entry mode set         
       
    lcdCommand(0x80); // Vai para primeira linha
        
}   



