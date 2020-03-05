import controlP5.*;

ControlP5 cp5;
Importer importer;
Exporter exporter;

ArrayList<PImage> original_img = new ArrayList<PImage>();
ArrayList<ArrayList<PImage>> imageList = new ArrayList<ArrayList<PImage>>();
ArrayList<Mover> movers = new ArrayList<Mover>();
PImage marke;
PImage p = null;

String appName = "solitaire";

int stateMachine = INIT;
int FPS = 30;
int[] normalizedBorders = {200, 200};
ArrayList<PVector> mouseHistory = new ArrayList<PVector>();
int trailLength = 200;
int count = 0;
int nPics = 150;
int stateDuration = 0;

long timestamp = 0;
long interval = 20;
int stepDebounce = 20;
int globalSteps = 0;
int imageIndex = 0;

float scaleImages = 1;

int loadingMode = 2;
boolean comingFromTransition = false;
boolean run = true;
boolean hideGui = false;
boolean view = false;
boolean firstRun = true;
boolean stateMachineFirstCycle = true;
boolean record = false;
boolean redrawBackground = true;
boolean rotateTiles = false;
boolean fadeBackground = false;
boolean globalStep = false;
boolean direction = false;
int imageDraw = CENTER;
int sines = 0;

// a superAsset is a collection or rather concatenation of different assets
int[] superAsset = {24, 19, 16, 11, 7};


/* * * * * * * * * * * * * 
  TODO
    [/] pimage in brush oder sogar ColorNode
    [ ] blendModes / alpha handling
*/

void setup() {
  size(3200, 1000);
  // MBP Resolution
  //size(1600, 500);
  colorMode(HSB, 360, 100, 100);
  
  if(imageDraw == CENTER) imageMode(CENTER);
  frameRate(FPS);
  marke = loadImage("tge.png");
  
  importer = new Importer("../../Assets");
  /*
  if(importer.getFolders().size() > 0) {
    importer.loadFiles(importer.getFolders().get(3));
  }
  */
  
  exporter = new Exporter(FPS);
  exporter.setPath(appName);

  initCP5(this);
  redrawBGCheckbox(y);
  hideGui(0);
  stateMachine = INIT;
  surface.setLocation(0, 0);
}


void draw() {
  if(!run) return;
  stateMachine(stateMachine);
  // to do
  
  if(record) exporter.export();
  drawGUI();
}
