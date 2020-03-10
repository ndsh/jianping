PVector speed, pos, size;
 
void setup() {
  size(500, 500);
  pos = new PVector(width, height).mult(0.5);
  size = new PVector(100, 50);
  rectMode(CENTER);
}
void draw() {
  background(255);
  fill(0);
  noStroke();
  speed = new PVector(mouseX, mouseY).sub(pos).mult(0.05);
  pos.add(speed);
  translate(pos.x, pos.y);
  //rotate(speed.heading());
  rotate(atan2(speed.y,speed.x));
  rect(0, 0, size.x, size.y);
}
