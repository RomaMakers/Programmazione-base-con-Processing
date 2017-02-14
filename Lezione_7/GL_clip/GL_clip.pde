import gohai.glvideo.*;
GLMovie myMovie;

void setup() {
  size(401, 225);
  //fullScreen();
  frameRate(25);
  myMovie = new GLMovie(this, "clip1.mpg");
  myMovie.loop();
}

void draw() {
  image(myMovie, 0, 0, width, height);
}

void movieEvent(GLMovie m) {
  m.read();
}

void mousePressed() {
  myMovie.noLoop();
  myMovie.pause();
}

void mouseReleased() {
  myMovie.play();
}