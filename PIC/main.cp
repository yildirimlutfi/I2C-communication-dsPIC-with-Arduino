#line 1 "C:/Users/lutfi yildirim/Desktop/i2c_v4/i2c/main.c"
#line 1 "c:/users/lutfi yildirim/desktop/i2c_v4/i2c/i2c.h"
void setupI2c();
void sendMultipleDataViaI2c(char address,char length ,char *data_);
void receiveMultipleDataViaI2c(char address,char length ,char *data_);
#line 1 "c:/users/lutfi yildirim/desktop/i2c_v4/i2c/timer.h"
void Timer1Interrupt(void);
void setupTimer();
unsigned long millis(void);
#line 3 "C:/Users/lutfi yildirim/Desktop/i2c_v4/i2c/main.c"
unsigned char I2C_writeData[32];
unsigned char I2C_readData[32];
unsigned int addressArduino = 0x08;
void main()
{
 char i;
 setupTimer();
 setupI2c();

 while(1)
 {
 for(i=0;i<32;i++)
 I2C_writeData[i]=rand();

 sendMultipleDataViaI2c(addressArduino,20,I2C_writeData);
 Delay_ms(1);
 receiveMultipleDataViaI2c(addressArduino,20,I2C_readData);
 Delay_ms(1);
 }
}
