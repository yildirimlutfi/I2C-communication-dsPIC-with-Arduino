// Wire Slave Receiver
// by Nicholas Zambetti <http://www.zambetti.com>

// Demonstrates use of the Wire library
// Receives data as an I2C/TWI slave device
// Refer to the "Wire Master Writer" example for use with this

// Created 29 March 2006

// This example code is in the public domain.


#include <Wire.h>
byte buffer[20];
int i;

void setup() {
  Wire.begin(8);                // join I2C bus with address #8
  Wire.onReceive(receiveEvent); // register event
  Wire.onRequest(requestEvent); // register event
  Serial.begin(115200);           // start serial for output
}

void loop() {
  delay(100);
}

// function that executes whenever data is requested by master
// this function is registered as an event, see setup()
void requestEvent() {
  int temp;
  Serial.print("Write: ");
  for(i=0;i<20;i++)
  {
    temp=random(255);
    Wire.write(temp);
    Serial.print(temp); 
    Serial.print("-");
  }
  Serial.println();
}

void receiveEvent(int howMany) {
  Wire.readBytes( buffer, 20);  // use a bug, read 6 when there are only 5 !
  Serial.print("Read: ");
  for(i=0;i<20;i++)
  {
    Serial.print(buffer[i]); 
    Serial.print("-");
  }
  Serial.println();
}
