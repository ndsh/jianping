void keyPressed() {
    if (key == 'r') {
      record = !record;
      println("record= " + record);
    } else if (key == 'c') {
      center = !center;
      println("center= " + center);
    }  else if (key == 'p') {
      rotate = !rotate;
      println("pivot= " + rotate);
    }  else if (key == 'q') {
      println("Quitting sketch");
      exit();
      
    } else if (key == 'h' || key == 'H' ) {
      hideGui = !hideGui;
      println("hideGui= " + hideGui);
    } else if (key == 'd' || key == 'D' ) {
      redrawBackground = !redrawBackground;
      println("redrawBackground= " + redrawBackground);
    }
    
}

void init() {
  if(firstRun) {
    firstRun = false;
    println("Adding nodes and calculating weights...");
    
    
    if(importer.getFiles().size() > 0) {
      // STANDARD
      
      for(int i = 0; i<importer.getFiles().size(); i++) {
        //print("i="+ i +" => ");
        //nodes.add(new ColorNode("svg/i_"+i+".jpg", mode));
        //nodes.add(new ColorNode("jianping-extracts/y__"+i+".jpg"));
        nodes.add(new ColorNode(importer.getFiles().get(i)));
        ;
        //nodes.add(new ColorNode("1.jpg", 1));
      }
      
      
      
      // ALL
      /*
      for (int j = 0; j <10; j++) {
        if(j == 2 || j == 6 || j == 1 || j == 7 || j == 8 || j == 9) { ; 
        } else {
          importer.loadFiles(importer.getFolders().get(j));
          for (int i = 0; i <importer.getFiles().size(); i++) {
            //img[i] = loadImage("a-"+i+".jpg"); // richards alte methode
            //PImage temp = loadImage(importer.getFiles().get(i));
            nodes.add(new ColorNode(importer.getFiles().get(i)));
          }
        }
        
      } //
    */
      
      println("done!");
      isRunnable = true;
    }
    if(isRunnable) {
      for(int i = 0; i<nodes.size(); i++) {
        nodes.get(i).getNormalizedImage();
      }
    }
  }
}
void initCam(PApplet pa) {
  cam = new PeasyCam(pa, scaleZ*4);
  cam.setWheelScale(0.2);
  cam.setMaximumDistance(1000000);
}

void drawCenter() {
  if(center) {
    pg.pushMatrix();
    // x axis
    pg.beginShape(LINES);
    pg.vertex(-scaleX, 0, 0);
    pg.vertex(scaleX, 0, 0);
    pg.endShape();
    
    // y axis
    pg.beginShape(LINES);
    pg.vertex(0, -scaleY, 0);
    pg.vertex(0, scaleY, 0);
    pg.endShape();
    
    // z axis
    pg.beginShape(LINES);
    pg.vertex(0, 0, -scaleZ);
    pg.vertex(0, 0, scaleZ);
    pg.endShape();
    pg.popMatrix();
  }
}

void drawGUI() {
  if(!hideGui) {
    cam.beginHUD();
    pushStyle();
    fill(0);
    noStroke();
    rect(0, 0, width, 100);
    popStyle();
    
    image(marke, width-135, 85);
    fill(color( (componentMax[0]-componentMin[0])/2, (componentMax[1]-componentMin[1])/2, (componentMax[2]-componentMin[2])/2)); 
    rect(250, 30, 100, 40);
    cp5.draw();
    cam.endHUD();
  }
}

