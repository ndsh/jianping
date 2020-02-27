PVector[][] imgb;

String filename = "exhibitionTitle_widescreen_black";
String fileext = ".jpg";
String foldername = "./targets/";

Importer importer;
Exporter exporter;
String appName = "quadtree";
int FPS = 30;
boolean record = true;


// another example
final static String pattern_prefix = "assets/printmarks/pm";
final static String file_ext = ".png";
final static int pattern_init = 0; // starting number
final static int pattern_length = 99; // how many images from the set
final static int pattern_size = 2; // number of digits

// choose method of mapping
int mode = ABS_MODE;  // list below AVG_MODE, ABS_MODE, DIST_MODE

int THR = 20; // higher value bigger rectangles (1..200)
int MINR = 4; // minimum block (4..200)

int number_of_iterations = 4; // more = more variety
int number_of_blocks = 100; // more = more search tries

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
  size(3200, 1000);
  
  sessionid = hex((int)random(0xffff),4);
  img = loadImage(foldername+filename+fileext);

  buffer = createGraphics(img.width, img.height);
  buffer.smooth(8);
  buffer.beginDraw();
  buffer.noStroke();
  buffer.background(0);
  buffer.endDraw();

  // calculate window size
  float ratio = (float)img.width/(float)img.height;
  int neww, newh;
  if(ratio < 1.0) {
    neww = (int)(max_display_size * ratio);
    newh = max_display_size;
  } else {
    neww = max_display_size;
    newh = (int)(max_display_size / ratio);
  }

  //surface.setSize(neww, newh);
  surface.setLocation(0, 0);
  
  importer = new Importer("../../Assets");
  if(importer.getFolders().size() > 0) {
    importer.loadFiles(importer.getFolders().get(6));
  }
  
  exporter = new Exporter(FPS);
  exporter.setPath(appName);
  exporter.setLimit(1);
  
  processImage();
}

void draw() {
  if(done) {
    image(buffer, 0, 0, width, height);
    processImage();
    if(record) exporter.export(buffer);
  }  
}
