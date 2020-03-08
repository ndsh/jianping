PImage[] images = new PImage[10]; 
IrregularGrid grid;
// Insert draw functions

void setup() {
  size(600, 600);
  for(int i = 0; i<images.length; i++) images[i] = loadImage("pm"+i+".png");
  grid = new IrregularGrid();

  
  
  
}

void draw() {
  background(255);
  grid.display();
}
