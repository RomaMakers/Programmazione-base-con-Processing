// Importiamo la libreria seriale (già inclusa nell'IDE Arduino)
import processing.serial.*;
// Creiamo l'oggetto porta seriale
Serial port; 
// Dato ricevuto dalla porta seriale
int val; 
// Array per contenere i dati
int[] values;
void setup() 
{
    size(640, 480);
  // Attiviamo una comunicazione seriale, alla velocità di 9600 bps
  // NB: è importante verificare su quale porta si utilizza Arduino!
  port = new Serial(this, Serial.list()[32], 9600);
  // Inizializziamo l'array di interi che conterrà i dati
  values = new int[width];
  // Questo comando prepara l'anti-aliasing per la grafica
  smooth();
}


void draw()
{
  // Se vengono trasmessi almeno 4 bytes sulla seriale...
  while (port.available() >= 3) 
  {
    // ... e se leggo il valore massimo
    if (port.read() == 0xff) 
    {
      // ... salvo la differenza con il valore seriale
      val = (port.read() << 8) | (port.read());
    }
  }


// Per ogni elemento dell'array...
  for (int i=0; i<width-1; i++)
  {
    // ... sposto i valori salvati di una posizione
    values[i] = values[i+1];
  }
  // ... e aggiungo il valore appena letto
  values[width-1] = val;
  // Imposto il colore di sfondo a nero
  background(0);
  // Imposto il colore del disegno a bianco
  stroke(255);
  // Per ogni elemento dell'array...
  for (int x=1; x<width; x++) 
  {
    // ... disegno una linea:
    // dalle coordinate del punto precedente...
    line(width-x, height-1-getY(values[x-1]), 
    // ... alle coordinate del punto attuale
    width-x-1, height-1-getY(values[x]));
  }
}


int getY(int val) {
  // Restituisce l'altezza, in base al valore passato
  return (int)(val / 1023.0f * height) - 1;
}