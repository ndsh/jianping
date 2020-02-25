ArrayList<Integer> colors = new ArrayList<Integer>();
int gridX = 70; // gridX * gridY
int gridY = 70;
float marginX;
float marginY;
PImage p;
PGraphics pg;

PImage assets[] = new PImage[10];

long debounce = 200;
long timestamp = 0;

void setup() {
  size(1920, 1080);
  p = loadImage("bg4.jpg");
  pg = createGraphics(1920, 1080);
  
  marginX= width/gridX;
  marginY= height/gridY;
  
  for(int i = 0; i<assets.length; i++) {
    assets[i] = loadImage("assets/" + i + ".png");
  }
  pg.beginDraw();
  pg.background(255);
  pg.image(p, 0, 0);
  pg.ellipse(width/2, height/2, 200, 200);
  pg.endDraw();
  
  initList();
  fillList(pg);
  
  
}

void draw() {
  
  
  background(255);
  //p.loadPixels();
  //image(p, 0, 0);
  
  //drawGrid();
  
  pg.beginDraw();
  pg.background(255);
  pg.fill(255);
  pg.image(p, 0, 0);
  pg.ellipse(mouseX, mouseY, marginX, marginY);
  pg.endDraw();
  initList();
  fillList(pg);
  
  
  //image(pg, 0, 0); 
  
  // frameRate checken ob alles bullshit ist oder nicht :)
  //println(frameRate);
  if(millis() - timestamp > debounce) {
    
  drawAssets();
  }
  
  
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      gridX++;
      marginX = width/gridX;
      println("grid= " + gridX +" x " + gridY);
      initList();
      fillList(pg);
    } else if (keyCode == DOWN) {
      gridX--;
      if(gridX <= 1) gridX = 1;
      marginX = width/gridX;
      initList();
      fillList(pg);
      println("grid= " + gridX +" x " + gridX);
    } if (keyCode == RIGHT) {
      gridY++;
      marginY = height/gridY;
      println("grid= " + gridX +" x " + gridY);
      initList();
      fillList(pg);
    } else if (keyCode == LEFT) {
      gridY--;
      if(gridY <= 1) gridY = 1;
      marginY = height/gridY;
      initList();
      fillList(pg);
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
  _p.loadPixels();
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
  _p.loadPixels();
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

void drawAssets() {
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
