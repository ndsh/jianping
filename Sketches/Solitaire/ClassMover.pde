class Mover {
  PVector origin;
  float rotation;
  
  int p;
  int offset;
  
  long timestamp = 0;
  float size;
  
  
  Mover(PVector position) {
    origin = position.copy();
    //brs = new Brush();
    rotation = 2*frameCount/360.0*TWO_PI;
    //println(position);
    
    p = 0;
    offset = 0;
    //size = 20+(origin.x/4);
    size = (int)map(origin.x, 0, width,  60, 200);
    
  }

  void update() {
    step();
  }
  
  void display() {
    push();
    translate(origin.x, origin.y);
    imageMode(CENTER);
    if(rotateTiles) rotate(rotation);
    if(!useSize) image(img.get((p+offset) % nPics), 0, 0);
    else image(img.get((p+offset) % nPics), 0, 0, size, size); // mit resize
    
    pop();
  }
  
  void delete() {
     //brs.clear();
  }
   
  void randomOffset() {
    p = (int)random(img.size()-1);
  }
  void step() {
    if(millis() - timestamp > stepDebounce) {
      timestamp = millis();
      p = (p+1) % nPics;
      //p += 1;
      //p %= nPics;
      offset = 0;
      
    }
  }
  
  PVector getPosition() {
    return origin;
  }
  
  void setPosition(int x, int y) {
    origin.x = x;
    origin.y = y;
  }
  
  PImage getImage() {
    return img.get((p+offset) % nPics);
  }
}
