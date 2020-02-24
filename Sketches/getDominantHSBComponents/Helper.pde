void keyPressed() {
    if (key == 'p') {
      p = !p;
      println("p= " + p);
    } else if (key == 'c') {
      center = !center;
      println("center= " + center);
    }  else if (key == 'r') {
      rotate = !rotate;
      println("rotate= " + rotate);
    }  
}

void init() {
  if(firstRun) {
    firstRun = false;
    println("Adding nodes and calculating weights...");
    for(int i = 0; i<300; i++) {
      //print("i="+ i +" => ");
      //nodes.add(new ColorNode("svg/i_"+i+".jpg", mode));
      nodes.add(new ColorNode("y__"+i+".jpg", mode));
      //nodes.add(new ColorNode("1.jpg", 1));
    }
    println("done!");
  }
}
void initCam(PApplet pa) {
  cam = new PeasyCam(pa, scaleZ*4);
  cam.setWheelScale(0.2);
  cam.setMaximumDistance(1000000);
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

CheckBox modeCheckbox;
CheckBox rotateCheckbox;
CheckBox centerCheckbox;
CheckBox imageDrawCheckbox;
CheckBox filterCheckbox;
CheckBox presentationModeCheckbox;
CheckBox redrawBGCheckbox;
Chart myChart;
Range range0;
Range range1;
Range range2;

  
void initCP5(PApplet pa) {
  cp5 = new ControlP5(pa);
  cp5.setAutoDraw(false);
  
  cp5.setColorActive(color(155));
  cp5.setColorForeground(color(0));
  cp5.setColorBackground(color(255));
  
  cp5.addSlider("scaleX")
     .setRange(0,10000)
     .setValue(2000)
     .setPosition(0,0)
     .setSize(100,10)
     .setLabel("X")
     ;
  cp5.addSlider("scaleY")
     .setRange(0,10000)
     .setValue(2000)
     .setPosition(0,10)
     .setSize(100,10)
     .setLabel("Y")
     ;
  cp5.addSlider("scaleZ")
     .setRange(0,10000)
     .setValue(2000)
     .setPosition(0,20)
     .setSize(100,10)
     .setLabel("Z")
     ;
  cp5.addSlider("scaleImages")
     .setRange(0.0,1.0f)
     .setValue(1.0f)
     .setPosition(0,30)
     .setSize(100,10)
     .setLabel("imgScale")
     ;
   cp5.addSlider("interval")
     .setRange(0,1000)
     .setValue(20)
     .setPosition(0,40)
     .setSize(100,10)
     .setLabel("linear")
     ;
     
   modeCheckbox = cp5.addCheckBox("modeCheckbox")
    .setPosition(150, 0)
    .setSize(32, 8)
    .addItem("mode", 1)
    ;
   rotateCheckbox = cp5.addCheckBox("rotateCheckbox")
    .setPosition(150, 10)
    .setSize(32, 8)
    .addItem("rotate", 1)
    ;
   centerCheckbox = cp5.addCheckBox("centerCheckbox")
    .setPosition(150, 20)
    .setSize(32, 8)
    .addItem("center", 1)
    ;
   imageDrawCheckbox = cp5.addCheckBox("imageDrawCheckbox")
    .setPosition(150, 30)
    .setSize(32, 8)
    .addItem("imgDraw", 1)
    ;
  filterCheckbox = cp5.addCheckBox("filterCheckbox")
    .setPosition(150, 40)
    .setSize(32, 8)
    .addItem("filter", 1)
    ;
  presentationModeCheckbox = cp5.addCheckBox("presentationModeCheckbox")
    .setPosition(150, 50)
    .setSize(32, 8)
    .addItem("presentation", 1)
    ;
    
  redrawBGCheckbox = cp5.addCheckBox("redrawBGCheckbox")
    .setPosition(150, 60)
    .setSize(32, 8)
    .addItem("background", 1)
    
    ;
    
  range0 = cp5.addRange("rangeController0")
   // disable broadcasting since setRange and setRangeValues will trigger an event
   .setBroadcast(false)
   .setLabel("RANGE 1")
   .setPosition(250,0)
   .setSize(100,10)
   .setHandleSize(10)
   .setRange(0,360)
   .setRangeValues(0,360)
   // after the initialization we turn broadcast back on again
   .setBroadcast(true)
   ;
  range1 = cp5.addRange("rangeController1")
   // disable broadcasting since setRange and setRangeValues will trigger an event
   .setBroadcast(false)
   .setLabel("RANGE 2")
   .setPosition(250,10)
   .setSize(100,10)
   .setHandleSize(10)
   .setRange(0,100)
   .setRangeValues(0,100)
   // after the initialization we turn broadcast back on again
   .setBroadcast(true)
   ;
 range2 = cp5.addRange("rangeController2")
   // disable broadcasting since setRange and setRangeValues will trigger an event
   .setBroadcast(false)
   .setLabel("RANGE 3")
   .setPosition(250,20)
   .setSize(100,10)
   .setHandleSize(10)
   .setRange(0,100)
   .setRangeValues(0,100)
   // after the initialization we turn broadcast back on again
   .setBroadcast(true)
   ;
    
  cp5.addButton("linearNone")
   .setValue(0)
   .setLabel("None")
   .setPosition(420,0)
   .setSize(60,10)
   ;
  cp5.addButton("linearCycle")
   .setValue(0)
   .setLabel("Cycle")
   .setPosition(420,10)
   .setSize(60,10)
   ;
  cp5.addButton("linearDrag")
   .setValue(0)
   .setLabel("Dragging")
   .setPosition(420,20)
   .setSize(60,10)
   ;

   
}

public void linearNone(int theValue) {
  println("linearNone");
  linearCycleMode = 0;
}

public void linearCycle(int theValue) {
  println("linearCycle");
  linearCycleMode = 1;
}

public void linearDrag(int theValue) {
  println("linearDrag");
  linearCycleMode = 2;
}

void modeCheckbox(float[] a) {
  if (a[0] == 1f) mode = 1;
  else mode = 0;
  modeChangeEvent();
}

void rotateCheckbox(float[] a) {
  if (a[0] == 1f) rotate = true;
  else rotate = false;
}
void centerCheckbox(float[] a) {
  if (a[0] == 1f) center = true;
  else center = false;
}
void imageDrawCheckbox(float[] a) {
  if (a[0] == 1f) imageDraw = CORNER;
  else imageDraw = CENTER;
}
void filterCheckbox(float[] a) {
  if (a[0] == 1f) filter = true;
  else filter = false;
}
void presentationModeCheckbox(float[] a) {
  if (a[0] == 1f) presentation = true;
  else presentation = false;
}
void redrawBGCheckbox(float[] a) {
  if (a[0] == 1f) redrawBackground = true;
  else redrawBackground = false;
}



void controlEvent(ControlEvent theControlEvent) {
  if(theControlEvent.isFrom("rangeController0")) {
    componentMin[0] = int(theControlEvent.getController().getArrayValue(0));
    componentMax[0] = int(theControlEvent.getController().getArrayValue(1));
    println("range0 update, done.");
  } else if(theControlEvent.isFrom("rangeController1")) {
    componentMin[1] = int(theControlEvent.getController().getArrayValue(0));
    componentMax[1] = int(theControlEvent.getController().getArrayValue(1));
    println("range1 update, done.");
  } else if(theControlEvent.isFrom("rangeController2")) {
    componentMin[2] = int(theControlEvent.getController().getArrayValue(0));
    componentMax[2] = int(theControlEvent.getController().getArrayValue(1));
    println("range2 update, done.");
  }
}

void drawGUI() {
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

void drawNodes() {
  
  for(int i = 0; i<nodes.size(); i++) {
    
    //PVector d = nodes.get(i).getPosition();
    int[] d = nodes.get(i).getPosition();
    boolean show = false;
    if(filter) {
      if(mode == 1) {
        float fX = d[0];
        float fY = d[1];
        float fZ = d[2];
        float x = (int)map(fX, 0, 360, 0, 255);
        float y = (int)map(fY, 0, 100, 0, 255);
        float z = (int)map(fZ, 0, 100, 0, 255);
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
        pushMatrix();
        float mX = 0;
        float mY = 0;
        float mZ = 0;
        if(mode == 0) {
          float hue = map(d[0], 0, 360, 0.0, 6.28);
          float saturation = map(d[1], 0, 100, -scaleZ, scaleZ);
          float brightness = map(d[2], 0, 100, -scaleY, scaleY);
          mX = saturation * cos(hue);
          mZ = saturation * sin(hue);
          translate(mX, brightness, mZ);
        } else if(mode == 1) {
          mX = map(d[0], 0, 360, -scaleX, scaleX);
          mY = map(d[1], 0, 100, -scaleY, scaleY);
          mZ = map(d[2], 0, 100, -scaleZ, scaleZ);
          translate(mX, mY, mZ);
        }
        
        scale(scaleImages);
        pushStyle();
        imageMode(imageDraw);
        image(nodes.get(i).getImage(), 0, 0);
        popStyle();
        popMatrix();
      } else {
        // sets in linear mode
        pushStyle();
        imageMode(imageDraw);
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
          pushMatrix();
          imageMode(imageDraw);
          translate(width/2, height/2, 0);
          image(nodes.get(nodeNr).getImage(), 0, 0);
          popMatrix();
        }
        popStyle();
      }
    }
  }
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

void playNote(int note) {
    int mNote = Scale.note(Scale.MAJOR_PENTATONIC, Scale.NOTE_C4, note);
    mNote %= 127;
    mEnv.play_note_on((note / 16) % 12, mNote, 100, 1.5f);
    mStep++;
}
