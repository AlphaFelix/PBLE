#ifndef RTC_H
	#define RTC_H
 	
    void rtcInit(void);     
    unsigned char BCD2UpperCh(unsigned char bcd);
    unsigned char BCD2LowerCh(unsigned char bcd);   
    void rtcStore(unsigned char address, char val);
    void rtcStoreInt(unsigned char address, int val);    
    char rtcRead(unsigned char address);
    int rtcReadInt(unsigned char address);
    void rtcStart(void);    
    void rtcMin(unsigned char min);
    void rtcHour(unsigned char hour);
    void rtcDay(unsigned char day);
    void rtcDate(unsigned char date);
    void rtcMonth(unsigned char month);
    void rtcYear(unsigned char year);        
    
#endif