ArrayList<Node> points = new ArrayList<Node>();
Importer importer;
PImage target;
String[] coordinates;
PGraphics pg;

ArrayList<ArrayList<PImage>> imageList = new ArrayList<ArrayList<PImage>>();
int imageIndex = 0;

int[] superAsset = {1};
int[] normalizedBorders = {50, 80};

int globalSizeLimit = 50;

void setup() {
  size(1400, 1400, P2D);
  surface.setLocation(0, 0);
  
  target = loadImage("import/20200319124038.jpg");
  
  pg = createGraphics(3400, 3400, P2D);
  pg.beginDraw();
  pg.background(255);
  
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
  
  coordinates = loadStrings("import/file_4.txt");
  String[] split = null;
  println(coordinates.length);
  int x = 0;
  int y = 0;
  int w = 0;
  int h = 0;
  
  for(int i = 0; i<coordinates.length; i++) {
    //println(coordinates[i]);
    split = split(coordinates[i], ",");
    
    x = parseInt(split[4]);
    y = parseInt(split[5]);
    w = parseInt(split[2]);
    h = parseInt(split[3]);

    points.add(new Node(x, y, w, h, imageIndex));
    imageIndex++;
    imageIndex %= imageList.get(0).size();
  }
  pg.endDraw();
  
}

void draw() {
  background(90);
  pg.beginDraw();
  pg.background(90);
  
  for(int i = 0; i<points.size(); i++) {
    Node n = points.get(i);
    n.update();
    n.display();
  }
  
  
  
  
  
  pg.endDraw();
  image(pg, 0, 0, width, height);
  
  /*
  pg.push();
  pg.blendMode(SCREEN);
  pg.image(target, 0, 0);
  pg.pop();
  */
  
  
} 
