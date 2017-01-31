#ifndef DS1307_H
#define DS1307_H

#include "Arduino.h"

#define RTCRUN 0
#define RTCSTOP 1

class DS1307Class {
public:

  void begin();
  uint8_t write(uint8_t Address, uint8_t dataByte);
  uint8_t read(uint8_t Address);
  uint8_t second();
  uint8_t minute();
  uint8_t hour();
  uint8_t weekday();
  uint8_t day();
  uint8_t month();
  uint8_t year();
  void setTime(uint8_t hr, uint8_t min,uint8_t sec, uint8_t weekday, uint8_t day, uint8_t month, uint8_t yr);
  void set24Hformat();
  void set12Hformat();
  void run(uint8_t state);

private:

};
extern DS1307Class RTC;

#endif
