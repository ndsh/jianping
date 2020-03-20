class Node {

  int x;
  int y;
  int tileWidth;
  int tileHeight;

  int state = 0;

  int img;
  int rotate = 0;

  int step = 0;
  
  Node[] children;
  boolean leaf;
  int depth = 0;
  color thisColor;
  
  long timestamp = 0;
  long interval = 20;

  Node(int _x, int _y, int _tileWidth, int _tileHeight, int _random, int _depth) {
    depth = _depth;
    children = new Node[4];
    leaf = true;
    
    interval = (int)random(70, 200);
    timestamp = millis();
    
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
    
    thisColor = averageColor(target, x, y, tileWidth, tileHeight);
    
    // unicolored approach
    
    // (1) split image area (x, y, w, h) into 4 parts
    // (2) get average color from all 4 parts in regards of target image
    // (3) if only one is diverging
    // (4) create a new node for that quadrant
    // (5) goTo (1)
    
    // (1)
    color c[] = new color[4];
    color g[] = new color[4];
    int tW = tileWidth/2;
    int tH = tileHeight/2;
    //println(x + " " + y  + " " + tW + " " + tH);
    c[0] = averageColor(target, x, y, tW, tH);
    c[1] = averageColor(target, x+tW, y, tW, tH);
    c[2] = averageColor(target, x+tW, y+tH, tileWidth, tH);
    c[3] = averageColor(target, x, y+tH, tW, tH);
    for(int i = 0; i<4; i++) {
      //c[i] = ( c[i]>>16&0xFF + c[i]>>8&0xFF + c[i]&0xFF ) / 3;
      g[i] = ( c[i]>>16&0xFF + c[i]>>8&0xFF + c[i]&0xFF ) / 3;
    }
    
    boolean allSame = true;
    //for(int i = 0; i<4; i++) {
      //if((i+1)<4) if(brightness(c[i]) != brightness(c[i+1])) allSame = false;
      //if(c[i] != c[i+1]) allSame = false;
    //}
    if(brightness(g[0]) !=  brightness(g[1]))  allSame = false;
    if(brightness(g[1]) !=  brightness(g[2]))  allSame = false;
    if(brightness(g[2]) !=  brightness(g[3])) allSame = false;
    
    
    //println(allSame);
    if(!allSame && depth < maxDepth) {
      points.add( new Node( x, y, tW, tH, img, depth+1));
      points.add( new Node( x+tW, y, tW, tH, img, depth+1));
      points.add( new Node( x+tW, y+tH, tW, tH, img, depth+1));
      points.add( new Node( x, y+tH, tW, tH, img, depth+1));
      leaf = false;
    }
    
    
    
    /*redSum += c>>16&0xFF;
      greenSum += c>>8&0xFF;
      blueSum += c&0xFF;
      */
    //println((red(c[0]) + green(c[0]) + blue(c[0])) / 3) 
    /*
    newPoints.add( new GridPoint(x, y, tW, tH, img) );
    newPoints.add( new GridPoint(x+tH, y, tW, tH, img) );
    newPoints.add( new GridPoint(x, y+tW, tW, tH, img) );
    newPoints.add( new GridPoint(x+tH, y+tW, tW, tH, img) );
    */
  }

  void update() {
  }

  void display() {
    if(brightness(thisColor) >= brightness(limitColor) && brightness(thisColor) < brightness(limitColor)+colorTolerance) {
      tri();
      //sprite();
      //colorTile();
      //spriteTile();
      //plain();
      step();
    } 
  }

  void step() {
    if(millis() - timestamp > interval) {
      timestamp = millis();
      step = (step+1) % imageList.get(step % imageList.size()).size();
    }
  }

  void subdivide(ArrayList<Node> newPoints) {
    int divideBy = 2;
    int tW = tileWidth/divideBy;
    int tH = tileHeight/divideBy;
    for (int i = 0; i<divideBy; i++) {
      for (int j = 0; j<divideBy; j++) {
        newPoints.add( new Node(x+(tW*i), y+(tH*j), tW, tH, img, 0) );
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
  
  int[] getPosition() {
    int[] pos = {(int)x, (int)y};
    return pos;
  }
  
  int[] getDimension() {
    int[] dim = {(int)tileWidth, (int)tileHeight};
    return dim;
  }
  
  boolean isLeaf() {
    return leaf;
  }

  
}
