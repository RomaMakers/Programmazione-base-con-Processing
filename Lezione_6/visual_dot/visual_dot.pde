/*
visual_dot.pde
*/

import processing.serial.*;
import javax.swing.JOptionPane; 
import javax.swing.JDialog; 
import java.util.Date;

Serial myPort;        //serial port
String portName;
PrintWriter datos;
 
int largo = 700, alto = 600;
int cFondo = 240; //Colore fondo

int T, H, x;
String vals;
boolean nuovo = false;

Graf g = new Graf(largo, alto, cFondo);

void setup (){
 
  setupSerial(9600);
  
  size(750, 650);
  background(cFondo);

  datos = createWriter("Dati.txt"); 
  fill(0, 0, 240);
  text("Temperatura: ", 20, 16);
  fill(240, 0, 0);
  text("Umidità: ", 20, 40);
  g.griglia();
 
}

void draw(){
  if (myPort == null){
     Date date = new Date();
     String inString = "{\"sensor\":\"DHT11\",\"timeStamp\":\""+ date.toString() + "\",\"data\":[" + String.valueOf(random(0, 50)) + "," + String.valueOf(random(30, 80)) + "]}"; 
     if (inString != null){
        inString = trim(inString);
        decodeJSONObject(inString);
     }
     fill(200, 10, 10);
     text("DEMO", largo / 2, alto - 20);
  }
  else
  {
    fill(10, 10, 10);
    text("Grafico " + portName, largo / 2, alto - 20);
  }
  
  if (nuovo)
  {
    boolean p = true;
    if (x > largo - 60) {
      x = 60;
      g.cancella();
      g.griglia();
      p = false;
    }        
    g.punto(x, T, H, p, vals);
    nuovo = false;
  }

}

void decodeJSONObject(String inString) {
  JSONObject json; 
  
  try {
  json = parseJSONObject(inString);
  }
  catch (Exception e)
  { //Print the type of error
    println("JSONObject could not be parsed");
    return;
  }
  if (json == null) {
    println("JSONObject is NULL");
    return;
  }   
      String timestamp = json.getString("timeStamp");
      String sensor = json.getString("sensor");
      vals = sensor + " : " + timestamp;
     
      if (json.isNull("data")) return;
      JSONArray values = json.getJSONArray("data");
      T = values.getInt(0);
      H = values.getInt(1);
      x = int(g.coordAntX) + 20;
      nuovo = true;
}    

void keyPressed() {//Per uscire
    datos.flush();  
    datos.close();  
    exit();  
}

void serialEvent (Serial myPort) {

  while (myPort.available() > 0) {
    String inBuffer = myPort.readStringUntil(10);
    if (inBuffer.charAt(0)== '{') {
        decodeJSONObject(inBuffer);
        datos.print(inBuffer + "\n"); // salva i ati
      }
    }
}

int setupSerial(int speed) {
  final boolean debug = false;
  String COMx, COMlist = "";

  try {
    if(debug) printArray(Serial.list());
    int i = Serial.list().length;
    if (i != 0) {
      if (i >= 2) {
        // need to check which port the inst uses -
        // for now we'll just let the user decide
        for (int j = 0; j < i;) {
          COMlist += char(j+'a') + " = " + Serial.list()[j];
          if (++j < i) COMlist += ",  ";
        }
        JDialog dialog = new JDialog(); 
        dialog.setAlwaysOnTop(true);
        COMx = JOptionPane.showInputDialog(dialog,"Which COM port is correct? (a,b,...):\n"+COMlist);
        if (COMx == null) return 3;
        if (COMx.isEmpty()) return 4;
        i = int(COMx.toLowerCase().charAt(0) - 'a') + 1;
      }
      portName = Serial.list()[i-1];
      if(debug) println(portName);
      myPort = new Serial(this, portName, speed); // change baud rate to your liking
      myPort.bufferUntil('\n'); // buffer until CR/LF appears, but not required..
      myPort.clear();    // empty buffer(incase of trash) 
    }
    else {
      JOptionPane.showMessageDialog(frame,"Device is not connected to the PC");
      return 1;
    }
  }
  catch (Exception e)
  { //Print the type of error
    JOptionPane.showMessageDialog(frame,"COM port is not available (may\nbe in use by another program)");
    println("Error:", e);
    return 2;
  }
  return 0;
}