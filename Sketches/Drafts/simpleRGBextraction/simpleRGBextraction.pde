PImage p;
void setup() {
  p = loadImage("4.jpg");
  p.loadPixels();
  color c = p.pixels[0];
  println("red= " + red(c));
  println("green= " + green(c));
  println("blue= " + blue(c));
}

void draw() {
}
