import processing.video.*;
Movie mov;
int newFrame = 0;


PVector[][] imgb;

String foldername = "targets/";
String filename = "042x-white_grey.png";
String[] fileset = {
  "042x-alpha.png", "042x-black.png", "042x-white.png",
  "052x-alpha.png", "052x-black.png", "052x-white.png",
  "062x-alpha.png", "062x-black.png", "062x-white.png"}; 
String moviename = "third_white.mp4";
int filesetIndex = 0;

/// //// ////
// ###### PROGRAMM EINSTELLEN
int[] superAsset = {44, 40, 44, 2, 44, 19};
int currentSet = 0; // mit welchem set aus dem superAsset soll gestartet werden?
int currentSetLimit = 0;

int increasePerFrame = 1; // wieviele frames vergehen soll, bis ein neues asset dazu geladen wird. linearer zuwachs.
boolean frameRange = false; // soll nur ein bereich oder der ganze film berechnet werden?
// falls frameRange == true
int startFrame = 1000;
int endFrame = 20;

//unser modus. 0 = movie | 1 = still image mit anzahl franes
int exportMode = 0;
int exportHowManyFrames = 5;

Importer importer;
Exporter exporter;
SuperResource resource;

String appName = "quadtreemovie-frameRange-1";
int FPS = 30;
boolean record = true;

String date = year() +""+ nf(month(), 2) +""+ nf(day(), 2) +""+ nf(hour(), 2) +""+ nf(minute(), 2) +""+ nf(second(), 2);

// working buffer
// image
PImage img;
PImage target;



void setup() {
  
  //size(3200, 1000);
  size(100, 100, P2D);

  if(exportMode == 0) {
    mov = new Movie(this, moviename);
    mov.play();
    mov.jump(0);
    mov.pause();
    if(frameRange) {
      setFrame(startFrame);
      newFrame = startFrame;
      exportHowManyFrames = endFrame;
    } else {
      if(exportMode == 0) exportHowManyFrames = getLength();
    }
  } else if(exportMode == 1) {
    target = loadImage(foldername+filename);
  } else if(exportMode == 2) {
    target = loadImage(foldername+fileset[filesetIndex]);
    exportHowManyFrames *= fileset.length;
  }
  

  surface.setLocation(0, 0);
  
  importer = new Importer("../../../Assets");
  
  resource = new SuperResource();
  resource.setResources(superAsset);
  resource.loadResources();
  resource.setCurrentset(currentSet);
  resource.setCurrentlimit(currentSetLimit); // wieviele sets im anfangsset zu sehen sind 
  resource.update();
  exporter = new Exporter(FPS);
  exporter.setPath(appName);
  exporter.setMode(1);
  //if(exportFiles) exporter.setLimit(minrSteps.length);
  exporter.setLimit(exportHowManyFrames);
  
  //processImage();
  background(0);
  println("end setup");
  
}

void draw() {
  
  if(exportMode == 1) {
    //if(stepIndex < minrSteps.length) {
      //MINR = minrSteps[stepIndex];

      //processImage();
      //image(buffer, 0, 0, width, height);
      //if(record) exporter.export(buffer);
      //stepIndex++;
    //}
    if(exporter.getFrame() % increasePerFrame == 0) resource.update();
      Quadtree tree = new Quadtree();
      tree.prepare_image();
      tree.processImage();
      image(tree.getBuffer(), 0, 0, width, height);
      if(record) exporter.export(tree.getBuffer());
      delay(5);
      System.gc();
  } else if(exportMode == 2) {
    if(exporter.getFrame() % increasePerFrame == 0) resource.update();
      Quadtree tree = new Quadtree();
      tree.prepare_image();
      tree.processImage();
      image(tree.getBuffer(), 0, 0, width, height);
      if(record) exporter.export(tree.getBuffer());
      delay(5);
      System.gc();
      if(exporter.getFrame() % (exportHowManyFrames/fileset.length) == 0) {
        filesetIndex++;
        if(filesetIndex < fileset.length) {
          println("fn= "+ fileset[filesetIndex]);
          target = loadImage(foldername+fileset[filesetIndex]);
        }
      }
  } else if(exportMode == 0) {
    if(mov != null) {
      if(exporter.getFrame() % increasePerFrame == 0) resource.update();
      Quadtree tree = new Quadtree();
      tree.prepare_image();
      tree.processImage();
      image(tree.getBuffer(), 0, 0, width, height);
      nextFrame();
      if(record) exporter.export(tree.getBuffer());
      delay(5);
      System.gc();
    }
  }
}
