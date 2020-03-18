class IrregularGrid {
  // Initialize
  
  int tileWidth = pg.width;
  int tileHeight = pg.height;

  IrregularGrid() {
    for (int x = 0; x < (pg.width/tileWidth); x++) {
      for (int y = 0; y < (pg.height/tileHeight); y++) {
        int randomIndex = (int)random(10);
        points.add( new Node(x*tileWidth, y*tileHeight, tileWidth, tileHeight, randomIndex, 0) );
        //println(x + " " + y);
      }
    }
    println("maxDepth=" + maxDepth);
  }
  
  void display() {
    
    //for(int i = 0; i<points.size(); i++) points.get(i).display();
    int upperLimit = points.size()-1;
    for(int i = depthStep; i>0; i--) points.get(i).display();
    depthStep++;
    //println(depthStep);
    if(depthStep >= upperLimit) depthStep = 0;
  }
  
  void randomlySubdivideGridPoints() {
    ArrayList<Node> newPoints = new ArrayList<Node>();
      
      for(int i = 0; i<points.size(); i++) {
        //print(i + " ");
        Node n = points.get(i);
        //for (GridPoint p : points) {
        if (random(1) > 0.5) {
          if(n.tileWidth > 2) n.subdivide(newPoints);
          
          //if (random(1) > 0.5) points.remove(i);
        } else {
          newPoints.add(n);
        }
      }
    points = newPoints;
    //println("size=" + points.size());
  }
  
  void subdivideContextually() {
    ArrayList<Node> newPoints = new ArrayList<Node>();
    int o = 0;
    for(int i = 0; i<points.size(); i++) {
      Node n = points.get(i);
      color c = n.colorFromImage();
      float b = saturation(c);
      float control = saturation(baseColor);
      if(b-control > tolerance) n.subdivide(newPoints); 
      else {
        newPoints.add(n);
      }
      
    }
    points = newPoints;
  }
  
  void subdivideMeasured() {
    ArrayList<Node> newPoints = new ArrayList<Node>();
    // wir haben einen "node"
    // wir teilen diesen point in n-teile auf (z.B. 2 oder 4)
    // wir geben uns die durchschnittsfarbe von allen nodes wieder
    // unterscheidet sich diese
    
    int o = 0;
    for(int i = 0; i<points.size(); i++) {
      Node n = points.get(i);
      color c = n.colorFromImage();
      float b = saturation(c);
      float control = saturation(baseColor);
      //if(b-control > tolerance) p.subdivide(newPoints); 
      //else {
        //newPoints.add(p);
      //}
      int measure = measureDetail(target, (int)n.x, (int)n.y, (int)n.tileWidth, (int)n.tileHeight);
      
      if (measure < threshold) {//too little detail
        //color a = average(grid, x, y, width, height);
        newPoints.add(n);
      } else {
        n.subdivide(newPoints);
      }
      
    }
    points = newPoints;
  }
  
  void subdivideNodes() {
    if(depth < maxDepth) {
      //int randomIndex = (int)random(10);
      //points.add( new Node(x*tileWidth, y*tileHeight, tileWidth, tileHeight, randomIndex, depth) );
      // 0
      // 0, 1, 2, 3
      // 0, 1, 2, 3, 4, 5, 6, 7
      //println(points.size());
      for(int i = 0; i<points.size(); i++) {
        Node n = points.get(i);
        
      }
      depthStep++;
      if(depthStep > points.size()) {
        depth++;
        depthStep = 0;
      }
    }
  }
  
  
}
