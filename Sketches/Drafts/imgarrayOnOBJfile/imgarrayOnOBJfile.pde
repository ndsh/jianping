import peasy.*;

PeasyCam cam;
Path path;

PImage img[];
ArrayList<Mover> movers;
int count = 0;
int nPics = 100;


long timestamp = 0;
long debounce = 50;

float scalePath = 3.0;
boolean hide = false;

PGraphics mask;

void setup() {
  size(1920, 1080, P3D);
  cam = new PeasyCam(this, 400);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(500);
  cam.setWheelScale(0.6);
  
  mask = createGraphics(50, 50);
  mask.beginDraw();
  mask.background(0);
  mask.fill(255);
  mask.ellipse(mask.width/2, mask.height/2, 50, 50);
  
  mask.endDraw();
  
  smooth();
  //background(0);
  imageMode(CENTER);
  frameRate(30);

  img = new PImage[nPics];

  movers = new ArrayList<Mover>();

  //cam = new PeasyCam(this, 0, 0, 0, 0);

  for (int i = 0; i <nPics; i++) {
    img[i] = loadImage("a-"+i+".jpg");
  }
  
  path = new Path("day.obj");
  
  // Wir befüllen unseren Path mit Mover Objekten
  path.scale(scalePath);
  println(path.getTotalChildShapes());
  for(int i = 0; i<path.getTotalChildShapes(); i++) {
    PVector v = path.getPosition(i);
    movers.add(new Mover(v));
  }
  surface.setLocation(0,0);
}


void draw() {
  background(200);
  lights();
  //translate(width/2, height/2);
  rotate(radians(180));
  path.update();
  path.display();
  path.show3D();

  if(!hide) {
    for (Mover mv : movers) {
      mv.display();
    }
  }
}

void mouseDragged() {
  //addMover();
}

void mousePressed() {
  //addMover();
}

void keyPressed() {
  hide = !hide;
  /*for (Mover mv : movers) {
    mv.delete();
  }
  movers.clear();
  */
  //println(movers.size());
}

void addMover() {
  if (millis() - timestamp > debounce) {
    timestamp = millis();
    movers.add(new Mover(new PVector(mouseX, mouseY)));
    println("anzahl mover= " + movers.size());
  }
}
