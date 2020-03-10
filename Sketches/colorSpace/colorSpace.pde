import peasy.*;
import java.util.*;
import controlP5.*;

PeasyCam cam;
ControlP5 cp5;
Importer importer;
Exporter exporter;
AssetExporter assetExporter;

ArrayList<ColorNode> nodes = new ArrayList<ColorNode>();
PImage marke;
PGraphics pg;
PMatrix mat_scene; // to store initial PMatrix

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
  pg = createGraphics(3200, 1000, P3D);
  mat_scene = getMatrix();
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
    importer.loadFiles(importer.getFolders().get(3));
  }
  
  exporter = new Exporter(FPS);
  exporter.setPath(appName);
  
  assetExporter = new AssetExporter();
  
  redrawBGCheckbox(y);
  hideGui(0);
  
}

void draw() {
  if(rotate) cam.rotateY(rotationSpeed);
  
  pg.perspective(PI/5, width/height, 1, 1000000);
  pg.beginDraw();
  if(mode == 0) {
    pg.colorMode(HSB, 360, 100, 100);
    if(redrawBackground) pg.background(0, 0, 100);
  } else if(mode == 1) {
    pg.colorMode(RGB, 255);
    if(redrawBackground) pg.background(255);
  }
  pg.endDraw();
  
  init();
  
  
  if(isRunnable) drawNodes();
  push();
  imageMode(CORNER);
  setMatrix(mat_scene); // replace the PeasyCam-matrix

  image(pg, 0, 0, width, height);
  pop();
  if(record) exporter.export(pg);
  drawGUI();
}
