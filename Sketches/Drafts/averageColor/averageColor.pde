PImage p;

void setup() {
  p = loadImage("image.jpg");
  size(20, 30);
  surface.setLocation(0, 0);
  surface.setSize(p.width, p.height);
  rectMode(CENTER);
  noFill();
}

void draw() {
  image(p, 0, 0);
  rect(mouseX, mouseY, 20, 20);
  color avg = averageColor(p, mouseX, mouseY, 10, 10);
  push();
  fill(avg);
  rect(20, 20, 20, 20);
  pop();
}

color averageColor(PImage source, int x, int y, int w, int h) {
  PImage temp = source.get(x, y, w, h);
  temp.loadPixels();
  int r = 0;
  int g = 0;
  int b = 0;
  
  for (int i=0; i<temp.pixels.length; i++) {
    color c = temp.pixels[i];
    r += c>>16&0xFF;
    g += c>>8&0xFF;
    b += c&0xFF;
  }
  r /= temp.pixels.length;
  g /= temp.pixels.length;
  b /= temp.pixels.length;
 
  return color(r, g, b);
}
