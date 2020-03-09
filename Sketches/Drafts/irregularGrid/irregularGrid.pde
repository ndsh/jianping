PImage[] images = new PImage[10]; 
IrregularGrid grid;
// Insert draw functions

void setup() {
  size(1600, 500);
  for(int i = 0; i<images.length; i++) images[i] = loadImage("pm"+i+".png");
  grid = new IrregularGrid();

  surface.setLocation(0, 0);
  
  
}

void draw() {
  background(255);
  grid.display();
}

color getAverageColor(PImage img){
  // create a scaled down version of the image
  // float maxSize = 10;
  // float scale = Math.max(maxSize/img.width, maxSize/img.height);
  // int newWidth = int(img.width*scale);
  // int newHeight = int(img.height*scale);
  // PImage imgSmall  = createImage(newWidth, newHeight, RGB);
  // imgSmall.copy(img,0,0, img.width, img.height, 0,0,imgSmall.width, imgSmall.height);

  // cycle through all pixels to create an average color
  // imgSmall.loadPixels();
  float[] all = new float[3]; 
  // int pixelCount = imgSmall.pixels.length;
  img.loadPixels();
  int pixelCount = img.pixels.length;

  for(int i=0;i<pixelCount; i++){
    // color c = imgSmall.pixels[i];
    color c = img.pixels[i];

    all[0] += c >> 16 & 0xFF;
    all[1] += c >> 8 & 0xFF;
    all[2] += c & 0xFF;
  }
  // averaging
  for(int i=0; i< all.length; i++){
    all[i] = Math.round(all[i]/pixelCount);
  }

  // return
  color averageColor = color (all[0], all[1], all[2]);
  // printColor(averageColor);
  return averageColor;
}
