class Path {
  ArrayList<PVector> path = new ArrayList<PVector>();

  PShape s;

  float ry;
  int vcount;
  int current = 0;

  int totalVertices = 0;
  int vertAvg = 0;

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
      translate(width/2, height/2);
      push();
        translate(path.get(current).x, path.get(current).y, path.get(current).z);
        sphere(2);
      pop();
    pop();
  }
  
  void show3D() {
    push();
    translate(width/2, height/2);
    shape(s, 0, 0);
    pop();
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
        PVector vert = child.getVertex(j);
        //println(vert);
        point(vert.x, vert.y, vert.z);
      }
    }
    //println("");
  }

  void fillListChildVertices(PShape shape) {

    for (int i=0; i<shape.getChildCount(); i++) {
      PShape child = shape.getChild(i);
      for (int j=0; j<child.getVertexCount(); j++) {
        PVector vert = null;
        if (j % vertAvg == 0) {
          vert = child.getVertex(j);
          println(vert);
          exit();
          path.add(vert);
        }
        //println(vert.z);
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
    vertAvg = (int) vertexCount/childCount;
    println("Vertex count:", vertexCount);
    println("Child shapes:", childCount);
    println("Vert/children", vertexCount/float(childCount), "\n");
    return vertexCount;
  }
}
