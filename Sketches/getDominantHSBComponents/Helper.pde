void keyPressed() {
    if (key == 'p') {
      p = !p;
      println("p= " + p);
    } else if (key == 'c') {
      center = !center;
      println("center= " + center);
    }  
}

void init() {
  if(firstRun) {
    firstRun = false;
    println("Adding nodes and calculating weights...");
    for(int i = 0; i<329; i++) {
      //print("i="+ i +" => ");
      nodes.add(new ColorNode("svg/i_"+i+".jpg", mode));
      //nodes.add(new ColorNode("1.jpg", 1));
    }
    println("done!");
  }
}

void drawCenter() {
  if(center) {
    pushMatrix();
    // x axis
    beginShape(LINES);
    vertex(-scaleX, 0, 0);
    vertex(scaleX, 0, 0);
    endShape();
    
    // y axis
    beginShape(LINES);
    vertex(0, -scaleY, 0);
    vertex(0, scaleY, 0);
    endShape();
    
    // z axis
    beginShape(LINES);
    vertex(0, 0, -scaleZ);
    vertex(0, 0, scaleZ);
    endShape();
    popMatrix();
  }
}
