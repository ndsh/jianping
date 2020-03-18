
void keyPressed() {
  if (keyCode == RIGHT) {
    //grid.randomlySubdivideGridPoints();
    //grid.subdivideContextually();
    //grid.subdivideMeasured();
    //grid.subdivideNodes();
  } else if(keyCode == LEFT) {
    //grid = new IrregularGrid();
  } else if(keyCode == UP) {
    if(maxDepth < 8) maxDepth++;
    points = new ArrayList<Node>();
    grid = new IrregularGrid();
    depthStep = 0;
    
  } else if(keyCode == DOWN) {
    if(maxDepth >= 0) maxDepth--;
    points = new ArrayList<Node>();
    grid = new IrregularGrid();
    depthStep = 0;
    
  }
}

color averageColor(PImage source, int x, int y, int w, int h) {
  PImage temp = source.get(x, y, w, h);
  temp.loadPixels();
  int redSum = 0;
  int greenSum = 0;
  int blueSum = 0;
  
  for (int i=0; i<temp.pixels.length; i++) {
    color c = temp.pixels[i];
    redSum += c>>16&0xFF;
    greenSum += c>>8&0xFF;
    blueSum += c&0xFF;
  }
  //redSum /= temp.pixels.length;
  //greenSum /= temp.pixels.length;
  //blueSum /= temp.pixels.length;
  
  //number of pixels evaluated
  int area = w * h;
  
  //return color(redSum, greenSum, blueSum);
  return color(redSum / area, greenSum / area, blueSum / area);
}

// Calculates the average color of a rectangular region of a grid
/*
color average(Grid grid, int x, int y, int w, int h) {
  int redSum = 0;
  int greenSum = 0;
  int blueSum = 0;

  //Adds the color values for each channel.
  for(int i = 0; i < x + w; i++) {
    for(int j = 0; j < y + h; j++) {
      color c = grid.get(i, j);
      redSum += c>>16&0xFF;
      greenSum += c>>8&0xFF;
      blueSum += c&0xFF;
    }
  }

  //number of pixels evaluated
  int area = w * h;

  // Returns the color that represent the average.
  return color(redSum / area, greenSum / area, blueSum / area);
}
*/
// Measures the amount of detail of a rectangular region of a grid
color measureDetail(PImage source, int x, int y, int w, int h) {
  
  color averageColor = averageColor(source, x, y, w, h);
  int red = averageColor>>16&0xFF;
  int green = averageColor>>8&0xFF;
  int blue = averageColor&0xFF;
  int colorSum = 0;

  // Calculates the distance between every pixel in the region
  // and the average color. The Manhattan distance is used, and
  // all the distances are added.
  for(int i = 0; i < x + w; i++) {
    for(int j = 0; j < y + h; j++) {
      color cellColor = source.get(i, j);
      colorSum += abs (red - cellColor>>16&0xFF);
      colorSum += abs(green - cellColor>>8&0xFF);
      colorSum += abs (blue - cellColor&0xFF);
    }
  }

  // Calculates the average distance, and returns the result.
  // We divide by three, because we are averaging over 3 channels.
  int area = w * h;
  return colorSum / (3 * area);
}
