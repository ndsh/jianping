import peasy.*;
import java.util.*;
import controlP5.*;

PeasyCam cam;
ControlP5 cp5;
Importer importer;
Exporter exporter;

ArrayList<ColorNode> nodes = new ArrayList<ColorNode>();
PImage marke;

String appName = "colorspace";

int componentMin[] = new int[3];
int componentMax[] = new int[3];
int linearLimit = 360;
int linearIndex = 0;
int componentIndex = 0;
int linearCycleMode = 0;
int mode = 0;
int imageDraw = 0;
int FPS = 30;
int scaleX = 2000;
int scaleY = 2000;
int scaleZ = 2000;

long timestamp = 0;
long interval = 1;
float rotationSpeed = 0.001;
float r = scaleZ;
float lastMouseY = 0;
float scaleImages = 1;

boolean firstRun = true;
boolean isRunnable = false;
boolean hideGui = false;
boolean record = false;
boolean center = true;
boolean rotate = false;
boolean filter = true;
boolean presentation = true;
boolean redrawBackground = false;
boolean mouseWasDragged = false;

/* * * * * * * * * * * * * 
  TODO
    [x] import images from folder
    [ ] export selected nodes into file
*/

void setup() {
  size(3200, 1000, P3D);
  frameRate(FPS);
  marke = loadImage("tge.png");
  surface.setLocation(0, 0);
  initCam(this);
    
  // dont change this line! lots of things will break if you do.
  colorMode(HSB, 360, 100, 100);
  initCP5(this);
  initRanges();
  
  importer = new Importer("../../Assets");
  if(importer.getFolders().size() > 0) {
    importer.loadFiles(importer.getFolders().get(1));
  }
  
  exporter = new Exporter(FPS);
  exporter.setPath(appName);
  
  redrawBGCheckbox(y);
  
}

void draw() {
  if(rotate) cam.rotateY(rotationSpeed);
  
  perspective(PI/5, width/height, 1, 1000000);
  if(mode == 0) {
    colorMode(HSB, 360, 100, 100);
    if(redrawBackground) background(0, 0, 100);
  } else if(mode == 1) {
    colorMode(RGB, 255);
    if(redrawBackground) background(255);
  }
  
  
  init();
  
  
  if(isRunnable) drawNodes();
  if(record) exporter.export();
  drawGUI();
}
