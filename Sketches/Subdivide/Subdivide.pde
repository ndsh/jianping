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

void setup() {
  size(600, 600);
  pg = createGraphics(2000, 2000);
  
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
  
  grid.display();
  pg.endDraw();
  image(pg, 0, 0, width, height);
}
