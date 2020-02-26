class Mover {
  Brush brs;
  PVector origin;
  float rotation;
  
  //int count = -1;

  Mover(PVector position) {
    origin = position.copy();
    brs = new Brush();
    rotation = random(90);
    //println(position);
    brs.randomize();
  }

  void display() {
    brs.step();
    push();
    //translate(origin.x, origin.y, (origin.y/2));
    translate(origin.x, origin.y, origin.z);
    //rotate(radians(rotation));
    brs.display();
    pop();
  }
  
   void delete() {
     //brs.clear();
   }
}
