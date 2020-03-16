class GridPoint {

  float x;
  float y;
  float tileWidth;
  float tileHeight;

  int state = 0;

  int img;
  int rotate = 0;

  int step = 0;

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
    step = (int)random(imageList.get(0).size());
  }

  void update() {
  }

  void display() {
    //plain();
    //tri();
    //sprite();
    colorTile();
    //spriteTile();
  }

  void step() {
    step = (step+1) % imageList.get(step % imageList.size()).size();
  }

  void subdivide(ArrayList<GridPoint> newPoints) {
    int divideBy = 2;
    float tW = tileWidth/divideBy;
    float tH = tileHeight/divideBy;
    for (int i = 0; i<divideBy; i++) {
      for (int j = 0; j<divideBy; j++) {
        newPoints.add( new GridPoint(x+(tW*i), y+(tH*j), tW, tH, img) );
      }
    }
    /*
    newPoints.add( new GridPoint(x, y, tW, tH, img) );
     newPoints.add( new GridPoint(x+tH, y, tW, tH, img) );
     newPoints.add( new GridPoint(x, y+tW, tW, tH, img) );
     newPoints.add( new GridPoint(x+tH, y+tW, tW, tH, img) );
     */
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
    vertex(0, 0);
    vertex(0+tileWidth, 0+tileHeight);
    vertex(0, 0+tileHeight);
    endShape();
    pop();
  }

  void sprite() {
    push();
    image(images[img], x+2, y+2, tileWidth-2, tileHeight-2);
    pop();
  }

  void colorTile() {
    color avg = averageColor(target, (int)x, (int)y, (int)tileWidth, (int)tileHeight);
    pg.push();
    pg.fill(avg);
    pg.noStroke();
    pg.rect(x, y, tileWidth, tileHeight);
    pg.pop();
  }

  void spriteTile() {
    pg.push();
    pg.image(imageList.get(0 % imageList.size()).get((step) % imageList.get(0 % imageList.size()).size()), x, y, tileWidth, tileHeight);
    pg.pop();
  }

  void setOffset(int o) {
    step = o;
    step %= imageList.get(0 % imageList.size()).size();
  }

  color colorFromImage() {
    return averageColor(target, (int)x, (int)y, (int)tileWidth, (int)tileHeight);
  }

  
}
