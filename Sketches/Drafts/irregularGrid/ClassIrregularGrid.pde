class IrregularGrid {
  // Initialize
  ArrayList<GridPoint> points = new ArrayList<GridPoint>();
  int tileWidth = 100;
  int tileHeight = 100;

  IrregularGrid() {
    for (int x = 0; x < (width/tileWidth); x++) {
      for (int y = 0; y < (height/tileHeight); y++) {
        int randomIndex = (int)random(10);
        points.add( new GridPoint(x*tileWidth, y*tileHeight, tileWidth, tileHeight, randomIndex) );
        //println(x + " " + y);
      }
    }

    
  }
  
  void display() {
    for(int i = 0; i<points.size(); i++) points.get(i).display();
  }
  
  void randomlySubdivideGridPoints() {
    ArrayList<GridPoint> newPoints = new ArrayList<GridPoint>();
      
      for(int i = 0; i<points.size(); i++) {
        GridPoint p = points.get(i);
      //for (GridPoint p : points) {
        if (random(1) > 0.2) {
          p.subdivide(newPoints);
          if (random(1) > 0.5) points.remove(i);
        } else {
          newPoints.add(p);
        }
      }
    points = newPoints;
  }
}
