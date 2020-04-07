/*
  150x150px
  Zeilenhöhe: 300px
*/

Importer importer;
SuperResource resource;
int[] superAsset = {25, 1, 2, 3};
String[] superAssetNames = {"jianping-black-letters", "jianping-letters"};
PGraphics pg;

PFont font;

int interval = 33;
long timestamp = 0;
int counter = 0;

void setup() {
  size(1000, 1000, P2D);
  font = loadFont("Theinhardt-Medium-36.vlw");
  
  
  surface.setLocation(0, 0);
  
  
  importer = new Importer("../../Assets");
  //println(importer.getFolders());
  //resource = new SuperResource();
  //resource.setMethod(1);
  //resource.setResources(superAssetNames);
  //resource.loadResources();
  //for(int i = 0; i<importer.getFolders().size(); i++) {
    //String[] split = (importer.getFolders().get(i), "_");
    
    
  //}
  int totalHeight = (importer.getFolders().size())*300;
  
  pg = createGraphics(3840, totalHeight);
  pg.beginDraw();
  pg.textFont(font);
  pg.textSize(36);
  pg.imageMode(CENTER);
  float[] aspect = {0, 0};
  aspect = calculateAspectRatioFit(pg.width, pg.height, 1000, 1000);
  surface.setSize((int)aspect[0], (int)aspect[1]);
  
  //println("currentIndex = " + resource.getCurrentIndex());
  //println("currentFile = " + resource.getCurrentFilename());
  pg.fill(0);
  pg.endDraw();
  
}

void draw() {
  pg.beginDraw();
  pg.background(240, 240, 240);
  // i = 1 damit wir _ALT überspringen
  
  for(int i = 0; i<importer.getFolders().size(); i++) {
    importer.loadFiles(importer.getFolders().get(i));
    //for(int k = 0; k<
    pg.push();
    pg.translate(40, 300*i+(300));
    pg.text(importer.getFolders().get(i), 0, -150);
    pg.push();
    pg.translate(500, -150);
    if(importer.getFiles().size() > 0) {
      for(int k = 0; k<(importer.getFiles().size() < 20?importer.getFiles().size():20); k++) {
        PImage p = loadImage(importer.getFiles().get(k));
        float[] aspect = calculateAspectRatioFit(p.width, p.height, 150, 150);
        pg.translate(aspect[0], 0);
        pg.image(p, 0, 0, aspect[0], aspect[1]);
      }
    }
    pg.pop();
    System.gc();
    
    pg.pop();
  }
  pg.endDraw();
  image(pg, width, height);
  String[] out = importer.getFolders().array();
  for(int i = 0; i<out.length; i++) out[i] = "["+ i +"] " + out[i];
  pg.save("export/output.png");
  saveStrings("export/output.txt", out);
  exit();
}


void keyPressed() {
  // SPACE to save
  if (keyCode == RIGHT) {
     //resource.update();
     println("-------");
      println(resource.getFilenames());
      
      println("-------");
      background(255);
  }
}

float[] calculateAspectRatioFit(float srcWidth, float srcHeight, float maxWidth, float maxHeight) {
    //float[] result;
    float ratio = Math.min(maxWidth / srcWidth, maxHeight / srcHeight);
    float result[] = {srcWidth*ratio, srcHeight*ratio};
    //return { width: srcWidth*ratio, height: srcHeight*ratio };
    return result;
 }
