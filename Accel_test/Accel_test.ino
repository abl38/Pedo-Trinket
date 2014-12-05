/**************************************************************************/
/*!
    @file     Adafruit_MMA8451.h
    @author   K. Townsend (Adafruit Industries)
    @license  BSD (see license.txt)

    This is an example for the Adafruit MMA8451 Accel breakout board
    ----> https://www.adafruit.com/products/2019

    Adafruit invests time and resources providing this open source code,
    please support Adafruit and open-source hardware by purchasing
    products from Adafruit!

    @section  HISTORY

    v1.0  - First release
*/
/**************************************************************************/

#include <Wire.h>
#include <Adafruit_MMA8451.h>
#include <Adafruit_Sensor.h>

Adafruit_MMA8451 mma = Adafruit_MMA8451();

int loopFrequency = 50; //Hz
int tempAcc[] = {0,0,0};

void setup(void) {
  Serial.begin(9600);
  
  Serial.println("Adafruit MMA8451 test!");


  if (! mma.begin()) {
    Serial.println("Couldnt start");
    while (1);
  }
  Serial.println("MMA8451 found!");
  
  mma.setRange(MMA8451_RANGE_2_G);
  mma.setDataRate(MMA8451_DATARATE_100_HZ); 

}



void loop() {
  
  mma.read();
  /* Display the results (acceleration is measured in m/s^2) */
  Serial.print(micros());Serial.print(","); Serial.print(mma.x); 
  Serial.print(","); Serial.print(mma.y); 
  Serial.print(","); Serial.println(mma.z); 
  
tempAcc[1] = mma.x;
tempAcc[2] = mma.y;
tempAcc[3] = mma.z;

  //Serial.print("Oneloop: "); 
  //Serial.println(current - previous);
  
  //} 
   
}

/*
void sendData(long tick, float x, float y, float z) {
  float[] tempAcc =  [x,y,z];
 int  tempSize = sizeof(tempAcc);
 Serial.write(tick);
 Serial.flush();
 Serial.write(tempAcc, tempSize);
 Serial.flush();
}
*/
  
