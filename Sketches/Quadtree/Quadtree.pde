StringList coordinates;

PVector[][] imgb;

String foldername = "targets/";
String filename = "exhibitionTitle_widescreen_black_square";
String fileext = ".jpg";


Importer importer;
Exporter exporter;
String appName = "quadtree";
int FPS = 30;
boolean record = true;

//String exportPath = "../Drafts/qtreeLoader/import/";
String exportPath = "export/text/";
String textFileOutput = "file.txt";
String date = year() +""+ nf(month(), 2) +""+ nf(day(), 2) +""+ nf(hour(), 2) +""+ nf(minute(), 2) +""+ nf(second(), 2);


// another example
final static String pattern_prefix = "assets/printmarks/pm";
final static String file_ext = ".png";
final static int pattern_init = 0; // starting number
final static int pattern_length = 80; // how many images from the set
final static int pattern_size = 2; // number of digits

// choose method of mapping
int mode = ABS_MODE;  // list below AVG_MODE, ABS_MODE, DIST_MODE


// standard
// THR = 20, MINR = 4, iter = 4, blocks = 10
int THR = 10; // higher value bigger rectangles (1..200)
int MINR = 450; // minimum block (4..200)

int[] minrSteps = {500, 450, 400, 350, 300, 250, 200, 180, 160, 120, 100, 80, 60, 40, 30, 20, 10, 8, 6, 4, 3, 2, 1};
int stepIndex = 0;
/*
int THR = 20; // higher value bigger rectangles (1..200)
int MINR = 4; // minimum block (4..200)
*/

int number_of_iterations = 1; // more = more variety
int number_of_blocks = 1; // more = more search tries

// MODEs LIST
final static int AVG_MODE = 0; // worst matching, difference of avgs of the luma
final static int ABS_MODE = 1; // difference of the luma each pixel
final static int DIST_MODE = 2; // best matching, distance between pixels colors (vectors)

int max_display_size = 1000; // viewing window size (regardless image size)

boolean do_blend = false; // blend image after process
int blend_mode = OVERLAY; // blend type
boolean done = false;

// working buffer
PGraphics buffer;

// image
PImage img;

String sessionid;

ArrayList<LImage> imgsb = new ArrayList<LImage>();
HashMap<String, ArrayList<Part>> parts = new HashMap<String, ArrayList<Part>>();

void setup() {
  coordinates = new StringList();
  //size(3200, 1000);
  size(800, 250);
  
  sessionid = hex((int)random(0xffff),4);
  img = loadImage(foldername+filename+fileext);

  buffer = createGraphics(img.width, img.height);
  buffer.smooth(8);
  buffer.beginDraw();
  buffer.noStroke();
  buffer.background(0);
  buffer.endDraw();

  //surface.setSize(neww, newh);
  surface.setLocation(0, 0);
  
  importer = new Importer("../../Assets");
  if(importer.getFolders().size() > 0) {
    importer.loadFiles(importer.getFolders().get(6));
  }
  
  exporter = new Exporter(FPS);
  exporter.setPath(appName);
  exporter.setLimit(minrSteps.length);
  
  //processImage();
  background(0);
  prepare_image();
  
}

void draw() {
  if(stepIndex < minrSteps.length) {
    MINR = minrSteps[stepIndex];
    textFileOutput = "file_"+ MINR +".txt";
    processImage();
    image(buffer, 0, 0, width, height);
    if(record) exporter.export(buffer);
    stepIndex++;
  }
}
