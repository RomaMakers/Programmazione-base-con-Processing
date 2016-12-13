
PImage img;

void setup() {
  size(512,512);
  img = loadImage("nomefile.jpg");
  background(0);
  smooth();
}

int pointillize = 16;

void draw() {
  // Pick a random point
  int x = constrain(mouseX + int(random(50)) - 25, 0, img.width - 1);
  int y = constrain(mouseY + int(random(50)) - 25, 0, img.height - 1);
  
  int loc = x + y * img.width;
  
  // Look up the RGB color in the source image
  loadPixels();
  float r = red(img.pixels[loc]);
  float g = green(img.pixels[loc]);
  float b = blue(img.pixels[loc]);
  noStroke();
  
  // Draw an ellipse at that location with that color
  fill(r,g,b,80);
  ellipse(x,y,pointillize,pointillize);
}