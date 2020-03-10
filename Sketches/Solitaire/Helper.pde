void mouseDragged() {
  if (millis() - timestamp > interval) {
    timestamp = millis();
    if(hideGui && stateMachine == STANDARD) addMover();
    else if(mouseY > 100 && stateMachine == STANDARD) addMover();
  }
}

void mousePressed() {
  if (millis() - timestamp > interval) {
    timestamp = millis();
    if(hideGui && stateMachine == STANDARD) addMover();
    else if(mouseY > 100 && stateMachine == STANDARD) addMover();
  }
}

void keyPressed() {
  if (key == DELETE) {
  } else if (key == 'r' || key == 'R' ) {
    record = !record;
    println("record= " + record);
  } else if (key == 'o' || key == 'O' ) {
    overlay = !overlay;
    println("overlay= " + overlay);
  } else if (key == 'h' || key == 'H' ) {
    hideGui = !hideGui;
    println("hideGui= " + hideGui);
  } else if (key == 'd' || key == 'D' ) {
    redrawBackground = !redrawBackground;
    println("redrawBackground= " + redrawBackground);
  } else if (keyCode == RIGHT) {
    nextState(0);
  } else if (keyCode == LEFT) {
    prevState(0);
  } else if (keyCode == UP) {
    imageIndex++;
    if(imageIndex >= superAsset.length) imageIndex = superAsset.length-1;
  } else if (keyCode == DOWN) {
    imageIndex--;
    if(imageIndex <= 0) imageIndex = 0;
  } else if (keyCode == ' ') {
    run = !run;
    println("run= "+ run);
  }
}


void init() {
  if(firstRun) {
    firstRun = false;
    println("Adding movers...");
    if(loadingMode == 0) {
      // STANDARD METHODE MIT EINEM SATZ
      imageList.add(new ArrayList<PImage>());
      for (int i = 0; i <importer.getFiles().size(); i++) {
        //img[i] = loadImage("a-"+i+".jpg"); // richards alte methode
        //PImage temp = loadImage(importer.getFiles().get(i));
        imageList.get(imageIndex).add(loadImage(importer.getFiles().get(i)));
        //original_img.add(loadImage(importer.getFiles().get(i)));
      }
    } else if(loadingMode == 1) {
      // ERWEITERTE METHODE MIT n-vielen DATENSÄTZEN
      // importer.getFolders().size()
      for (int j = 0; j <2; j++) {
        importer.loadFiles(importer.getFolders().get(j));
        for (int i = 0; i <importer.getFiles().size(); i++) {
          //img[i] = loadImage("a-"+i+".jpg"); // richards alte methode
          //PImage temp = loadImage(importer.getFiles().get(i));
          imageList.get(imageIndex).add(loadImage(importer.getFiles().get(i)));
          //original_img.add(loadImage(importer.getFiles().get(i)));
        }
      }
    } else if(loadingMode == 2) {
      // superAsset Mode
        
      for (int j = 0; j <superAsset.length; j++) {
        imageList.add(new ArrayList<PImage>());
        
        importer.loadFiles(importer.folders.get(superAsset[j]));
        println(importer.getFiles().get(0));
        
        for (int i = 0; i <importer.getFiles().size(); i++) {
          imageList.get(j).add(loadImage(importer.getFiles().get(i)));
          //original_img.add(loadImage(importer.getFiles().get(i)));
        }
      }
    }
    
    //println("Normalizing images");
    // normalize images
    for(int k = 0; k<imageList.size(); k++) {
      for(int i = 0; i<imageList.get(k).size(); i++) {
        //getNormalizedImage(imageList.get(k).get(i));
      }
    }
    //nPics = importer.getFiles().size();
    println("done!");
  }
}

void addMover() {
   movers.add(new Mover(new PVector(mouseX * screenFactor, mouseY * screenFactor), imageIndex)); 
}

void addMover(int _x, int _y) {
    movers.add(new Mover(new PVector(_x, _y), imageIndex));
}

void clearStates() {
  movers.clear();
  println("switching to state= "+ stateMachine);
  //pg = createGraphics(width, height);
  //pg.beginDraw();
  //pg.background(125, 50, 100);
  //pg.imageMode(CENTER);
  //pg.endDraw();
  xAxis = 0;
  yAxis = 0;
  stateMachineFirstCycle = true;
  direction = false;
  p = null;
  trailLength = 100;
  timestamp = millis();
  comingFromTransition = false;
  stateIterator = 0;
}

void transitionStates() {
  println("switching to state= "+ stateMachine);
  stateMachineFirstCycle = true;
  trailLength = 200;
  comingFromTransition = true;
  timestamp = millis();
  stateIterator = 0;
}

void setState(int theState) {
  println("previousState");
  stateMachine = theState;
  println("stateMachine= "+ stateMachine);
}


PImage getNormalizedImage(PImage p) {
  // check which side is "longer"
  // then check if that side is smaller or bigger than the normalizedBorders
  
  if(p.width > p.height) {
    if(p.width > normalizedBorders[1]) p.resize(normalizedBorders[1], 0); //factor = p.width-normalizedBorders[1];
    else p.resize(normalizedBorders[0], 0);
    
  } else {
    if(p.height > normalizedBorders[0]) p.resize(0, normalizedBorders[1]); //factor = p.height-normalizedBorders[0];
    else p.resize(0, normalizedBorders[0]);
  }
  return p;
  
}

void drawGUI() {
  if(stateMachine == INIT) stateLabel.setText("Initializing");
  else if (!(stateLabel.getStringValue().equals(getStateName(stateMachine)))) stateLabel.setText(getStateName(stateMachine));
  frameRateLabel.setText("Framerate: "+ frameRate);
  if(!hideGui) {
    pushStyle();
    fill(30, 230);
    noStroke();
    rect(0, 0, 600, 100);
    fill(0, 100, 100);
    line(0,220,width,220);
    popStyle();
  
    imageMode(CORNER);
    image(marke, 600-135, 85); 
  
    cp5.draw();
  }
  
}

void svg2movers(String fn) {
  grp = RG.loadShape(fn);
  //grp.centerIn(g, 100, 1, 1);
  pointPaths = grp.getPointsInPaths();
  println(pointPaths.length);
  // pfade auslesen
  int c = 0;
  for(int i = 0; i<pointPaths.length; i++){
    if (pointPaths[i] != null) {
      c = 0;
      for(int j = 0; j<pointPaths[i].length; j++){
        
        movers.add(new Mover(new PVector(pointPaths[i][j].x, pointPaths[i][j].y), i%imageList.get(i%imageList.size()).size()));
        
        int o = c%imageList.get(i%imageList.size()).size();
        movers.get(movers.size()-1).setOffset(o);
        c++;
      }
    }
  }
  
  //println(movers.size());
  
}
