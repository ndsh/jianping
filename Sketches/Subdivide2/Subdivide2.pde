ArrayList<Node> points = new ArrayList<Node>();
PImage[] images = new PImage[10];
Importer importer;
IrregularGrid grid;
// Insert draw functions

ArrayList<ArrayList<PImage>> imageList = new ArrayList<ArrayList<PImage>>();

int imageIndex = 0;

PImage target;
PGraphics pg;

// the color that we consider "not worth changing"
color baseColor = color(0, 0, 0);
// tolerance from baseColor to our averageColor
int tolerance = 20;
int threshold = 80;

int[] superAsset = {1};

int depthStep = 0;
int depth = 0;
int maxDepth = 6;

color limitColor = color(0);
float colorTolerance = 100;

boolean onByOne = false;

void setup() {
  size(900, 600, P2D);
  pg = createGraphics(900, 600, P2D);
  pg.noStroke();
  
  importer = new Importer("../../Assets");
  for (int j = 0; j <superAsset.length; j++) {
    imageList.add(new ArrayList<PImage>());
    
    importer.loadFiles(importer.folders.get(superAsset[j]));
    println(importer.getFiles().get(0));
    
    for (int i = 0; i <importer.getFiles().size(); i++) {
      imageList.get(j).add(loadImage(importer.getFiles().get(i)));
      //original_img.add(loadImage(importer.getFiles().get(i)));
    }
  }
  
  target = loadImage("target.jpg");
  
  for(int i = 0; i<images.length; i++) images[i] = loadImage("pm"+i+".png");
  grid = new IrregularGrid();

  surface.setLocation(0, 0);
  
}

void draw() {
  background(255);
  pg.beginDraw();
  pg.background(255);
  grid.display();
  pg.endDraw();
  image(pg, 0, 0, width, height);
}
