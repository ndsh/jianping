import controlP5.*;

ControlP5 cp5;
Importer importer;
Exporter exporter;

ArrayList<PImage> img = new ArrayList<PImage>();
ArrayList<Mover> movers = new ArrayList<Mover>();
PImage marke;

String appName = "solitaire";

int stateMachine = INIT;
int FPS = 30;
int[] normalizedBorders = {40, 300};
int count = 0;
int nPics = 150;

long timestamp = 0;
long interval = 20;
int stepDebounce = 20;
int globalSteps = 0;

boolean view = false;
boolean firstRun = true;
boolean record = false;
boolean redrawBackground = true;
boolean rotateTiles = false;
boolean fadeBackground = false;
boolean globalStep = false;
int imageDraw = CENTER;

/* * * * * * * * * * * * * 
  TODO
    [ ] pimage in brush oder sogar ColorNode
    [ ] blendModes / alpha handling
*/

void setup() {
  size(3200, 1000);
  colorMode(HSB, 360, 100, 100);
  
  if(imageDraw == CENTER) imageMode(CENTER);
  frameRate(FPS);
  marke = loadImage("tge.png");
  
  importer = new Importer("../../Assets");
  if(importer.getFolders().size() > 0) {
    importer.loadFiles(importer.getFolders().get(0));
  }
  
  exporter = new Exporter(FPS);
  exporter.setPath(appName);

  initCP5(this);
  stateMachine = INIT;
  surface.setLocation(0, 0);
}


void draw() {
  if(fadeBackground) {
    push();
    fill(0, 0, 0, 125);
    rect(0, 0, width, height);
    pop();
  }
  stateMachine(stateMachine);
  if(record) exporter.export();
  drawGUI();
}
