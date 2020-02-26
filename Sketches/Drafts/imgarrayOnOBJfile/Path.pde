class Path {
  ArrayList<PVector> path = new ArrayList<PVector>();

  PShape s;

  float ry;
  int vcount;
  int current = 0;

  int totalVertices = 0;
  int vertAvg = 0;
  int childShapes = 0;

  Path(String _s) {
    s = loadShape(_s);
    println("rocket.getChild(0).getVertex(0):\n  ", s.getChild(0).getVertex(0), "\n");
    //// get summary counts
    vcount = getChildrenVertexCount(s);
    fillListChildVertices(s);
  }

  void step() {
    current++;
    if (current >= totalVertices/vertAvg) current = 0;
  }

  void update() {
    step();
  }

  void display() {
    push();
      //translate(width/2, height/2);
      push();
        translate(path.get(current).x, path.get(current).y, path.get(current).z);
        sphere(2);
      pop();
    pop();
  }
  
  void show3D() {
    push();
    //translate(width/2, height/2);
    s.scale(scalePath);
    shape(s, 0, 0);
    pop();
  }
  
  PVector getPosition(int _current) {
    return path.get(_current);
  }
  
  int getTotalVertices() {
    return totalVertices;
  }
  
  int getTotalChildShapes() {
    return childShapes;
  }
  
  void scale(float f) {
    for(int i = 0; i<path.size(); i++) {
      path.get(i) .mult(f);
    }
  }

  void printChildVertices(PShape shape) {

    for (int i=0; i<shape.getChildCount(); i++) {
      PShape child = shape.getChild(i);
      for (int j=0; j<child.getVertexCount(); j++) {
        PVector vert = child.getVertex(j);
        println(vert);
      }
    }
    println("");
  }

  void plotChildVertices(PShape shape) {

    for (int i=0; i<shape.getChildCount(); i++) {
      PShape child = shape.getChild(i);
      for (int j=0; j<child.getVertexCount(); j++) {
        
        PVector vert = new PVector(child.getVertex(j).x, child.getVertex(j).y, child.getVertex(j).z);
        //println(vert);
        point(vert.x, vert.y, vert.z);
      }
    }
    //println("");
  }

  void fillListChildVertices(PShape shape) {
    PVector previous = null;
    
    for (int i=0; i<shape.getChildCount(); i++) {
      PShape child = shape.getChild(i);
      for (int j=0; j<child.getVertexCount(); j++) {
        PVector vert = null;
        if (j % vertAvg == 0) {
          vert = child.getVertex(j);
          point(vert.x, vert.y, vert.z);
          path.add(vert);
        }
        //println(vert);
        //point(vert.x, vert.y, vert.z);
      }
    }
    //println("");
  }



  int getChildrenVertexCount(PShape shape) {
    int vertexCount = 0;
    for (PShape child : shape.getChildren()) {
      vertexCount += child.getVertexCount();
    }
    int childCount = shape.getChildCount();
    totalVertices = vertexCount;
    childShapes = childCount;
    vertAvg = (int) vertexCount/childCount;
    println("Vertex count:", vertexCount);
    println("Child shapes:", childCount);
    println("Vert/children", vertexCount/float(childCount), "\n");
    return vertexCount;
  }
}
