#include "serial.h"
#include "pic18f4520.h"
#include "var.h"

unsigned char code, mi, cen, dez, uni;

void serialSend(unsigned char c) {
    while (!bitTst(PIR1, 4)); //Wait register becomes available 
    TXREG = c; //Puts the value to be send 
}

void serialInt(int val) {
    if (val < 0) {
        val = val * (-1);
        serialSend('-');
    }    
    serialSend((val / 1000) % 10 + 48);
    serialSend((val / 100) % 10 + 48);
    serialSend((val / 10) % 10 + 48);
    serialSend((val / 1) % 10 + 48);
}

void serialString(char vector[])
{
	char i = 0;
    
    while(vector[i])
    {
        serialSend(vector[i]);
        i++;
    }
}

unsigned char serialRead(void) {
    char resp = 0;    
    
    if (bitTst(RCSTA, 1)) //Verifica se há erro de overrun e reseta a serial
    {
        bitClr(RCSTA, 4);
        bitSet(RCSTA, 4);
    }

    if (bitTst(PIR1, 5)) //Verifica se existe algum valor disponivel
    {
        resp = RCREG; //retorna o valor
    }
    return resp; //retorna zero
}

void serialInit(void) {
    TXSTA = 0b00101100; //configura a transmissão de dados da serial
    RCSTA = 0b10010000; //configura a recepção de dados da serial
    BAUDCON = 0b00001000; //configura sistema de velocidade da serial
    SPBRGH = 0b00000000; //configura para 56k
    SPBRG = 51; //configura para 56k
    bitSet(TRISC, 6); //pino de recepção de dados
    bitSet(TRISC, 7); //pino de envio de dados
    mi = 0, cen = 0, uni = 0, dez = 0, code = 0;
}

unsigned char serialProtocol(void) {
    int soma;    
    if(code == 0){
        code = serialRead();
        return code;
    }
    
    switch (code){
        case 'T':      
            if(mi == 0){
                mi = serialRead();
            }
            if(cen == 0 && mi!=0){
                cen = serialRead();
            }
            if(dez == 0 && cen!=0 ){
                dez = serialRead();
            }
            if(uni == 0 && dez!=0 ){
                uni = serialRead();                
            }     
            if(uni !=0)
            {   
                soma = (mi-48)*1000 + (cen-48)*100 + (dez-48)*10 + uni-48;
                setTime (soma);
                code = 0;
                uni = 0;
                dez = 0;
                mi = 0;
                cen = 0;
            }
            
        break; 
            
        case 'H':   //Alarm High 0    
            if(mi == 0){
                mi = serialRead();
            }
            if(cen == 0 && mi!=0){
                cen = serialRead();
            }
            if(dez == 0 && cen!=0 ){
                dez = serialRead();
            }
            if(uni == 0 && dez!=0 ){
                uni = serialRead();                 
            }     
            if(uni !=0)
            {   
                soma = (mi-48)*1000 + (cen-48)*100 + (dez-48)*10 + uni-48;
                setAlarmHigh (0, soma);
                code = 0;
                uni = 0;
                dez = 0;
                mi = 0;
                cen = 0;
            }            
        break;
        
        case 'J':    //Alarm High 1   
            if(mi == 0){
                mi = serialRead();
            }
            if(cen == 0 && mi!=0){
                cen = serialRead();
            }
            if(dez == 0 && cen!=0 ){
                dez = serialRead();
            }
            if(uni == 0 && dez!=0 ){
                uni = serialRead();                 
            }     
            if(uni !=0)
            {   
                soma = (mi-48)*1000 + (cen-48)*100 + (dez-48)*10 + uni-48;
                setAlarmHigh (1, soma);
                code = 0;
                uni = 0;
                dez = 0;
                mi = 0;
                cen = 0;
            }            
        break;
            
        case 'L':    //Alarm Low 0  
            if(mi == 0){
                mi = serialRead();
            }
            if(cen == 0 && mi!=0){
                cen = serialRead();
            }
            if(dez == 0 && cen!=0 ){
                dez = serialRead();
            }
            if(uni == 0 && dez!=0 ){
                uni = serialRead();                 
            }     
            if(uni !=0)
            {   
                soma = (mi-48)*1000 + (cen-48)*100 + (dez-48)*10 + uni-48;
                if(soma>=1024){
                    soma = 1023;
                    setAlarmLow (0, soma);
                    serialString("Representação Estourada");
                }                                   
                setAlarmLow (0, soma);
                code = 0;
                uni = 0;
                dez = 0;
                mi = 0;
                cen = 0;
            }     
        break;
        
        case 'K':     //Alarm Low 1
            if(mi == 0){
                mi = serialRead();
            }
            if(cen == 0 && mi!=0){
                cen = serialRead();
            }
            if(dez == 0 && cen!=0 ){
                dez = serialRead();
            }
            if(uni == 0 && dez!=0 ){
                uni = serialRead();                 
            }     
            if(uni !=0)
            {   
                soma = (mi-48)*1000 + (cen-48)*100 + (dez-48)*10 + uni-48;           
                                                
                setAlarmLow (1, soma);
                code = 0;
                uni = 0;
                dez = 0;
                mi = 0;
                cen = 0;
            }     
        break;
        case 'M':
        if(mi == 0){
                mi = serialRead();
            }
            if(cen == 0 && mi!=0){
                cen = serialRead();
            }               
            if(cen !=0)
            {   
                soma = (mi-48)*1000 + (cen-48)*100 + (dez-48)*10 + uni-48;           
                                                
                setAlarmLow (1, soma);
                code = 0;
                uni = 0;
                dez = 0;
                mi = 0;
                cen = 0;
            }     
        case 'I':
            setIdiom(getIdiom() + 1);
            code = 0;
            uni = 0;
            dez = 0;
            cen = 0;
            mi = 0;            
        break;
        
        case 'C':
            code = 0;
            uni = 0;
            dez = 0;
            cen = 0;
            mi = 0;
            
        break;
        
        default: code = 0; 
                 uni = 0;
                 dez = 0;
                 mi = 0;
                 cen = 0;
        break;
    }     
    return code;
}