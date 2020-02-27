Textlabel frameRateLabel;
Textlabel stateTitle;
Textlabel stateLabel;
CheckBox rotateTilesCheckbox;
CheckBox imageDrawCheckbox;
CheckBox filterCheckbox;
CheckBox presentationModeCheckbox;
CheckBox redrawBGCheckbox;
CheckBox fadeCheckbox;
CheckBox globalStepCheckbox;

float[] y = {1f};
float[] n = {0f};
  
void initCP5(PApplet pa) {
  cp5 = new ControlP5(pa);
  cp5.setAutoDraw(false);
  
  cp5.setColorActive(color(155));
  cp5.setColorForeground(color(0));
  cp5.setColorBackground(color(255));
  
  cp5.addSlider("stepDebounce")
     .setRange(0,1000)
     .setValue(20)
     .setPosition(0,20)
     .setSize(100,10)
     .setLabel("Step speed")
     ;
  cp5.addSlider("scaleImages")
     .setRange(0.0,1.0f)
     .setValue(1.0f)
     .setPosition(0,30)
     .setSize(100,10)
     .setLabel("imgScale")
     ;
   cp5.addSlider("interval")
     .setRange(0,500)
     .setValue(20)
     .setPosition(0,40)
     .setSize(100,10)
     .setLabel("linear")
     ;
     
   rotateTilesCheckbox = cp5.addCheckBox("rotateTilesCheckbox")
    .setPosition(150, 10)
    .setSize(32, 8)
    .addItem("rotate", 1)
    ;
   imageDrawCheckbox = cp5.addCheckBox("imageDrawCheckbox")
    .setPosition(150, 20)
    .setSize(32, 8)
    .addItem("imgDraw", 1)
    ;

    
  redrawBGCheckbox = cp5.addCheckBox("redrawBGCheckbox")
    .setPosition(150, 30)
    .setSize(32, 8)
    .addItem("background", 1)
    ;
  fadeCheckbox = cp5.addCheckBox("fadeCheckbox")
    .setPosition(150, 40)
    .setSize(32, 8)
    .addItem("fade", 1)
    ;
   globalStepCheckbox = cp5.addCheckBox("globalStepCheckbox")
    .setPosition(150, 50)
    .setSize(32, 8)
    .addItem("globalStep", 1)
    ;
    
  
    
  cp5.addButton("nextState")
   .setValue(0)
   .setLabel("Next State")
   .setPosition(420,0)
   .setSize(60,10)
   ;
  cp5.addButton("prevState")
   .setValue(0)
   .setLabel("Prev State")
   .setPosition(420,10)
   .setSize(60,10)
   ;
  cp5.addButton("clearMovers")
   .setValue(0)
   .setLabel("Clear")
   .setPosition(420,20)
   .setSize(60,10)
   ;
  cp5.addButton("hideGui")
   .setValue(0)
   .setLabel("Hide GUI")
   .setPosition(420,30)
   .setSize(60,10)
   ;
  
  stateTitle = cp5.addTextlabel("label1")
    .setText("Current state: ")
    .setPosition(0, 80)
    ;
  stateLabel = cp5.addTextlabel("label2")
    .setText("A single ControlP5 textlabel")
    .setPosition(60, 80)
    .setColorValue(0xffff00ff)
    ;
  frameRateLabel = cp5.addTextlabel("label3")
    .setText("frameRate")
    .setPosition(0, 90)
    ;
   
  
}

public void nextState(int theValue) {
  println("nextState");
  stateMachine++;
  if(stateMachine >= maxStates) stateMachine = 0; 
  println("stateMachine= "+ stateMachine);
  clearStates();
}

public void prevState(int theValue) {
  println("previousState");
  stateMachine--;
  if(stateMachine < 0) stateMachine = maxStates-1;
  println("stateMachine= "+ stateMachine);
  clearStates();
}

public void clearMovers(int theValue) {
  movers.clear();
  println("cleared all movers");
}

public void hideGui(int theValue) {
  hideGui = !hideGui;
  println("hideGui= " + hideGui);
}



void rotateTilesCheckbox(float[] a) {
  if (a[0] == 1f) rotateTiles = true;
  else rotateTiles = false;
}
void redrawBGCheckbox(float[] a) {
  if (a[0] == 1f) redrawBackground = true;
  else redrawBackground = false;
  
  println("redrawBackground= "+ redrawBackground);
}
void fadeCheckbox(float[] a) {
  if (a[0] == 1f) fadeBackground = true;
  else fadeBackground = false;
}
void imageDrawCheckbox(float[] a) {
  if (a[0] == 1f) imageDraw = CORNER;
  else imageDraw = CENTER;
  
  //if(imageDraw == CENTER) imageMode(CENTER);
  //else imageMode(CORNER);
}
void globalStepCheckbox(float[] a) {
  if (a[0] == 1f) globalStep = true;
  else globalStep = false;
}
