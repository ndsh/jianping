class Mover {
  PVector origin;
  float rotation;
  
  int p;
  int offset;
  
  long timestamp = 0;
  float size;
  
  float opacity = 1;
  
  int imageIndexInternal = 0;
  
  
  Mover(PVector position, int index) {
    imageIndexInternal = index;
    
    //println(imageList.get(imageIndexInternal).size());
    origin = position.copy();
    //brs = new Brush();
    rotation = 2*frameCount/360.0*TWO_PI;
    //println(position);
    
    p = 0;
    offset = 0;
    //size = 20+(origin.x/4);
    //size = (int)map(origin.x, 0, width,  60, 200);
    size = normalizedBorders[0]/2;
    
  }

  void update() {
    step();
  }
  
  void display() {
    push();
    translate(origin.x, origin.y);
    imageMode(CENTER);
    if(rotateTiles) rotate(rotation);
    //if(size == 0)
    //if(size == 0) image(imageList.get(imageIndexInternal).get((p+offset) % imageList.get(imageIndexInternal).size()), 0, 0);
    //else image(imageList.get(imageIndexInternal).get((p+offset) % imageList.get(imageIndexInternal).size()), 0, 0, (int)size, (int)size);
    //image(imageList.get(imageIndexInternal).get((p+offset) % imageList.get(imageIndexInternal).size()), 0, 0, imageList.get(imageIndexInternal).get((p+offset)).width *scaleImages, imageList.get(imageIndexInternal).get((p+offset)).height*scaleImages);
    image(imageList.get(imageIndexInternal).get((p+offset) % imageList.get(imageIndexInternal).size()), 0, 0, (int)size*scaleImages, (int)size*scaleImages);
    
    pop();
  }
  
  void delete() {
     //brs.clear();
  }
   
  void randomOffset() {
    p = (int)random(imageList.get(imageIndexInternal).size()-1);
  }
  
  void setOffset(int o) {
    p = o;
  }
  void step() {
    if(millis() - timestamp > stepDebounce) {
      timestamp = millis();
      p = (p+1) % imageList.get(imageIndexInternal).size();
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
    return imageList.get(imageIndexInternal).get((p+offset) % imageList.get(imageIndexInternal).size());
  }
  
  void setSize(float _size) {
    size = _size;
  }
}