void drawNodes() {
  pg.beginDraw();
  pg.setMatrix(getMatrix()); // replace the PGraphics-matrix

  for(int i = 0; i<nodes.size(); i++) {
    
    //PVector d = nodes.get(i).getPosition();
    int[] d = nodes.get(i).getPosition();
    boolean show = false;
    if(filter) {
      if(mode == 1) {
        float fX = d[0];
        float fY = d[1];
        float fZ = d[2];
        
        float x = (int)fX;
        float y = (int)fY;
        float z = (int)fZ;
        
        if( (x >= componentMin[0] && x <= componentMax[0]) && (y >= componentMin[1] && y <= componentMax[1]) && (z >= componentMin[2] && z <= componentMax[2]) ) show = true;
        //else println(componentMin[0] + "/" + componentMax[0] + "= "+ t.x +" | "+ componentMin[1] + "/" + componentMax[1] + "= "+ t.y +" | "+ componentMin[2] + "/" + componentMax[2] + "= "+ t.z);
      } else {
        if( (d[0] >= componentMin[0] && d[0] <= componentMax[0]) && (d[1] >= componentMin[1] && d[1] <= componentMax[1]) && (d[2] >= componentMin[2] && d[2] <= componentMax[2]) ) show = true;
        //else println(componentMin[0] + "/" + componentMax[0] + "= "+ d.x +" | "+ componentMin[1] + "/" + componentMax[1] + "= "+ d.y +" | "+ componentMin[2] + "/" + componentMax[2] + "= "+ d.z);
      }
    } else show = true;
    
    if(show) {
      // color space mode
      if(presentation) {
        drawCenter();
        pg.pushMatrix();
        float mX = 0;
        float mY = 0;
        float mZ = 0;
        if(mode == 0) {
          float hue = map(d[0], 0, 360, 0.0, 6.28);
          float saturation = map(d[1], 0, 100, -scaleZ, scaleZ);
          float brightness = map(d[2], 0, 100, -scaleY, scaleY);
          mX = saturation * cos(hue);
          mZ = saturation * sin(hue);
          pg.translate(mX, brightness, mZ);
        } else if(mode == 1) {
          mX = map(d[0], 0, 255, -scaleX, scaleX);
          mY = map(d[1], 0, 255, -scaleY, scaleY);
          mZ = map(d[2], 0, 255, -scaleZ, scaleZ);
          //println(i +"= " + d[0] + "/"+ d[1] + "/"+ d[2] + " from file= "+ nodes.get(i).getName());
          pg.translate(mX, mY, mZ);
        }
        
        pg.scale(scaleImages);
        pg.pushStyle();
        pg.imageMode(imageDraw);
        pg.image(nodes.get(i).getImage(), 0, 0);
        //image(nodes.get(i).getNormalizedImage(), 0, 0);
        
        pg.popStyle();
        pg.popMatrix();
      } else {
        // sets in linear mode
        pg.pushStyle();
        pg.imageMode(imageDraw);
        /*
          int linearLimit = 360;
          int linearIndex = 0;
          int componentIndex = 0; // limit = components di
        */
        
        if(matchingComponents == null || componentIndex >= matchingComponents.size()-1 || matchingComponents.size() == 0) {
          //print("get new list == ");
          //println(linearIndex + " " + componentIndex);
          //println("matchingComponents= "+ matchingComponents.size());
          assembleComponentList(linearIndex, 0);
          linearIndex++;
          if(linearIndex >= linearLimit) linearIndex = 0;
          componentIndex = 0;
        }
        //println("matchingComponents== "+ matchingComponents.size());
        if(matchingComponents.size() != 0) {
          if(millis() - timestamp > interval && linearCycleMode == 1 || mouseWasDragged) {
            mouseWasDragged = false;
            timestamp = millis();
            componentIndex++;
          }
          int nodeNr = matchingComponents.get(componentIndex);
          pg.pushMatrix();
          pg.imageMode(imageDraw);
          pg.translate(pg.width/2, pg.height/2, 0);
          pg.image(nodes.get(nodeNr).getImage(), 0, 0);
          //image(nodes.get(i).getNormalizedImage(), 0, 0);

          pg.popMatrix();
        }
        pg.popStyle();
      }
    }
  }
  pg.endDraw();
}

void mousePressed() {
  cam.setActive(checkGUIcollision());
}

void mouseDragged() {
  cam.setActive(checkGUIcollision());
  if(linearCycleMode == 2) mouseWasDragged = true;
}

boolean checkGUIcollision() {
  if((mouseY <= 100)) return false;
  else return true;
}

void modeChangeEvent() {
  if(mode == 0) {
    pg.colorMode(HSB, 360, 100, 100);
    range0.setRange(0,360);
    range1.setRange(0,100);
    range2.setRange(0,100);
    
    for(int i = 0; i<3; i++) {
      componentMin[i] = 0;
      if(i == 0) componentMax[i] = 360;
      else componentMax[i] = 100;
    }
    range0.setRangeValues(0,360);
    range1.setRangeValues(0,100);
    range2.setRangeValues(0,100);
  } else if(mode == 1) {
    pg.colorMode(RGB, 255, 255, 255);
    range0.setRange(0,255);
    range1.setRange(0,255);
    range2.setRange(0,255);
    for(int i = 0; i<3; i++) {
      componentMin[i] = 0;
      componentMax[i] = 255;
    }
    range0.setRangeValues(0,255);
    range1.setRangeValues(0,255);
    range2.setRangeValues(0,255);
  } 
  for(int i = 0; i<nodes.size(); i++) {
    nodes.get(i).assertDominance();
  }
}

void initRanges() {
  for(int i = 0; i<3; i++) {
    componentMin[i] = 0;
    if(i == 0) componentMax[i] = 360;
    else componentMax[i] = 100;
  }
}

// a list of components that match the current linearInde aka "dominant" sorting component
IntList matchingComponents = new IntList();
void assembleComponentList(int needle, int dominant) {
  matchingComponents = new IntList();
  for(int i = 0; i<nodes.size(); i++) {
    ColorNode n = nodes.get(i);
    int[] dominants = n.getPosition();
    if(dominants[dominant] == needle) matchingComponents.append(i);
  }
  
  //println("assembled new list with a size of= " + matchingComponents.size());
}
