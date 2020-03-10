static final int INIT = 999;
static final int STANDARD = 0;
static final int LINEAR = 1;
static final int FOLLOW = 2;
static final int TURNING = 3;
static final int SMEAR = 4;
static final int ZIGZAG = 5;
static final int SINE = 6;
static final int SINE_SIZE = 7;
static final int SINE_MULTIPLE = 8;
static final int SINE_MULTIPLE_SIZE = 9;
static final int SIZE = 10;
static final int PATH = 11;
static final int AUTOMATA = 12;
static final int SNAKE = 13;
static final int GAUSSIAN = 14;

int maxStates = 12;

////////// STATE VARIABLES

// LINEAR
int xAxis = 0;
int yAxis = 0;
float inc = 0;

static final String[] stateNames = {
  "Standard", "Linear", "Follow",
  "Turning", "Smear", "Zigzag", "Sine", "Sine Size", "Sine Multiple",
  "Sine Multiple Size", "Size", "Path", "Automata", "Snake", "Gaussian"
};

String getStateName(int state) {
  return stateNames[state];
}


void stateMachine(int state) {
  pg.beginDraw();
  if(redrawBackground) pg.background(0);
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
    
      if(xAxis <= pg.width) addMover(xAxis, pg.height/2);
      for (Mover mv : movers) {
        mv.display();
        mv.step();
      }
      if(xAxis <= pg.width) xAxis += normalizedBorders[1];
    
    break;
    
    case FOLLOW:
      if(stateMachineFirstCycle) {
        stateMachineFirstCycle = false;
        
        int half = pg.width/trailLength;
        for(int i = 0; i<trailLength; i++) {
          movers.add(new Mover(new PVector(half*i, pg.height/2), imageIndex));
        } 
        println(movers.size());
        for(int i = 0; i<trailLength; i++) movers.get(i).setOffset(i);
        
        exporter.setPath(appName +"-follow");
        
      }
      
      mouseHistory.add(new PVector(mouseX * screenFactor, mouseY * screenFactor));
      if(mouseHistory.size() > trailLength) mouseHistory.remove(0);
      
      for(int i = 0; i<mouseHistory.size(); i++) {
        Mover m = movers.get(i);
        PVector p = m.getPosition();
        m.setPosition((int)mouseHistory.get(i).x, (int)mouseHistory.get(i).y);
        m.step();
        m.display();
      }     
    break;
    
    // WIP
    case TURNING:
       if(stateMachineFirstCycle) {
        stateMachineFirstCycle = false;
        int half = pg.width / trailLength;
        for(int i = 0; i<trailLength; i++) {
          movers.add(new Mover(new PVector(half*i, pg.height/2), imageIndex));
        } 
        println(movers.size());
        for(int i = 0; i<trailLength; i++) movers.get(i).setOffset(i);
        
        exporter.setPath(appName +"-turning");
        trailLength = 20;
      }
      PVector mouse = new PVector(mouseX * screenFactor, mouseY * screenFactor);
      PVector center = new PVector(pg.width/2, pg.height/2);
      mouse.sub(center);
  
      mouse.normalize();
      mouse.mult(50);
      mouseHistory.add(new PVector(-mouse.x, -mouse.y));
      if(mouseHistory.size() > trailLength) mouseHistory.remove(0);
      
      for(int i = 0; i<mouseHistory.size(); i++) {
        Mover m = movers.get(i);
        m.setPosition(pg.width/2+(int)mouseHistory.get(i).x*(mouseHistory.size()-i), pg.height/2+(int)mouseHistory.get(i).y*(mouseHistory.size()-i));
        println(mouseHistory.size()-i);
        m.step();
        m.display();
      }      
    break;
    
    case SMEAR:
      if(stateMachineFirstCycle) {
        stateMachineFirstCycle = false;
        addMover(pg.width/2, pg.height/2);
        exporter.setPath(appName +"-smear");
        
      }
      p = movers.get(0).getImage();
      //pg.beginDraw();
      pg.imageMode(CENTER);
      pg.image(p, pg.width/2, mouseY * screenFactor);
      //println(movers.get(0).getImage().width);
      pg.image(pg.get(), pg.width/2 - p.width, pg.height/2);
      //pg.endDraw();
      
      push();
      translate(width/2, height/2);
      imageMode(CENTER);
      image(pg, 0, 0);
      pop();
      
      movers.get(0).step();
    break;
    
       
    case ZIGZAG:
      if(stateMachineFirstCycle) {
        stateMachineFirstCycle = false;
        int half = pg.width/trailLength;
        for(int i = 0; i<trailLength; i++) {
          movers.add(new Mover(new PVector(half*i, pg.height/2), imageIndex));
        } 
        for(int i = 0; i<trailLength; i++) movers.get(i).setOffset(i);
        
        exporter.setPath(appName +"-zigzag");
        
      }
      
      mouseHistory.add(new PVector(0, yAxis));
      if(mouseHistory.size() > trailLength) mouseHistory.remove(0);
      
      for(int i = 0; i<mouseHistory.size(); i++) {
        if(i < movers.size()) {
          Mover m = movers.get(i);
          PVector p = m.getPosition();
          m.setPosition((int)p.x, (int)mouseHistory.get(i).y);
          m.step();
          m.display();
        }
      }
      p = movers.get(0).getImage();
      if(direction) yAxis += p.height;
      else yAxis -= p.height;
      
      if(yAxis < 0) direction = true;
      else if(yAxis >= pg.height) direction = false;
      
    break;
    
    case SINE:
      //https://processing.org/examples/sinewave.html
      // todo
      // mit größen mappen
      // weitere kurven
      // redraw an/aus
      if(stateMachineFirstCycle) {
        stateMachineFirstCycle = false;
        int half = pg.width/trailLength;
        for(int i = 0; i<trailLength; i++) {
          movers.add(new Mover(new PVector(half*i, pg.height/2), imageIndex));
        } 
        for(int i = 0; i<trailLength; i++) movers.get(i).setOffset(i);
        
        exporter.setPath(appName +"-sine");
        stateDuration = 5000;
      }
      if(millis() - sineTimestamp > sineSpeed) {
        sineTimestamp = millis();
        mouseHistory.add(new PVector(0, pg.height/2-sin(inc)*height));
        inc += sineInc;
        if(mouseHistory.size() > trailLength) mouseHistory.remove(0);
      }
      
      for(int i = 0; i<mouseHistory.size(); i++) {
        if(i < movers.size()) {
          Mover m = movers.get(i);
          PVector p = m.getPosition();
          //m.setPosition((int)p.x, (int)mouseHistory.get(i).y);
          m.setPosition((int)p.x, (int)mouseHistory.get(i).y);
          m.step();
          m.display();
        }
      }
      
      
      if(millis() - timestamp > stateDuration) {
        timestamp = millis();
        //setState(SINE_SIZE);
        //transitionStates();
      }
      
    break;
    
    case SINE_SIZE:
      //https://processing.org/examples/sinewave.html
      // todo
      // mit größen mappen
      // weitere kurven
      // redraw an/aus
      if(stateMachineFirstCycle) {
        println("comingFromTransition= "+ comingFromTransition);
        stateMachineFirstCycle = false;
        if(!comingFromTransition) {
          int half = pg.width/trailLength;
          for(int i = 0; i<trailLength; i++) {
            movers.add(new Mover(new PVector(half*i, pg.height/2), imageIndex));
          } 
          for(int i = 0; i<trailLength; i++) movers.get(i).setOffset(i);
        }
        exporter.setPath(appName +"-sine-size");
      }
      
      mouseHistory.add(new PVector(0, pg.height/2-sin(inc)*height));
      
      
      inc += sineInc;
      if(mouseHistory.size() >= trailLength) mouseHistory.remove(0);
      
      for(int i = 0; i<mouseHistory.size(); i++) {
        if(i < movers.size()) {
          Mover m = movers.get(i);
          float sizeCalc = map((int)mouseHistory.get(i).y, 1, height/2, 1, 150);
          if((int)mouseHistory.get(i).y > height/2) sizeCalc = map((int)mouseHistory.get(i).y, height/2, height, 150, 1); 
          //println(sizeCalc);
          m.setSize(sizeCalc);
          
        }
      }
      
      // calculate all sizes
      //println("movers #"+ mouseHistory.size());
      for(int i = 0; i<mouseHistory.size(); i++) {
        if(i < movers.size()) {
          Mover m = movers.get(i);
          PVector p = m.getPosition();
          //m.setPosition((int)p.x, (int)mouseHistory.get(i).y);
          m.setPosition((int)p.x, (int)mouseHistory.get(i).y);
          if((int)mouseHistory.get(i).y > 0 && (int)mouseHistory.get(i).y <= pg.height) {
          
          }
          
          m.step();
          m.display();
        }
      }
      //p = movers.get(0).getImage();
      
      
    break;
    
    case SINE_MULTIPLE:
      //https://processing.org/examples/sinewave.html
      // todo
      // mit größen mappen
      // weitere kurven
      // redraw an/aus
      sines = imageList.size();
      
      if(stateMachineFirstCycle) {
        stateMachineFirstCycle = false;
        int half = pg.width/trailLength;
        println("sines= "+ sines);
        for(int k = 0; k<sines; k++) {
          for(int i = 0; i<trailLength; i++) {
            movers.add(new Mover(new PVector(half*i, pg.height/2), k));
          }
        }
        for(int i = 0; i<trailLength*sines; i++) movers.get(i).setOffset(i);
        
        exporter.setPath(appName +"-sine-multiple");
        //stateDuration = 5000;
      }
      mouseHistory.add(new PVector(0, pg.height/2-sin(inc)*500));
      inc += sineInc;
      if(mouseHistory.size() > trailLength*sines) mouseHistory.remove(0);
        
      for(int k = 0; k<sines; k++) {
      
        //mouseHistory.add(new PVector(0, height/2-sin(-inc)*500));
      
        
        
        //println(trailLength*k + " => " + ((trailLength*k+trailLength)-1));
        
        for(int i = trailLength*k; i<(trailLength*k+trailLength)-1; i++) {
          Mover m = movers.get(i);
          PVector p = m.getPosition();
          if(mouseHistory.size() > i) {
            m.setPosition((int)p.x, (int)mouseHistory.get(i).y);
            m.step();
            m.display();
          }
        }
      }
      
      if(millis() - timestamp > stateDuration) {
        timestamp = millis();
        //setState(SINE_SIZE);
        //transitionStates();
      }
      
    break;
    
    case SINE_MULTIPLE_SIZE:
      //https://processing.org/examples/sinewave.html
      // todo
      // mit größen mappen
      // weitere kurven
      // redraw an/aus
      sines = imageList.size();
      
      if(stateMachineFirstCycle) {
        stateMachineFirstCycle = false;
        int half = pg.width/trailLength;
        println("sines= "+ sines);
        for(int k = 0; k<sines; k++) {
          for(int i = 0; i<trailLength; i++) {
            movers.add(new Mover(new PVector(half*i, pg.height/2), k));
          }
        }
        for(int i = 0; i<trailLength*sines; i++) movers.get(i).setOffset(i);
        
        exporter.setPath(appName +"-sine-multiple-size");
        //stateDuration = 5000;
      }
      mouseHistory.add(new PVector(0, pg.height/2-sin(inc)*500));
      inc += sineInc;
      if(mouseHistory.size() > trailLength*sines) mouseHistory.remove(0);
        
      for(int i = 0; i<mouseHistory.size(); i++) {
        if(i < movers.size()) {
          Mover m = movers.get(i);
          float sizeCalc = map((int)mouseHistory.get(i).y, 1, pg.height, 1, 150);
          //println(sizeCalc);
          m.setSize(sizeCalc);
          
        }
      }  
        
      for(int k = 0; k<sines; k++) {
      
        //mouseHistory.add(new PVector(0, height/2-sin(-inc)*500));
      
        
        
        //println(trailLength*k + " => " + ((trailLength*k+trailLength)-1));
        
        for(int i = trailLength*k; i<(trailLength*k+trailLength)-1; i++) {
          Mover m = movers.get(i);
          PVector p = m.getPosition();
          if(mouseHistory.size() > i) {
            m.setPosition((int)p.x, (int)mouseHistory.get(i).y);
            m.step();
            m.display();
          }
        }
      }
      
      if(millis() - timestamp > stateDuration) {
        timestamp = millis();
        //setState(SINE_SIZE);
        //transitionStates();
      }
      
    break;
    
    case PATH:
      if(stateMachineFirstCycle) {
        stateMachineFirstCycle = false;        
        exporter.setPath(appName +"-svg-path");
        svg2movers(svgFile);
      }
      for (Mover mv : movers) {
        mv.update();
        mv.display();
      }
    break;
    
    case SIZE:
      if(stateMachineFirstCycle) {
        exporter.setPath(appName +"-size");
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
   pg.endDraw();
   
}
