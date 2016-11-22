//variabili globali
float x;
float y;
float x_punt;
float y_punt;
float accelerazione = 0.05;
int diametro=50;

//inizializzazione
void setup()
{
  size(400,400);
  smooth();
  noStroke();
  fill(20,100,150);
  frameRate(30);
}

//disegno
void draw()
{
  background(0);
//assegnazione delle coordinate del puntatore
  x_punt=mouseX;
  y_punt=mouseY;
//calcolo delle coordinate della distanza tra il puntatore e il cerchio
  float dx=x_punt - x;
  float dy=y_punt - y;
//calcolo dell’incremento delle coordinate del cerchio
  x+=dx*accelerazione;
  y+=dy*accelerazione;
  ellipse(x,y,diametro,diametro);
}