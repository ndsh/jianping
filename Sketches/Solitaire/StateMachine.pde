static final int INIT = 999;
static final int STANDARD = 0;
static final int LINEAR = 1;
static final int FOLLOW = 2;
static final int ROWS = 3;
static final int ZIGZAG = 4;
static final int WAVE = 5;
static final int AUTOMATA = 6;
static final int SNAKE = 7;
static final int GAUSSIAN = 8;

int maxStates = 3;

////////// STATE VARIABLES

// LINEAER
PGraphics pg;
int xAxis = 0;
int yAxis = 0;


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
      }
      
      //PImage p = movers.get(0).getImage();
      //PImage p = movers.get(0).getImage();
      
      pg.beginDraw();
      pg.imageMode(CENTER);
      //pg.translate(pg.width/2 - 70, pg.height/2);
      
      pg.image(movers.get(0).getImage(), width/2, mouseY);
      //pg.image(
      //p = pg.get();
      pg.image(pg.get(), width/2 - 70, height/2);
      
      pg.endDraw();
      
      push();
      translate(width/2, height/2);
      imageMode(CENTER);
      image(pg, 0, 0);
      pop();
      
      
      //if(xAxis < 0) xAxis = pg.width;
      
      //println(xAxis);
     // xAxis %= width;
      //movers.get(0).display();
      movers.get(0).step();
      
    
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
