import peasy.*;
import java.util.*;

PeasyCam cam;

ArrayList<ColorNode> nodes = new ArrayList<ColorNode>();
int scaleX = 2000;
int scaleY = 2000;
int scaleZ = 2000;

boolean firstRun = true;
boolean p = true;
boolean center = true;

int mode = 1;
float r = scaleZ; 

void setup() {
  size(600, 600, P3D);
  surface.setLocation(0, 0);
  cam = new PeasyCam(this, scaleZ*4);
  cam.setWheelScale(0.2);
  cam.setMaximumDistance(1000000);
  
  if(mode == 0) colorMode(HSB, 360, 100, 100);
  
  
  background(255);
  
}

void draw() {
  if(p) perspective(PI/5, 1000/1000, 1, 1000000);
  background(255);
  init();
  
  drawCenter();
  
  for(int i = 0; i<nodes.size(); i++) {
    pushMatrix();
    float mX = 0;
    float mY = 0;
    float mZ = 0;
    if(mode == 0) {
      //mX = map(nodes.get(i).getPosition().x, 0, 360, -scaleX, scaleX);
      float hue = map(nodes.get(i).getPosition().x, 0, 360, 0.0, 6.28);
      float saturation = map(nodes.get(i).getPosition().y, 0, 100, -scaleZ, scaleZ);
      float brightness = map(nodes.get(i).getPosition().z, 0, 100, -scaleY, scaleY);
      
      println(brightness);
      
      mX = saturation * cos(hue); //nodes.get(i).getPosition().x;
      //mY = map(nodes.get(i).getPosition().y, 0, 360, -scaleY, scaleY);
      mZ = saturation * sin(hue);
      //mY = nodes.get(i).getPosition().y;
      //mZ = map(nodes.get(i).getPosition().z, 0, 360, -scaleZ, scaleZ);
      //mZ = nodes.get(i).getPosition().z;
      translate(mX, brightness, mZ);
      
      //translate(
    } else if(mode == 1) {
      mX = map(nodes.get(i).getPosition().x, 0, 255, -scaleX, scaleX);
      mY = map(nodes.get(i).getPosition().y, 0, 255, -scaleY, scaleY);
      mZ = map(nodes.get(i).getPosition().z, 0, 255, -scaleZ, scaleZ);
      translate(mX, mY, mZ);
    }
    
    scale(0.5);
    image(nodes.get(i).getImage(), 0, 0);
    popMatrix();
  }
  
}
