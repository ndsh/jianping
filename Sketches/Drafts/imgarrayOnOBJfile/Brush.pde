class Brush {
  //PVector position;
  int p;
  int offset;
  
  long timestamp = 0;
  long interval = 0;
  
  boolean mouseOver = false;
  
  
  Brush() {
    //position = l.copy();
    p = 0;
    offset = 0;
    interval = (int)random(150, 400);
  
  }

  //void place(){

  //translate(x,y);

  //}

  void step() {
    if(millis() - timestamp > interval) {
      timestamp = millis();
      p = (p+1) % nPics;
      offset = 0;
    }
  } 

  void display() {
    //image(img[count], x, y, 100, 100);
    //image(img[(p+offset) % nPics], position.x, position.y, 100, 100);
   
   blendMode(ADD);
   image(img[(p+offset) % nPics], 0, 0, 50, 50);
   blendMode(MULTIPLY);
   image(img[(p+offset) % nPics], 0, 0, 50, 50);
   
    
  }
  
  void randomize() {
    p = (int)random(nPics);
  }
  
  boolean isHovered() {
    return true;    
  }
}
