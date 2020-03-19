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
  
  float size;

  Node(int _x, int _y, int _tileWidth, int _tileHeight, int _offset) {
    
    children = new Node[4];
    leaf = true;
    
    interval = 150; //(int)random(70, 200);
    timestamp = millis();
    
    if (random(1) > 0.8) {
      img = (int)random(10);
    } else {
      //img = _random;
    }


    x = _x;
    y = _y;
    tileWidth = _tileWidth;
    tileHeight = _tileHeight;
    rotate = (int)random(2);
    //step = (int)random(imageList.get(0).size());
    step = _offset;
    interval = (int)map(tileWidth, 0, width, 30, 10000);
    size = normalizedBorders[0];
  }

  void update() {
    if(millis() - timestamp > interval) {
      timestamp = millis();
      step();
    }
  }

  void display() {
      //tri();
      //sprite();
      //colorTile();
      spriteTile();
      //plain();
      
  }

  void step() {
      step = (step+1) % imageList.get(step % imageList.size()).size();
  }

  void subdivide(ArrayList<Node> newPoints) {
    int divideBy = 2;
    int tW = tileWidth/divideBy;
    int tH = tileHeight/divideBy;
    for (int i = 0; i<divideBy; i++) {
      for (int j = 0; j<divideBy; j++) {
       // newPoints.add( new Node(x+(tW*i), y+(tH*j), tW, tH, img, 0) );
      }
    }

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

  /*void sprite() {
    push();
    image(images[img], x+2, y+2, tileWidth-2, tileHeight-2);
    pop();
  }*/
/*
  void colorTile() {
    color avg = averageColor(target, (int)x, (int)y, (int)tileWidth, (int)tileHeight);
    pg.push();
    pg.fill(avg);
    pg.noStroke();
    pg.rect(x, y, tileWidth, tileHeight);
    pg.pop();
  }
  */

  void spriteTile() {
    if(tileWidth < 40) {
      float[] newDimensions = calculateAspectRatioFit(
        imageList.get(0 % imageList.size()).get((step) % imageList.get(0 % imageList.size()).size()).width,
        imageList.get(0 % imageList.size()).get((step) % imageList.get(0 % imageList.size() ).size()).height,
        tileWidth,
        tileHeight
      );
      
      pg.push();
      pg.image(imageList.get(0 % imageList.size()).get((step) % imageList.get(0 % imageList.size()).size()), x, y, newDimensions[0], newDimensions[1]);
      pg.pop();
    }
  }

  void setOffset(int o) {
    step = o;
    step %= imageList.get(0 % imageList.size()).size();
  }
  /*
  color colorFromImage() {
    return averageColor(target, (int)x, (int)y, (int)tileWidth, (int)tileHeight);
  }
  */
  
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
  
     /**
  * Conserve aspect ratio of the original region. Useful when shrinking/enlarging
  * images to fit into a certain area.
  *
  * @param {Number} srcWidth width of source image
  * @param {Number} srcHeight height of source image
  * @param {Number} maxWidth maximum available width
  * @param {Number} maxHeight maximum available height
  * @return {Object} { width, height }
  */
  float[] calculateAspectRatioFit(float srcWidth, float srcHeight, float maxWidth, float maxHeight) {
    //float[] result;
    float ratio = Math.min(maxWidth / srcWidth, maxHeight / srcHeight);
    float result[] = {srcWidth*ratio, srcHeight*ratio};
    //return { width: srcWidth*ratio, height: srcHeight*ratio };
    return result;
 }

  
}
