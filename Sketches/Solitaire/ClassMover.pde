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
    pg.push();
    pg.translate(origin.x, origin.y);
    pg.imageMode(CENTER);
    if(rotateTiles) pg.rotate(rotation);
    //if(size == 0)
    //if(size == 0) image(imageList.get(imageIndexInternal).get((p+offset) % imageList.get(imageIndexInternal).size()), 0, 0);
    //else image(imageList.get(imageIndexInternal).get((p+offset) % imageList.get(imageIndexInternal).size()), 0, 0, (int)size, (int)size);
    //image(imageList.get(imageIndexInternal).get((p+offset) % imageList.get(imageIndexInternal).size()), 0, 0, imageList.get(imageIndexInternal).get((p+offset)).width *scaleImages, imageList.get(imageIndexInternal).get((p+offset)).height*scaleImages);
    //PImage pp = imageList.get(imageIndexInternal).get((p+offset) % imageList.get(imageIndexInternal).size());
    float[] newDimensions = calculateAspectRatioFit(
      imageList.get(imageIndexInternal % imageList.size()).get((p+offset) % imageList.get(imageIndexInternal % imageList.size()).size()).width,
      imageList.get(imageIndexInternal % imageList.size()).get((p+offset) % imageList.get(imageIndexInternal % imageList.size() ).size()).height,
      size*scaleImages,
      size*scaleImages
    );
    
    //pg.image(imageList.get(imageIndexInternal).get((p+offset) % imageList.get(imageIndexInternal).size()), 0, 0, (int)size*scaleImages, (int)size*scaleImages);
    /*
    pg.push();
    pg.noStroke();
    pg.beginShape();
    pg.texture(imageList.get(imageIndexInternal).get((p+offset) % imageList.get(imageIndexInternal).size()));
    pg.vertex(0, 0, 0, 0);
    pg.vertex(newDimensions[0], 0, newDimensions[0], 0);
    pg.vertex(newDimensions[0], newDimensions[1], newDimensions[0], newDimensions[1]);
    pg.vertex(0, newDimensions[1], 0, newDimensions[1]);
    pg.endShape();
    pg.pop();
    */
    pg.image(imageList.get(imageIndexInternal % imageList.size()).get((p+offset) % imageList.get(imageIndexInternal % imageList.size()).size()), 0, 0, newDimensions[0], newDimensions[1]);
    //pg.image(imageList.get(imageIndexInternal).get((p+offset) % imageList.get(imageIndexInternal).size()), 0, 0);
    
    
    pg.pop();
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
      p = (p+1) % imageList.get(imageIndexInternal % imageList.size()).size();
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
