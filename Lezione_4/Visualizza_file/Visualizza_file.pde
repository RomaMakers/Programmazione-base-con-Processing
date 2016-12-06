int[] data;

void setup() {
  size(200,200);
  // Load text file as a string
  String[] stuff = loadStrings("data.txt");
  // Converte i numeri delimitati da ','
  data = int(split(stuff[0],','));
}

void draw() {
  background(255);
  stroke(0);
  for (int i = 0; i < data.length; i++) {
    fill(data[i]);
    rect(i*20,0,20,data[i]);
  }
}