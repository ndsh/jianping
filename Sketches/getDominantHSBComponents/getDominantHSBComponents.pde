
import peasy.*;

PeasyCam cam;

ArrayList<ColorNode> nodes = new ArrayList<ColorNode>();
int scaleX = 2000;
int scaleY = 2000;
int scaleZ = 1000;

boolean firstRun = true;
boolean p = true;

void setup() {
  size(1000, 1000, P3D);
  surface.setLocation(200, 200);
  cam = new PeasyCam(this, 100);
  cam.setWheelScale(0.2);
  cam.setMaximumDistance(1000000);
  
  //colorMode(HSB, 360, 100, 100);
  
  
  background(255);
  
}

void draw() {
  if(p) perspective(PI/5, 1000/1000, 1, 1000000);
  background(255);
  init();
  
  for(int i = 0; i<nodes.size(); i++) {
    pushMatrix();
    float mX = map(nodes.get(i).getPosition().x, 0, 360, -scaleX, scaleX);
    float mY = map(nodes.get(i).getPosition().y, 0, 360, -scaleY, scaleY);
    float mZ = map(nodes.get(i).getPosition().z, 0, 360, -scaleZ, scaleZ);
    translate(mX, mY, mZ);
    scale(0.5);
    image(nodes.get(i).getImage(), 0, 0);
    popMatrix();
  }
  
}

void init() {
  if(firstRun) {
    firstRun = false;
    println("Adding nodes and calculating weights...");
    for(int i = 0; i<1000; i++) {
      //print("i="+ i +" => ");
      nodes.add(new ColorNode("y__"+i+".jpg", 1));
    }
    println("done!");
  }
}

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
    int[][] intermediate = new int[360][1];
    //println(intermediate.length);
    for(int i = 0; i<v.size(); i++) {
      intermediate[v.get(i)][0] += 1;
    }
    int index = 0;
    int max = 0;
    for(int i = 0; i<intermediate.length; i++) {
      int value = (int)intermediate[v.get(i)][0];
      //println(i +"="+value);
      if(value > max) {
        max = value;
        index = i;
      }
    }
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

/*
noStroke();
colorMode(HSB, 255);
color c = color(125, 126, 255);
fill(c);
rect(15, 20, 35, 60);
float value = hue(c);  // Sets 'value' to "0"
fill(value);
rect(50, 20, 35, 60);
*/

void keyPressed() {
    if (key == 'p') {
      p = !p;
      println("p= " + p);
    }
}
