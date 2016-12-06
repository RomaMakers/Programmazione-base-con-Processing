// Stampa il testo contenuto nel file.
String[] lines = loadStrings("file.txt");
println("there are " + lines.length + " lines");
int i;
for (i = 0; i < lines.length; i++)
  println(lines[i]);
//println(lines[1]);
//println(lines[2]);
//println(lines[3]);