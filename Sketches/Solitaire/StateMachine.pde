static final int INIT = 999;
static final int STANDARD = 0;
static final int LINEAR = 1;
static final int FOLLOW = 2;
static final int ROWS = 3;
static final int ZIGZAG = 4;
static final int SIZE = 5;
static final int AUTOMATA = 6;
static final int SNAKE = 7;
static final int GAUSSIAN = 8;

int maxStates = 6;

////////// STATE VARIABLES

// LINEAER
PGraphics pg;
int xAxis = 0;
int yAxis = 0;

static final String[] stateNames = {
  "Standard", "Linear", "Follow",
  "Rows", "Zigzag", "Size",
  "Automata", "Snake", "Gaussian"
};

String getStateName(int state) {
  return stateNames[state];
}


void stateMachine(int state) {
  if(redrawBackground) background(0);
   switch(state) {
    
    case INIT:
      init();
      stateMachine = STANDARD;
    break;
    
    case STANDARD:
      if(stateMachineFirstCycle) {
        exporter.setPath(appName +"-standard");
        stateMachineFirstCycle = false;
      }
      
      for (Mover mv : movers) {
        mv.update();
        mv.display();
      }
    
      /* segmente in strecken abfahren 
       int start = 0;
       int end = 50;
       if(movers.size() > end) {
         for (int i = start; i<start+end; i++) {
           movers.get(i).display();
         }
       }
      */
      if(!record) {
        fill(255, 125);
        noStroke();
        pushMatrix();
        //translate(mouseX, mouseY);
        ellipse(mouseX, mouseY, 10, 10);
        //rect(0, 0, 10, 10);
        popMatrix();
      }
    break;
    
    case LINEAR:
      if(stateMachineFirstCycle) {
        stateMachineFirstCycle = false;
        exporter.setPath(appName +"-linear");
      }
    
      if(xAxis <= width) addMover(xAxis, height/2);
      for (Mover mv : movers) {
        mv.display();
        mv.step();
      }
      if(xAxis <= width) xAxis += normalizedBorders[1];
    
    break;
    
    case FOLLOW:
      if(stateMachineFirstCycle) {
        stateMachineFirstCycle = false;
        addMover(width/2, height/2);
        exporter.setPath(appName +"-follow");
        stepDebounce = 200;
      }
      p = movers.get(0).getImage();
      pg.beginDraw();
      pg.imageMode(CENTER);
      pg.image(p, pg.width/2, mouseY);
      //println(movers.get(0).getImage().width);
      pg.image(pg.get(), pg.width/2 - p.width, pg.height/2);
      pg.endDraw();
      
      push();
      translate(width/2, height/2);
      imageMode(CENTER);
      image(pg, 0, 0);
      pop();
      
      movers.get(0).step();
    break;
    
    case ROWS:
      if(stateMachineFirstCycle) {
        stateMachineFirstCycle = false;
        addMover(width/2, height/2);
        exporter.setPath(appName +"-rows");
        stepDebounce = 200;
      }
      
      pg.beginDraw();
      pg.imageMode(CENTER);
      for(int y = 0; y<height; y++) {
        pg.image(movers.get(0).getImage(), width, y*pg.height/movers.get(0).getImage().height);
        movers.get(0).step();
      }
      
      pg.image(pg.get(), width/2 - movers.get(0).getImage().width, height/2);
      pg.endDraw();
      
      push();
      translate(width/2, height/2);
      imageMode(CENTER);
      image(pg, 0, 0);
      pop();
      
     // movers.get(0).step();
    break;
    
    case ZIGZAG:
      if(stateMachineFirstCycle) {
        stateMachineFirstCycle = false;
        addMover(width/2, height/2);
        exporter.setPath(appName +"-zigzag");
        stepDebounce = 200;
      }
      p = movers.get(0).getImage();
      
      pg.beginDraw();
      
      pg.imageMode(CENTER);
      pg.image(p, width, yAxis);
      pg.image(pg.get(), pg.width/2 - p.width, pg.height/2);
      pg.endDraw();
      
      push();
      translate(width/2, height/2);
      imageMode(CENTER);
      image(pg, 0, 0);
      pop();
      
      if(direction) yAxis += p.height;
      else yAxis -= p.height;
      
      if(yAxis < 0) direction = true;
      else if(yAxis >= height) direction = false;
      movers.get(0).step();
      
      
    break;
    
    case SIZE:
      if(stateMachineFirstCycle) {
        exporter.setPath(appName +"-size");
        stateMachineFirstCycle = false;
        useSize = true;
      }
      
      for (Mover mv : movers) {
        mv.update();
        mv.display();
      }
    
      /* segmente in strecken abfahren 
       int start = 0;
       int end = 50;
       if(movers.size() > end) {
         for (int i = start; i<start+end; i++) {
           movers.get(i).display();
         }
       }
      */
      if(!record) {
        fill(255, 125);
        noStroke();
        pushMatrix();
        //translate(mouseX, mouseY);
        ellipse(mouseX, mouseY, 10, 10);
        //rect(0, 0, 10, 10);
        popMatrix();
      }
    break;
    

    case AUTOMATA:
      if(stateMachineFirstCycle) {
        stateMachineFirstCycle = false;
        exporter.setPath(appName +"-automata");
      }
    break;
    
    case SNAKE:
      if(stateMachineFirstCycle) {
        stateMachineFirstCycle = false;
        exporter.setPath(appName +"-snake");
      }
    break;
    
    
   }
}
