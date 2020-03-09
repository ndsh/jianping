PImage[] images = new PImage[10]; 
IrregularGrid grid;
// Insert draw functions

void setup() {
  size(1000, 1000);
  for(int i = 0; i<images.length; i++) images[i] = loadImage("pm"+i+".png");
  grid = new IrregularGrid();

  
  
  
}

void draw() {
  background(255);
  grid.display();
}
