import controlP5.*;
import geomerative.*;

RShape grp;
RPoint[][] pointPaths;

ControlP5 cp5;
Importer importer;
Exporter exporter;

ArrayList<PImage> original_img = new ArrayList<PImage>();
ArrayList<ArrayList<PImage>> imageList = new ArrayList<ArrayList<PImage>>();
ArrayList<Mover> movers = new ArrayList<Mover>();
PImage marke;
PImage silhouette;
PImage p = null;
PGraphics pg;

String appName = "solitaire";

int stateMachine = INIT;
int FPS = 30;
int[] normalizedBorders = {200, 160};
ArrayList<PVector> mouseHistory = new ArrayList<PVector>();
int trailLength = 200;
int count = 0;
int nPics = 150;
int stateDuration = 0;
int stateIterator = 0;

long timestamp = 0;
long interval = 20;
long sineTimestamp = 0;
int stepDebounce = 20;
int sineSpeed = 20;
int globalSteps = 0;
int imageIndex = 0;

float scaleImages = 1;
float sineInc = 0.12;

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
boolean overlay = false;
int imageDraw = CENTER;
int sines = 0;

float screenFactor;

// a superAsset is a collection or rather concatenation of different assets
int[] superAsset = {24, 19, 16, 11, 7, 1, 5, 8, 2};
//int[] superAsset = {11, 24};
//int[] superAsset = {0, 1, 3, 6};




///// 
String svgFile = "daydream-02 .svg";
///// 




boolean superSequence = true;


/* * * * * * * * * * * * * 
  TODO
    [/] pimage in brush oder sogar ColorNode
    [ ] blendModes / alpha handling
*/

void setup() {
  //size(5000, 1000); // wand 1
  //size(8000, 1200); // volle auflösung
  size(3000, 450, P2D);
  pg = createGraphics(8000, 1200, P2D);
  
  RG.init(this);
  RG.ignoreStyles(false);
  
  RG.setPolygonizer(RG.ADAPTATIVE);
  
  screenFactor = pg.width/width;
  // MBP Resolution
  //size(1600, 500);
  colorMode(HSB, 360, 100, 100);
  
  if(imageDraw == CENTER) imageMode(CENTER);
  frameRate(FPS);
  marke = loadImage("tge.png");
  silhouette = loadImage("silhouette1.png");
  
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
  
  image(pg, 0, 0, width, height);
  if(overlay) {
    //beginDraw();
    pg.beginDraw();
    pg.push();
    pg.imageMode(CORNER);
    pg.image(silhouette, (3400 ), pg.height-(silhouette.height ), silhouette.width, silhouette.height);
    pg.pop();
    
    pg.push();
      pg.stroke(255);
      pg.translate(1600 , 0);
      pg.line(0, 0, 0, pg.height);
    pg.pop();
    
    pg.push();
      pg.stroke(255);
      pg.translate( (1600+3400), 0);
      pg.line(0, 0, 0, pg.height);
    pg.pop();
    
    pg.endDraw();
    
    
    push();
    imageMode(CORNER);
    image(silhouette, (3400 / screenFactor), height-(silhouette.height / screenFactor), silhouette.width / screenFactor, silhouette.height / screenFactor);
    pop();
    
    push();
      stroke(255);
      translate(1600 / screenFactor, 0);
      line(0, 0, 0, height);
    pop();
    
    push();
      stroke(255);
      translate( (1600+3400) / screenFactor, 0);
      line(0, 0, 0, height);
    pop();
    
    
    
  }
  if(record) exporter.export(pg);
  drawGUI();
}
