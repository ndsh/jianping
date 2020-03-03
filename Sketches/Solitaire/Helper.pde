void mouseDragged() {
  if(hideGui) addMover();
  else if(mouseY > 100 && stateMachine == STANDARD) addMover();
}

void mousePressed() {
  if(hideGui) addMover();
  else if(mouseY > 100 && stateMachine == STANDARD) addMover();
}

void keyPressed() {
  if (key == DELETE) {
  } else if (key == 'r' || key == 'R' ) {
    record = !record;
    println("record= " + record);
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
  } else if (keyCode == ' ') {
    run = !run;
    println("run= "+ run);
  }
}


void init() {
  if(firstRun) {
    firstRun = false;
    println("Adding movers...");
    if(!loadAllAssets) {
      // STANDARD METHODE MIT EINEM SATZ
      for (int i = 0; i <importer.getFiles().size(); i++) {
        //img[i] = loadImage("a-"+i+".jpg"); // richards alte methode
        //PImage temp = loadImage(importer.getFiles().get(i));
        img.add(loadImage(importer.getFiles().get(i)));
        original_img.add(loadImage(importer.getFiles().get(i)));
      }
    } else {
      // ERWEITERTE METHODE MIT n-vielen DATENSÄTZEN
      // importer.getFolders().size()
      for (int j = 0; j <2; j++) {
        importer.loadFiles(importer.getFolders().get(j));
        for (int i = 0; i <importer.getFiles().size(); i++) {
          //img[i] = loadImage("a-"+i+".jpg"); // richards alte methode
          //PImage temp = loadImage(importer.getFiles().get(i));
          img.add(loadImage(importer.getFiles().get(i)));
          original_img.add(loadImage(importer.getFiles().get(i)));
        }
      }
    }
    
    println("Normalizing images");
    // normalize images
    for(int i = 0; i<img.size(); i++) {
      getNormalizedImage(img.get(i));
    }
    nPics = importer.getFiles().size();
    println("done!");
  }
}

void addMover() {
  if (millis() - timestamp > interval) {
    timestamp = millis();
    movers.add(new Mover(new PVector(mouseX, mouseY)));
  }
}

void addMover(int _x, int _y) {
  if (millis() - timestamp > interval) {
    timestamp = millis();
    movers.add(new Mover(new PVector(_x, _y)));
  }
}

void clearStates() {
  movers.clear();
  println("switching to state= "+ stateMachine);
  pg = createGraphics(width, height);
  pg.beginDraw();
  //pg.background(125, 50, 100);
  pg.imageMode(CENTER);
  pg.endDraw();
  xAxis = 0;
  yAxis = 0;
  stateMachineFirstCycle = true;
  direction = false;
  p = null;
  useSize = false;
  trailLength = 200;
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
    fill(30);
    noStroke();
    rect(0, 0, width, 100);
    fill(0, 100, 100);
    line(0,220,width,220);
    popStyle();
  
    imageMode(CORNER);
    image(marke, width-135, 85); 
  
    cp5.draw();
  }
  
}
