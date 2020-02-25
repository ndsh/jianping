ArrayList<Integer> colors = new ArrayList<Integer>();
int gridX = 100; // gridX * gridY
int gridY = 100;
float marginX;
float marginY;
PImage p;

PImage assets[] = new PImage[10];

long debounce = 200;
long timestamp = 0;

void setup() {
  size(1920, 1080);
  p = loadImage("bg4.jpg");
  marginX= width/gridX;
  marginY= height/gridY;
  
  for(int i = 0; i<assets.length; i++) {
    assets[i] = loadImage("assets/" + i + ".png");
  }
  initList();
  fillList(p);
}

void draw() {
  
  
  background(255);
  //p.loadPixels();
  //image(p, 0, 0);
  
  //drawGrid();
  
  // frameRate checken ob alles bullshit ist oder nicht :)
  //println(frameRate);
  if(millis() - timestamp > debounce) {
    
  //drawGridAssets();
  drawWiggleAssets();
  }
  
  
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      gridX++;
      marginX = width/gridX;
      println("grid= " + gridX +" x " + gridY);
      initList();
      fillList(p);
    } else if (keyCode == DOWN) {
      gridX--;
      if(gridX <= 1) gridX = 1;
      marginX = width/gridX;
      initList();
      fillList(p);
      println("grid= " + gridX +" x " + gridX);
    } if (keyCode == RIGHT) {
      gridY++;
      marginY = height/gridY;
      println("grid= " + gridX +" x " + gridY);
      initList();
      fillList(p);
    } else if (keyCode == LEFT) {
      gridY--;
      if(gridY <= 1) gridY = 1;
      marginY = height/gridY;
      initList();
      fillList(p);
      println("grid= " + gridX +" x " + gridX);
    } 
    timestamp = millis();
  } else {
    if (key == 'q' || key == 'Q') {
      
    } else if (key == 'e' || key == 'E') {
      
    }
  }
}

void initList() {
  // delete old arrayList
  colors = new ArrayList<Integer>();
}

void fillList(PImage _p) {
  loadPixels();
  for(int y = 0; y<gridY; y++) {
    for(int x = 0; x<gridX; x++) {
      color getAverage = getAverageBrightness(_p, x*(int)marginX, y*(int)marginY, (int)marginX, (int)marginY);
      colors.add(getAverage);
      //fill(getAverage);
      //noStroke();
      //rect(x*margin, y*margin, margin, margin);
    }
  }
}

// returns the average brightness of a bunch of pixels in a square
color getAverageBrightness(PImage _p, int _x, int _y, int _w, int _h) {
  loadPixels();
  float value = 0;
  color c;
  
  float sumBrightness = 0; 
  int counter = 0;
  
  for(int x = _x; x< (_x+_w); x++) {
    for(int y = _y; y< (_y+_h); y++) {
      c = _p.pixels[x+width*y];
      value = brightness(c);
      sumBrightness += value;
      counter++;
    }
  }
  
  color average = (int)sumBrightness/counter;  
  return average;
}

void drawGrid() {
  for(int i = 0; i<colors.size(); i++) {
    int x = i%gridX;
    int y = i/gridY;
    fill(colors.get(i));
    noStroke();
    rect(x*marginX, y*marginY, marginX, marginY);
  }
}

int getGridBrightness(int _x, int _y) {
  return colors.get(_x+gridX*_y);
}

void drawGridAssets() {
  for(int i = 0; i<colors.size(); i++) {
    int x = i%gridX;
    int y = i/gridY;
    int br = colors.get(i);
    int index = (int)map(br, 0, 255, 0, 9);
    
    //fill(colors.get(i));
    //noStroke();
    //rect(x*margin, y*margin, margin, margin);
    if(index < 8) image(assets[(index+(int)random(9))%10], x*marginX, y*marginY, marginX, marginY);
  }
}

void drawWiggleAssets() {
  for(int i = 0; i<colors.size(); i++) {
    int x = i%gridX;
    int y = i/gridY;
    int br = colors.get(i);
    int index = (int)map(br, 0, 255, 0, 9);
    
    //fill(colors.get(i));
    //noStroke();
    //rect(x*margin, y*margin, margin, margin);
    if(index < 8) image(assets[index], x*marginX, y*marginY, marginX, marginY);
  }
}
