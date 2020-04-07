Importer importer;
SuperResource resource;
int[] superAsset = {25, 1, 2, 3};
String[] superAssetNames = {"jianping-black-letters", "jianping-letters"};

int interval = 33;
long timestamp = 0;
int counter = 0;

void setup() {
  size(1000, 1000, P2D);
  surface.setLocation(0, 0);
  
  importer = new Importer("../../Assets");
  println(importer.getFolders());
  resource = new SuperResource();
  resource.setMethod(1);
  resource.setResources(superAssetNames);
  resource.loadResources();
  
  //println("currentIndex = " + resource.getCurrentIndex());
  //println("currentFile = " + resource.getCurrentFilename());
  
  
}

void draw() {
  
  if(millis() - timestamp > interval) {
    timestamp = millis();
    //resource.update();
    //println("currentSize = " + resource.size());
    //background(255);
    
    if(counter < 5) {
     // println("-------");
     // println(resource.getFilenames());
      
    //  println("-------");
    }
    
    counter++;
  }
  int x = 0;
  int y = 0;
  for(int i = 0; i<resource.getImageList().size(); i++) {
    image(resource.getImageList().get(i), x, y, 20, 20);
    x += 20;
    
    if(x > width) {
      x = 0;
      y += 20;
    } else if(y > height) y = 0;
    //println(resource.getFilenames());
  }
  
  
}


void keyPressed() {
  // SPACE to save
  if (keyCode == RIGHT) {
      resource.update();
     println("-------");
      println(resource.getFilenames());
      
      println("-------");
      background(255);
  }
}
