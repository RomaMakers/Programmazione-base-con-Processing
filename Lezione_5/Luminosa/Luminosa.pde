PImage img;
int mx, my;

void setup() {
  size(512,512);
  img = loadImage("nomefile.jpg");
  mx = 0;
  my = 0;
}

void draw() {
  int dx = mx - mouseX;
  int dy = my - mouseY;
  if (dx < 0) mx+=4;
   else mx-=4;
  if (dy < 0) my+=4;
   else my-=4;
  
  loadPixels(); 
  img.loadPixels();
for (int x = 0; x < img.width; x++) {
  for (int y = 0; y < img.height; y++ ){
    int loc = x + y*img.width;
    float r = red   (img.pixels[loc]);
    float g = green (img.pixels[loc]);
    float b = blue  (img.pixels[loc]);
    float distance=dist(x,y,mx,my);
    float adjustBrightness=(50-distance)/50;  
    r *= adjustBrightness;
    g *= adjustBrightness;
    b *= adjustBrightness;
    r = constrain(r,0,255);
    g = constrain(g,0,255);
    b = constrain(b,0,255);
    color c = color(r,g,b);
    pixels[loc] = c;
  }
} 
updatePixels(); 
}