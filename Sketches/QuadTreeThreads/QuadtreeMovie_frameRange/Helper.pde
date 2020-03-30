void keyPressed() {
  // SPACE to save
  if(keyCode == 32) {
//    save();
  } else if (key == 'r') {
      record = !record;
      println("record= " + record);
    }
}


final static int[] blends = {ADD, SUBTRACT, DARKEST, LIGHTEST, DIFFERENCE, EXCLUSION, MULTIPLY, SCREEN, OVERLAY, HARD_LIGHT, SOFT_LIGHT, DODGE, BURN};


// movie functions
void movieEvent(Movie m) {
  m.read();
}

void nextFrame() {
  if (newFrame < getLength() - 1) newFrame++;
  setFrame(newFrame);
}

int getFrame() {    
  return ceil(mov.time() * FPS) - 1;
}

void setFrame(int n) {
  mov.play();
    
  // The duration of a single frame:
  float frameDuration = 1.0 / mov.frameRate;
    
  // We move to the middle of the frame by adding 0.5:
  float where = (n + 0.5) * frameDuration; 
    
  // Taking into account border effects:
  float diff = mov.duration() - where;
  if (diff < 0) {
    where += diff - 0.25 * frameDuration;
  }
    
  mov.jump(where);
  mov.pause();  
}  

int getLength() {
  return int(mov.duration() * mov.frameRate);
}
