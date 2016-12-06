int[] data;
String[] stuff;

void setup() {
  size(200,200);
  // Load text file as a string
  stuff = loadStrings("data.txt");
  // Converte i numeri delimitati da ','
  
}

void draw() {
  background(255);
  stroke(0);
  int j;
  for (j=0; j<stuff.length; j++)
  {
    data = int(split(stuff[j],','));
    for (int i = 0; i < data.length; i++) {
      fill(data[i]);
      rect(i*20,j*20,20,data[i]);
    }
  }
}