void setup() {
  size(700, 500);
}
          
void draw() {
  background(255);
  translate(width/2, height/2); 
  
  pushMatrix(); 
  translate( sin(frameCount*.01)*300, 0);
  rotate( sin(frameCount*.1) );
  rect(40,30,10,20);
  popMatrix();
  
  pushMatrix();
  rotate( sin(frameCount*.1) );
  translate( sin(frameCount*.01)*300, 0 );
  rect(40,30,10,20);
   popMatrix();
              
  rect(40,30,10,20);
}