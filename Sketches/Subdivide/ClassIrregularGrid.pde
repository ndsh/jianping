class IrregularGrid {
  // Initialize
  ArrayList<GridPoint> points = new ArrayList<GridPoint>();
  int tileWidth = pg.width;
  int tileHeight = pg.height;

  IrregularGrid() {
    for (int x = 0; x < (pg.width/tileWidth); x++) {
      for (int y = 0; y < (pg.height/tileHeight); y++) {
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
        //print(i + " ");
        GridPoint p = points.get(i);
        //for (GridPoint p : points) {
        if (random(1) > 0.5) {
          if(p.tileWidth > 2) p.subdivide(newPoints);
          
          //if (random(1) > 0.5) points.remove(i);
        } else {
          newPoints.add(p);
        }
      }
    points = newPoints;
    //println("size=" + points.size());
  }
  
  void subdivideContextually() {
    ArrayList<GridPoint> newPoints = new ArrayList<GridPoint>();
    int o = 0;
    for(int i = 0; i<points.size(); i++) {
      GridPoint p = points.get(i);
      color c = p.colorFromImage();
      float b = saturation(c);
      float control = saturation(baseColor);
      if(b-control > tolerance) p.subdivide(newPoints); 
      else {
        newPoints.add(p);
      }
      
    }
    points = newPoints;
  }
  
  void subdivideMeasured() {
    ArrayList<GridPoint> newPoints = new ArrayList<GridPoint>();
    // wir haben einen "node"
    // wir teilen diesen point in n-teile auf (z.B. 2 oder 4)
    // wir geben uns die durchschnittsfarbe von allen nodes wieder
    // unterscheidet sich diese
    
    int o = 0;
    for(int i = 0; i<points.size(); i++) {
      GridPoint p = points.get(i);
      color c = p.colorFromImage();
      float b = saturation(c);
      float control = saturation(baseColor);
      //if(b-control > tolerance) p.subdivide(newPoints); 
      //else {
        //newPoints.add(p);
      //}
      int measure = measureDetail(target, (int)p.x, (int)p.y, (int)p.tileWidth, (int)p.tileHeight);
      println(measure);
      if (measure < threshold) {//too little detail
        //color a = average(grid, x, y, width, height);
        newPoints.add(p);
      } else {
        p.subdivide(newPoints);
      }
      
    }
    points = newPoints;
  }
  
  
}
