
#include <Stream.h>
#include <ArduinoJson.h>
#include "DHT11.h"
#include "DS1307.h"
#include <Wire.h> 
#include <LiquidCrystal_I2C.h>

LiquidCrystal_I2C lcd(0x27,16,2);  // set the LCD address to 0x27 for a 16 chars and 2 line display

dht11 DHT11;
#define DHT11PIN 5
#define LED 13


void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);              // initialize serial port
  lcd.init();                      // initialize the lcd
  RTC.begin();                     // initialize the RTC

  int weekday = 7; // Weekeday (1=Sunday, 7=Saturday)
  int day   = 12;
  int month = 01;
  int year  = 17;
  int hour  = 19;
  int min   = 07;
  int sec   = 00;
  // Set time
  RTC.set24Hformat();
  //RTC.setTime( hour, min, sec, weekday, day, month, year );  // Set Time and Date (if needed)
  RTC.run(RTCRUN);  // Start RTC

  // Print a message to the LCD.
  lcd.backlight();
  lcd.print("Temp/Humid JSON");
  lcd.setCursor(0,1);
  lcd.print("with DHT11");
  lcd.clear();

}

void loop() {
  // put your main code here, to run repeatedly:

  int chk;
  int Temperature;
  int Humidity;

  // Memory pool for JSON object tree.
  //
  // Inside the brackets, 200 is the size of the pool in bytes.
  // If the JSON object is more complex, you need to increase that value.
  StaticJsonBuffer<200> jsonBuffer;

  // Create the root of the object tree.
  //
  // It's a reference to the JsonObject, the actual bytes are inside the
  // JsonBuffer with all the other nodes of the object tree.
  // Memory is freed when jsonBuffer goes out of scope.
  JsonObject& root = jsonBuffer.createObject();

  // Add values in the object
  //
  // Most of the time, you can rely on the implicit casts.
  // In other case, you can do root.set<long>("time", 1351824120);
  String TimeStamp = "";
  TimeStamp = TimeStamp + "20"+String(RTC.year())+"-"+String(RTC.month())+"-"+String(RTC.day())+", ";
  TimeStamp = TimeStamp + String(RTC.hour())+":"+String(RTC.minute())+":"+String(RTC.second());
  root["sensor"] = "DHT11";
  root["timeStamp"] = TimeStamp;

  // Acquisizione temperatura e umidità
  chk = DHT11.read(DHT11PIN);
  if (chk == DHTLIB_OK)
  {
    Temperature = DHT11.temperature;
    Humidity = DHT11.humidity;
    /*
    Serial.print("T=");
    Serial.println(Temperature);
    Serial.print("H=");
    Serial.println(Humidity);
    */
    
    // Add a nested array.
    //
    // It's also possible to create the array separately and add it to the
    // JsonObject but it's less efficient.
    JsonArray& data = root.createNestedArray("data");
    data.add(Temperature);
    data.add(Humidity);
    root.printTo(Serial);
    Serial.println();
  }  

  // Update Display
  lcd.setCursor(0,0);
  lcd.print(TimeStamp);
  lcd.setCursor(0,1);
  lcd.print(Temperature);
  lcd.print(" ");
  lcd.print(char(0xDF));
  lcd.print("C ");
  lcd.print(Humidity);
  lcd.print("%");
  delay(2000);
  
}
