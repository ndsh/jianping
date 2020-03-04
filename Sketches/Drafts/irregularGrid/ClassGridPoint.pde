class GridPoint {
  
  float x;
  float y;
  float tileWidth;
  float tileHeight;
  
  int state = 0;
  
  int img;
  int rotate = 0;
  
  GridPoint(float _x, float _y, float _tileWidth, float _tileHeight, int _random) {
    if (random(1) > 0.8) {
        img = (int)random(10);
      } else {
        img = _random;
      }
    
    
    x = _x;
    y = _y;
    tileWidth = _tileWidth;
    tileHeight = _tileHeight;
    rotate = (int)random(2);
    
  }
  
  void update() {
  }
  
  void display() {
    //plain();
    //tri();
    sprite();
  }
  
  void subdivide(ArrayList<GridPoint> newPoints) {
    float tW = tileWidth/2;
    float tH = tileHeight/2;
    newPoints.add( new GridPoint(x, y, tW, tH, img) );
    newPoints.add( new GridPoint(x+tH, y, tW, tH, img) );
    newPoints.add( new GridPoint(x, y+tW, tW, tH, img) );
    newPoints.add( new GridPoint(x+tH, y+tW, tW, tH, img) );
  }
  
  void plain() {
    push();
    noFill();
    stroke(0);
    rect(x, y, tileWidth, tileHeight);
    fill(0);
    ellipse(x + tileWidth/2, y+tileHeight/2, 2, 2);
    pop();
  }
  
  int getImageIndex() {
    return img;
  }
  
  void tri() {
    push();
    fill(0);
    translate(x, y);
    rotate(radians(rotate*180));
    //println(r*90);
    beginShape(TRIANGLES);
    vertex(0,0);
    vertex(0+tileWidth, 0+tileHeight);
    vertex(0, 0+tileHeight);
    endShape();
    pop();
  }
  void sprite() {
    push();
    image(images[img], x, y, tileWidth, tileHeight);
    pop();
  }
}
