import processing.video.*;
Movie mov;
Importer importer;
Exporter exporter;
SuperResource resource;

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


// exportMode 2 index walker
int filesetIndex = 0;

// timing array vars
//long timestamp = 0;
int timingIndex = 0;
boolean timingCheckpoint = false;
int lastFrame = 0;

// export vars
boolean record = true;

// some globals
PImage img;
PImage target;
PVector[][] imgb;

// qtree helper functions
Quadtree qtreeExec() {
    Quadtree tree = new Quadtree();
    tree.setBackground(treeBG);
    tree.prepare_image();
    tree.processImage();
    image(tree.getBuffer(), 0, 0, width, height);
    return tree;
}

void cleanUp(Quadtree tree) {
  if(record) exporter.export(tree.getBuffer());
  delay(5);
  System.gc();
}



// movie functions + variables
int newFrame = 0;

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


float[] calculateAspectRatioFit(float srcWidth, float srcHeight, float maxWidth, float maxHeight) {
    //float[] result;
    float ratio = Math.min(maxWidth / srcWidth, maxHeight / srcHeight);
    float result[] = {srcWidth*ratio, srcHeight*ratio};
    //return { width: srcWidth*ratio, height: srcHeight*ratio };
    return result;
 }

// unused var
String date = year() +""+ nf(month(), 2) +""+ nf(day(), 2) +""+ nf(hour(), 2) +""+ nf(minute(), 2) +""+ nf(second(), 2);
