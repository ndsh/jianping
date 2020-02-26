ArrayList<PVector> path = new ArrayList<PVector>();

PShape s;

float ry;
int vcount;
int current = 0;

int totalVertices = 0;
int vertAvg = 0;

void setup() {
  size(600, 600, P3D);
  // The file "bot.obj" must be in the data folder
  // of the current sketch to load successfully
  s = loadShape("curve2.obj");
//  println(s.getVertex(0));


  //// print all vertices
  //printChildVertices(s);
  //// print a specific vertex i,j : (x,y,z)
  println("rocket.getChild(0).getVertex(0):\n  ", s.getChild(0).getVertex(0), "\n");
  //// get summary counts
  vcount = getChildrenVertexCount(s);
  fillListChildVertices(s);
  
}

void draw() {
  background(200);
  
  push();
    translate(width/2, height/2);
    push();
      translate(path.get(current).x, path.get(current).y, path.get(current).z);
      if(current % vertAvg == 0);
      sphere(2);
      current++;
      if(current >= totalVertices/vertAvg) current = 0;
    pop();
  pop();
  
  
  
  push();
  translate(width/2, height/2);
  shape(s, 0, 0);
  pop();
  

}



void printChildVertices(PShape shape){
  for(int i=0; i<shape.getChildCount(); i++){
    PShape child = shape.getChild(i);
    for(int j=0; j<child.getVertexCount();j++){
      PVector vert = child.getVertex(j);
      println(vert);
    }
  }
  println("");
}

void plotChildVertices(PShape shape){
  
  for(int i=0; i<shape.getChildCount(); i++){
    PShape child = shape.getChild(i);
    for(int j=0; j<child.getVertexCount();j++){
      PVector vert = child.getVertex(j);
      //println(vert);
      point(vert.x, vert.y, vert.z);
    }
  }
  //println("");
}

void fillListChildVertices(PShape shape){
  
  for(int i=0; i<shape.getChildCount(); i++){
    PShape child = shape.getChild(i);
    for(int j=0; j<child.getVertexCount();j++){
      PVector vert = null;
      if(j % vertAvg == 0) {
        vert = child.getVertex(j);
        path.add(vert);
      }
      //println(vert);
      //point(vert.x, vert.y, vert.z);
      
    }
  }
  //println("");
}


 
int getChildrenVertexCount(PShape shape){
  int vertexCount = 0;
  for(PShape child : shape.getChildren()){
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
