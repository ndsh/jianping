import controlP5.*;
ControlP5 cp5;
Slider2D s;


//String files[] = {"raster_21.jpg", "raster_36.jpg", "raster_58.jpg", "raster_80.jpg", "raster_91.jpg", "raster_93.jpg"};
String files[] = {"b_0.jpg", "b_1.jpg", "b_2.jpg", "b_3.jpg", "b_4.jpg", "b_5.jpg", "b_6.jpg", "b_7.jpg", "b_8.jpg", "b_9.jpg", };
PImage img;
PImage images[];
int count=0;
float tt=0;
PGraphics canvas;
float ran = random(10);
int cellID = 0;

void setup() {
  frameRate(60);
  size(1600, 600);

  cp5 = new ControlP5(this);
  constructGUI();

  images = new PImage[files.length];
  for (int i = 0; i<files.length; i++) images[i] = loadImage(files[i]);
  canvas = createGraphics(width, height);
  smooth();
  img = loadImage("raster_21.jpg");

  imageMode(CENTER);
  rectMode(CENTER);
  noStroke();
  println("setup");
}

void draw() {
  background(255);
  //cellID = 0;
  split0(canvas.width, canvas.height, cellID);
  count=0;
  
  tt+=1;
  //if(tt%20==0) ran = random(10);
  push();
  fill(0);
  rectMode(CORNER);
  rect(6, 6, width/10+9,height/10+20);
  pop();
}

void split0(int w, int h, int _cellID) {
  split1(0, 0, w, h, 0, _cellID);
}

void split1(int x, int y, int w, int h, int n, int _cellID) {
  randomSeed(int(count + ran));
  //println(int(count + ran));
  //println(random(1));
  // bisschen glitchy aber cooler effekt
  //if( (random(1.0)<0.2 && n>3) || n > ((tt*0.01)%20) ){
  if ( n > 4 ) {
    print("first ");
    // fizzBuzz abfrage
    if ((count+n)%2==0) {
      image(images[_cellID], x+w/2, y+h/2, w, h);
      println("=>" + _cellID);
      //fill(255);
      //rect(x+w/2, y+h/2, w, h);
      //ellipse(x+w/2, y+h/2, w, h);
    } else {
      println("=>" + _cellID);
      //fill(0);
      //rect(x+w/2, y+h/2, w, h);
      image(images[_cellID], x+w/2, y+h/2, w, h);
      //ellipse(x+w/2, y+h/2, w, h);
    }
  } else {
    //println("secondo");
    float rr = 0.5+0.5 * sin(s.getArrayValue()[0]*(tt*0.01));
    rr = Math.max(Math.min(rr, 1), 0);

    float ww = w*rr;
    float ww2 = w*(1-rr);

    rr = 0.5+0.5 * sin(s.getArrayValue()[1]*(tt*0.01));
    rr = Math.max(Math.min(rr, 1), 0);

    float hh = h*rr;
    float hh2 = h*(1-rr);


    if (count % 2 == 0) {
      
      split1(x, y, int(ww), h, n+1, _cellID);
      _cellID++;
      split1(int(x+ww), y, int(ww2), h, n+1, _cellID);
      _cellID++;
    } else {
      split1(x, y, w, int(hh), n+1, _cellID);
      _cellID++;
      split1(x, int(y+hh), w, int(hh2), n+1, _cellID);
      _cellID++;
    }
  }

  count++;
  // glitchy if(count > 30) count = 0;
}
