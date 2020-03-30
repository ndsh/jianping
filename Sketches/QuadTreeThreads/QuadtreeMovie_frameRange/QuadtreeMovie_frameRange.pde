import processing.video.*;
Movie mov;
int newFrame = 0;


PVector[][] imgb;

String foldername = "targets/";
String filename = "title_ch_onwhite_01.jpg";
String moviename = "title_long.mp4";

/// //// ////
// ###### PROGRAMM EINSTELLEN
int[] superAsset = {34, 40, 11, 19};
int currentSet = 2; // mit welchem set aus dem superAsset soll gestartet werden?
int exportHowManyFrames = 30;
int increasePerFrame = 10; // wieviele frames vergehen soll, bis ein neues asset dazu geladen wird. linearer zuwachs.
boolean frameRange = true; // soll nur ein bereich oder der ganze film berechnet werden?
// falls frameRange == true
int startFrame = 1000;
int endFrame = 20;



Importer importer;
Exporter exporter;
SuperResource resource;

String appName = "quadtreemovie-frameRange";
int FPS = 30;
boolean record = true;


String date = year() +""+ nf(month(), 2) +""+ nf(day(), 2) +""+ nf(hour(), 2) +""+ nf(minute(), 2) +""+ nf(second(), 2);

// working buffer
// image
PImage img;
boolean exportFiles = false;

void setup() {
  
  //size(3200, 1000);
  size(100, 100, P2D);
  
  println("here");
  mov = new Movie(this, moviename);
  println("here");
  mov.play();
  mov.jump(0);
  mov.pause();
  println("here");
  if(frameRange) {
    setFrame(startFrame);
    newFrame = startFrame;
    exportHowManyFrames = endFrame;
  } else exportHowManyFrames = getLength();
  //exportHowManyFrames = 300;
  println(exportHowManyFrames);

  
  surface.setLocation(0, 0);
  
  importer = new Importer("../../../Assets");
  
  resource = new SuperResource();
  resource.setResources(superAsset);
  resource.loadResources();
  resource.setCurrentset(currentSet);
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
  
  if(exportFiles) {
    //if(stepIndex < minrSteps.length) {
      //MINR = minrSteps[stepIndex];

      //processImage();
      //image(buffer, 0, 0, width, height);
      //if(record) exporter.export(buffer);
      //stepIndex++;
    //}
  } else {
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
