size(512,512);
PImage img;
img = loadImage("nomefile.jpg");
image(img,0,0);

//elabora i pixel

loadPixels();

for (int i = 0; i < width*height; i++) {

pixels[i] = color(200,20,30);

}

updatePixels();