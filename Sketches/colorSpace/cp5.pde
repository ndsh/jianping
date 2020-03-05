CheckBox modeCheckbox;
CheckBox rotateCheckbox;
CheckBox centerCheckbox;
CheckBox imageDrawCheckbox;
CheckBox filterCheckbox;
CheckBox presentationModeCheckbox;
CheckBox redrawBGCheckbox;
Range range0;
Range range1;
Range range2;

float[] y = {1f};
float[] n = {0f};

  
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
  cp5.addButton("hideGui")
   .setValue(0)
   .setLabel("Hide GUI")
   .setPosition(420,30)
   .setSize(60,10)
   ;
  cp5.addButton("assetExport")
   .setValue(0)
   .setLabel("Export Assets")
   .setPosition(420,60)
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
public void hideGui(int theValue) {
  hideGui = !hideGui;
  println("hideGui= " + hideGui);
}

public void assetExport(int theValue) {
  println("export assets");
  assetExporter.parse();
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
