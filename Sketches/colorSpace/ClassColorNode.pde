// a ColorNode holds information about its dominant hue, saturation and brightness
// this information we can use to sort a bunch of colornodes in a three-dimensional
// represantation of a asset set
class ColorNode {
  PImage p;
  //PVector dominant = new PVector(0, 0, 0);
  int[] dominant = new int[3];
  String filename;
  
  int[] normalizedBorders = {400, 400};
  // 0 = HSB
  // 1 = RGB
  ColorNode(String s) {
    p = loadImage(s);
    filename = s;
    assertDominance();
    //println("New node created with dominant values ( "+ dominant[0] + " / " + dominant[1] + " / " + dominant[2] + " ) from file:" + s);
  }
  
  void assertDominance() {
    getDominant(0);
    getDominant(1);
    getDominant(2);
  }
  
  String getName() {
    return filename;
  }
  
  void getDominant(int k) {
    IntList v = new IntList();
      
    p.loadPixels();
    for(int i = 0; i<p.width*p.height; i++) {
        color c = p.pixels[i];
        float value = 0;
        if(mode == 0) {
          if(k == 0) value = hue(c);
          else if(k == 1) value = saturation(c); 
          else if(k == 2) value = brightness(c);
        } else if(mode == 1) {
          if(k == 0) value = red(c);
          else if(k == 1) value = green(c); 
          else if(k == 2) value = blue(c);
        }
        v.append((int)value);
    }
    
    int lengthForSorting = 0;
    if(mode == 0) {
      if(k == 0)lengthForSorting = 361;
      else lengthForSorting = 101;
    } else if(mode == 1) {
      lengthForSorting = 256;
    } 
    long[] intermediate = new long[lengthForSorting];
    for(int i = 0; i<v.size(); i++) {
      int n  = v.get(i);
      if(n < lengthForSorting) intermediate[n] += 1;
    }
    int index = 0;
    int max = 0;
    for(int i = 0; i<intermediate.length; i++) {
      int value = (int)intermediate[i];
      if(value > max) {
        max = value;
        index = i;
      }
    }
    dominant[k] = (int)index;
  }
  
  int[] getPosition() {
    return dominant;
  }
  
  PImage getImage() {
    return p;
  }
  
  PImage getNormalizedImage() {
    // check which side is "longer"
    // then check if that side is smaller or bigger than the normalizedBorders
    
    float factor = 0;
    if(p.width > p.height) {
      if(p.width > normalizedBorders[1]) p.resize(normalizedBorders[1], 0); //factor = p.width-normalizedBorders[1];
      else p.resize(normalizedBorders[0], 0);
      
    } else {
      if(p.height > normalizedBorders[0]) p.resize(0, normalizedBorders[1]); //factor = p.height-normalizedBorders[0];
      else p.resize(0, normalizedBorders[0]);
    }
    return p;
    
  }
  
  void normalize() {
  }
}
