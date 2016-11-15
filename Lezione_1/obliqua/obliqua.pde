int x=40; // Pos orizzontale
int y=60; // Pos verticale
/*
Commento
su più
righe
*/

void setup()
{
  size(200, 400); // Area 200 pixel per 200 pixel
}

void draw()
{
 background(154); // sfondo grigio
 /*
 line(x,y,x+50,y-40); //(40,90) - (60,50)
 line(x+50,y-40,x+20+20,y); //(60,50) - (80,90)
 line(x+40,y,x,y); //(80,90) - (40,90)
 */
 triangolo(x,y,40,40);
 triangolo(120,y,60,40);
 triangolo(100,100,50,-40);
 triangolo(x+60,y+140,30,-80);
 x=(x+1)%200;
 y=(y+1)%100;
}

void triangolo(int px, int py, int base, int altezza)
{
   line(px,py,px+base/2,py-altezza); //(40,90) - (60,50)
   line(px+base/2,py-altezza,px+base,py); //(60,50) - (80,90)
   line(px+base,py,px,py); //(80,90) - (40,90)
}