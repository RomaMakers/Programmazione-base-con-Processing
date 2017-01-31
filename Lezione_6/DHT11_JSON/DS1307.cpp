/*
 * @file DS1307.cpp
 * @brief Provide Arduino basic driver library for RTC DS1307
 * @description Library for RTC DS1307
 * @author Devboards.it
 * @version 1.0
 * @licence MIT
 * @date 2017-01-07
 *
┌──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│                                                   TERMS OF USE: MIT License                                                  │
├──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
│Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation    │
│files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy,    │
│modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software│
│is furnished to do so, subject to the following conditions:                                                                   │
│                                                                                                                              │
│The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.│
│                                                                                                                              │
│THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE          │
│WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR         │
│COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,   │
│ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.                         │
└──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘/

*/

#include "DS1307.h"
#include <Wire.h>

//#define ASCL 28          // EQU to Arduino PIN A5
//#define ASDA 29          // EQU to Arduino PIN A4
#define LOW 0
#define HIGH 1
#define INPUT 0
#define OUTPUT 1

DS1307Class RTC;

void DS1307Class::begin()
{
   Wire.begin();
}
uint8_t DS1307Class::read(uint8_t Address)
{
   Wire.beginTransmission(0x68);
   Wire.write(Address);              // Send Address
   Wire.endTransmission();

   Wire.requestFrom(0x68,1);
   return Wire.read();
   //Wire.endTransmission();
}
uint8_t DS1307Class::write(uint8_t Address, uint8_t dataByte)
{
   Wire.beginTransmission(0x68);
   Wire.write(Address);              // Send Address
   Wire.write(dataByte);             // Send Data
   Wire.endTransmission();
}
uint8_t DS1307Class::second()
{
   uint8_t reg;
   reg = read(0x00);                       // Read address 0x00
   return (((reg>>4)&7)*10)+(reg&0x0F);    // Convert BCD->DEC
}
uint8_t DS1307Class::minute()
{
   uint8_t reg;
   reg = read(0x01);                       // Read address 0x01
   return (((reg>>4)&7)*10)+(reg&0x0F);    // Convert BCD->DEC
}
uint8_t DS1307Class::hour()
{
   uint8_t reg;
   reg = read(0x02);                       // Read address 0x02
   return (((reg>>4)&7)*10)+(reg&0x0F);    // Convert BCD->DEC
}
uint8_t DS1307Class::weekday()
{
   uint8_t reg;
   reg = read(0x03);                       // Read address 0x03
   return (reg&0x07);                      // Convert BCD->DEC
}
uint8_t DS1307Class::day()
{
   uint8_t reg;
   reg = read(0x04);                       // Read address 0x04
   return (((reg>>4)&3)*10)+(reg&0x0F);    // Convert BCD->DEC
}
uint8_t DS1307Class::month()
{
   uint8_t reg;
   reg = read(0x05);                       // Read address 0x05
   return (((reg>>4)&1)*10)+(reg&0x0F);    // Convert BCD->DEC
}
uint8_t DS1307Class::year()
{
   uint8_t reg;
   reg = read(0x06);                       // Read address 0x06
   return (((reg>>4)&7)*10)+(reg&0x0F);    // Convert BCD->DEC
}
void DS1307Class::setTime(uint8_t hr, uint8_t min, uint8_t sec, uint8_t weekday, uint8_t day, uint8_t month, uint8_t yr)
{
   write(0x00, 0x80);                                                    // Halt the RTC (bit <7>, reg 0x00)
   write(0x01, ((min/10)<<4) | (min-((min/10)*10)));                     // Set minutes
   write(0x02, ((read(0x02)&0xC0) | ((hr/10)<<4) | (hr-((hr/10)*10))));  // Set hours
   write(0x03, weekday);                                                 // Weekeday (1=Sunday, 7=Saturday)
   write(0x04, ((day/10)<<4) | (day-((day/10)*10)&0x0F));               // Set day
   write(0x05, ((month/10)<<4) | (month-((month/10)*10)&0x0F));         // Set month
   write(0x06, ((yr/10)<<4) | ((yr-((yr/10)*10))&0x0F));                 // Set year
   write(0x00, (((sec/10)<<4) | (sec-((sec/10)*10))) & 0x7F);            // Set seconds and free the RTC
}
void DS1307Class::set24Hformat()
{
  write(0x02, read(0x02)&0xBF);
}
void DS1307Class::set12Hformat()
{
  write(0x02, read(0x02)|0x40);
}
void DS1307Class::run(uint8_t state)
{
  write(0x00, ((read(0x00)&0x7F) | (state << 7)));  // Set CH bit  (0=run, 1=stop)
}
