/*
Graf.pde
*/

class Graf {

  int nX, nY, colF;
  float coordAntX, coordAnt1, coordAnt2;
  
  Graf (int x, int y, int cF){
    nX = x;
    nY = y; 
    colF  = cF;
    
    coordAntX = nX;
  }
  
  void griglia(){
    stroke(0);   
    for (int  j = 60 ; j <= nX - 60; j = j + 20){
      line (j, 60, j, nY - 60);      } // Vert
    for (int  j = 60 ; j <= nY - 60; j = j + 20){
      line (60, j, nX - 60, j);} // Oriz
 
  }
  
  void cancella(){
    fill(colF); // Colore del fondo
    noStroke();
    rectMode(CORNERS);
    rect(50 , 50, nX , nY - 30 ); 
  }
  
  void punto(int x, float nValor1, float nValor2, boolean linea, String ts){
      
      fill(255,255,255);
      rectMode(CORNERS); 
      rect(140,25,200,45);
      rect(140,2,200,21);
      rect(230,2,430,21);
      fill (5,200,5);
      text(ts, 240, 16);

      fill (0,0,250);
      text(nValor1, 142, 16);
      float v = map(nValor1, 0, 100, nY - 60, 60); //Map 0..100 margini sup e inf.    
      ellipse(x, v, 5, 5);
      //Unnisce i punti con una linea
      if (linea == true){ 
        line (coordAntX, coordAnt1, x, v);
      }
      coordAnt1 = v;          
 
      fill (250,0,0);
      text(nValor2, 142, 40);
      v = map(nValor2, 0, 100, nY - 60, 60); //Map 0..100 margini sup e inf.    
      ellipse(x, v, 5, 5);
      //Unnisce i punti con una linea
      if (linea == true){ 
        line (coordAntX, coordAnt2, x, v);
      }
      coordAnt2 = v;
      coordAntX = x;

  }

}