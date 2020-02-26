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
      exporter.setPath(appName +"-standard");
      
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
      exporter.setPath(appName +"-linear");
    
      if(xAxis <= width) addMover(xAxis, height/2);
      for (Mover mv : movers) {
        mv.display();
        mv.step();
      }
      if(xAxis <= width) xAxis += normalizedBorders[1];
    
    break;
    
    case FOLLOW:
      exporter.setPath(appName +"-follow");
    
      pg.beginDraw();
      //if(redrawBackground) pg.background(0);
      //pg.background(0);
      
      //if(xAxis <= width)
      //if(movers.size() < 100)
      
      
      if(movers.size() > 5) {
       //for (int i = 0; i<movers.size(); i += 2) movers.remove(i);
       movers.remove(movers.size()-1);
     }
     
      addMover(width/2, height/2);
      
      //mv.step();
      
      for (Mover mv : movers) {
        //mv.update();
        PVector position = mv.getPosition();
        mv.setPosition((int)position.x + normalizedBorders[1], (int)position.y);
        
        
        //mv.display();
        PImage p = mv.getImage();
        pg.push();
        pg.translate(mv.getPosition().x, mv.getPosition().y);
        pg.image(p, 0, 0);
        pg.pop();
      }
      pg.endDraw();
      
      //if(xAxis <= width)
      //xAxis += normalizedBorders[1];
      
      push();
      imageMode(CORNER);
      image(pg, 0, 0);
      pop();
     
     println("movers=" + movers.size());
    
    break;
    

    case AUTOMATA:
      exporter.setPath(appName +"-automata");
    break;
    
    case SNAKE:
      exporter.setPath(appName +"-snake");
    break;
    
    
   }
}
