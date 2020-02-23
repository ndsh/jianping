// a ColorNode holds information about its dominant hue, saturation and brightness
// this information we can use to sort a bunch of colornodes in a three-dimensional
// represantation of a asset set
class ColorNode {
  PImage p;
  PVector dominant = new PVector(0, 0, 0);
  int mode = 0;
  // 0 = HSB
  // 1 = RGB
  ColorNode(String s, int m) {
    p = loadImage(s);
    mode = m;
    getDominant(0);
    getDominant(1);
    getDominant(2);
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
    //println(v.size());
    int[] intermediate = new int[360];
    //println(intermediate.length);
    for(int i = 0; i<v.size(); i++) {
      int n  = v.get(i);
      intermediate[n] += 1;
    }
    int index = 0;
    int max = 0;
    for(int i = 0; i<intermediate.length; i++) {
      int value = (int)intermediate[i];
      //println(i +"="+value);
      if(value > max) {
        max = value;
        index = i;
      }
    }
    //println(intermediate[index][0]);
    if(k == 0) dominant.x = index;
    else if(k == 1) dominant.y = index;
    else if(k == 2) dominant.z = index;
  }
  
  PVector getPosition() {
    return dominant;
  }
  
  PImage getImage() {
    return p;
  }
}
