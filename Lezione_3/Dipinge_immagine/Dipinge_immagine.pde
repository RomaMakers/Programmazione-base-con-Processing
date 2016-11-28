size(512,512);
PImage img;
img = loadImage("nomefile.jpg");
image(img,0,0);

//elabora i pixel

loadPixels(); // Carica il buffer dalla finestra visualizzata

for (int i = 0; i < width*height/2; i++) // Mezza immagine
{

  pixels[i] = color(200,20,30); // Modifica il buffer

}
updatePixels(); // Aggiorna l'immagine

//PImage striscia = get(0, 0, width/2, height);
//image(striscia, width/2, 0);
//striscia.save("modifica.png");