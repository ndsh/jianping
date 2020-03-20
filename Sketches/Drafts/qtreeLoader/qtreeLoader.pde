String[] coordinates;
PGraphics pg;

void setup() {
  size(800, 250);
  pg = createGraphics(3400, 3400);
  pg.beginDraw();
  pg.background(255);
  coordinates = loadStrings("import/file_4.txt");
  String[] split = null;
  println(coordinates.length);
  for(int i = 0; i<coordinates.length; i++) {
    //println(coordinates[i]);
    split = split(coordinates[i], ",");
    
    // 4 + 5
    //pg.point(parseInt(split[4]), parseInt(split[5]));
    pg.rect(parseInt(split[4]), parseInt(split[5]), parseInt(split[2]), parseInt(split[3]));
  }
  pg.endDraw();
  String date = year() +""+ nf(month(), 2) +""+ nf(day(), 2) +""+ nf(hour(), 2) +""+ nf(minute(), 2) +""+ nf(second(), 2);
  pg.save("export/"+date +".jpg");
  
  exit();
}

void draw() {
} 
