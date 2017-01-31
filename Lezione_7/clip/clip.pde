import processing.video.*;
Movie myMovie;

void setup() {
  size(401, 225);
  frameRate(25);
  myMovie = new Movie(this, "clip2.mpg");
  myMovie.loop();
}

void draw() {
  image(myMovie, 0, 0);
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