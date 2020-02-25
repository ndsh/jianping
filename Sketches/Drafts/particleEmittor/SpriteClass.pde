class Sprite {
  PImage p;
  PVector position;
  float acceleration;
  PVector wiggle;
  int spriteSize = 80;
  int mode = 0;
  
  Sprite(PImage _p) {
    p = _p;
    position = new PVector(random(0, width), height);
    acceleration = random(10, 100);
    wiggle = new PVector(random(0,20), 0, random(0, 20));
  }
  
  void update() {
    position.y -= acceleration;
    if(position.y < 0) {
      position.y = random(height, height+random(500));
      acceleration = random(10, 200);
      spriteSize = (int)random(50,100);
      mode = (int)random(2);
    }
  }
  
  void display() {
    push();
    translate(position.x + random(wiggle.x), position.y, random(wiggle.z));
    switch(mode) {
      case 0:
        blendMode(MULTIPLY);
      break;
      
      case 1:
        blendMode(DARKEST);
      break;
      
      case 2:
        blendMode(REPLACE);
      break;
      
    }
    image(p, 0, 0, spriteSize, spriteSize);
    pop();
  }
}
