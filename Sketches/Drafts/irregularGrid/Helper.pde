
void keyPressed() {
  if (keyCode == RIGHT) {
    grid.randomlySubdivideGridPoints();
  } else if(keyCode == LEFT) {
    grid = new IrregularGrid();
  }
}
