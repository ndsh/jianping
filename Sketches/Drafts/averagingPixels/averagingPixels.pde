ArrayList<Integer> colors = new ArrayList<Integer>();
int grid = 2; // grid * grid
float margin;
PImage p;

PImage assets[] = new PImage[10];

void setup() {
  size(600, 600);
  p = loadImage("sort4.jpg");
  margin = width/grid;
  
  for(int i = 0; i<assets.length; i++) {
    assets[i] = loadImage("assets/" + i + ".png");
  }
}

void draw() {
 
  //background(255);
  //p.loadPixels();
  image(p, 0, 0);
  
  //drawGrid();
  
  // frameRate checken ob alles bullshit ist oder nicht :)
  //println(frameRate);
  drawGridAssets();
  
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      grid++;
      margin = width/grid;
      println("grid= " + grid +" x " + grid);
      initList();
      fillList(p);
    } else if (keyCode == DOWN) {
      grid--;
      if(grid <= 1) grid = 1;
      margin = width/grid;
      initList();
      fillList(p);
      println("grid= " + grid +" x " + grid);
    } 
  }
}

void initList() {
  // delete old arrayList
  colors = new ArrayList<Integer>();
}

void fillList(PImage _p) {
  //_p.loadPixels();
  for(int y = 0; y<grid; y++) {
    for(int x = 0; x<grid; x++) {
      int avgRed = getAverageColor(_p, x*(int)margin, y*(int)margin, (int)margin, (int)margin, 0);
      //println("x/y= " + x + "/" +y + "= " + avgRed);
      int avgGreen = getAverageColor(_p, x*(int)margin, y*(int)margin, (int)margin, (int)margin, 1);
      int avgBlue = getAverageColor(_p, x*(int)margin, y*(int)margin, (int)margin, (int)margin, 2);
      colors.add(color(avgRed, avgGreen, avgBlue));
      //fill(color(avgRed, avgGreen, avgBlue));
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

color getAverageColor(PImage _p, int _x, int _y, int _w, int _h, int mode) {
  
  _p.loadPixels();
  float value = 0;
  color c;
  
  float sumValue = 0; 
  int counter = 0;
  float v = 0;
  for(int x = _x; x< (_x+_w); x++) {
    for(int y = _y; y< (_y+_h); y++) {
      c = _p.pixels[x+width*y];
      if(mode == 0) v = c >> 16 & 0xFF;
      else if (mode == 1) v = c >> 8 & 0xFF;
      else if (mode == 2) v = c & 0xFF;
      //println(v);
      //value = brightness(c);
      //println("--" + value);
      sumValue += v;
      counter++;
    }
  }
  //println((int)sumValue/counter);
  color average = (int)sumValue/counter;
  
  return average;
}

void drawGrid() {
  for(int i = 0; i<colors.size(); i++) {
    int x = i%grid;
    int y = i/grid;
    fill(colors.get(i));
    noStroke();
    rect(x*margin, y*margin, margin, margin);
  }
}

int getGridBrightness(int _x, int _y) {
  return colors.get(_x+grid*_y);
}

void drawGridAssets() {
  for(int i = 0; i<colors.size(); i++) {
    int x = i%grid;
    int y = i/grid;
    //int br = colors.get(i);
    //int index = (int)map(br, 0, 255, 0, 9);
    
    fill(colors.get(i));
    noStroke();
    rect(x*margin, y*margin, margin, margin);
    //if(index < 8) image(assets[index], x*margin, y*margin, margin, margin);
  }
}
