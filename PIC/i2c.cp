#line 1 "C:/Users/lutfi yildirim/Desktop/i2c_v4/i2c/i2c.c"
void setupI2c()
{
 I2C2_Init(122222);
}

void sendMultipleDataViaI2c(char address,char length ,char *data_)
{
 char i;
 I2C2_Start();
 I2C2_Write(address<<1);

 for(i=0;i<length;i++)
 {
 I2C2_Write(data_[i] );
 }
 I2C2_Stop();
}

void receiveMultipleDataViaI2c(char address,char length, char *data_)
{
 char i;
 I2C2_Start();
 I2C2_Write(address<<1 | 0x01);
 for(i=0;i<length;i++)
 {
 data_[i] = I2C2_Read(_I2C_ACK);
 }
 I2C2_Stop();
}
