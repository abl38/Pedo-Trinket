#include <Wire.h>
#include <Adafruit_MMA8451.h>
#include <Adafruit_Sensor.h>

Adafruit_MMA8451 mma = Adafruit_MMA8451();
long previous = 0;
long current = 0;
long testingTime = 0;
long count = 0;
int loopFrequency = 5;
int tempAcc[] = {0,0,0};

void setup(void) {
  Serial.begin(9600);
  
  Serial.println("Adafruit MMA8451 test!");

   previous = micros();
  if (! mma.begin()) {
    Serial.println("Couldnt start");
    while (1);
  }
  Serial.println("MMA8451 found!");
  
  mma.setRange(MMA8451_RANGE_2_G);
  mma.setDataRate(MMA8451_DATARATE_6_25HZ); 
  
  sensors_event_t event;
  mma.getEvent(&event);
  
tempAcc[1] = mma.x;
tempAcc[2] = mma.y;
tempAcc[3] = mma.z;

Serial.write(tempAcc);

}

void loop() {
  
  sensors_event_t event;
  mma.getEvent(&event);
  
tempAcc[1] = mma.x;
tempAcc[2] = mma.y;
tempAcc[3] = mma.z;

Serial.write(tempAcc, 12);
Serial.flush();
delay(1000);
}

