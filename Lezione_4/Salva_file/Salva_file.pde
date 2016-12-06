PrintWriter output;
int oldX, oldY;
void setup() {
  size(400,400);
  // Create a new file in the sketch directory
  output = createWriter("positions.txt"); 
  oldX=0;
  oldY=0;
  rectMode(CORNERS);
  
}

void draw() {
  
  //if((mouseX != oldX) || (mouseY != oldY))
  //{
////    point(mouseX, mouseY);
  //  output.print(mouseX);  // Write the coordinate to the file
  //  output.print(",");
  //  output.println(mouseY);  // Write the coordinate to the file
  //  //oldX=mouseX;
  //  //oldY=mouseY;
  //}
}

void mousePressed() {
  fill((9*mouseX)%255,(5*mouseY)%255,random(255));
  rect(mouseX,mouseY,oldX,oldY);
  oldX=mouseX;
  oldY=mouseY;
  output.print(mouseX);  // Write the coordinate to the file
  output.print(",");
  output.println(mouseY);  // Write the coordinate to the file

}
void keyPressed() {
  output.flush();  // Writes the remaining data to the file
  output.close();  // Finishes the file
  exit();  // Stops the program
}