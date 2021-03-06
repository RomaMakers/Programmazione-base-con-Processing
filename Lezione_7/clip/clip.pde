import processing.video.*;
Movie myMovie;

void setup() {
  //size(401, 225);
  fullScreen();
  frameRate(25);
  myMovie = new Movie(this, "clip1.mpg");
  myMovie.loop();
}

void draw() {
  image(myMovie, 0, 0, width, height);
}

void movieEvent(Movie m) {
  m.read();
}

void mousePressed() {
  myMovie.noLoop();
  myMovie.pause();
}

void mouseReleased() {
  myMovie.play();
}