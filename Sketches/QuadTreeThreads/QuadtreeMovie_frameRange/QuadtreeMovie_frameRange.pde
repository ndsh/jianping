/**
*    @author Julian Hespenheide (julian@thegreeneyl.com)
*    @version 0.6.0
*
*/


/** 
*    +----------------------------+
*    |                            |
*    |        * SETTINGS *        |
*    |                            |
*    +----------------------------+
*/

/**
*    @param exportMode                     Should be set to 0, 1 or 2.
*                                          0 = Render movie
*                                          1 = Render a single image ( with limited frame output )
*                                          2 = Walks through the filesets array ( multiplies the length of the filesets by the limited frame output )
*    @param exportHowManyFrames            Limits the frame output 
*/
int exportMode = 1;
int exportHowManyFrames = 5;

/**
*    @param foldername                     where the target files ( stills / movies ) reside
*    @param filename                       for movie target in exportMode = 0
*    @param filename                       for single target in exportMode = 1
*    @param fileset[]                      walk through array for exportMode = 2;
*/
String foldername = "targets/";
String moviename = "scale30_raster1.mp4";
String filename = "042x-white_grey.png";
String[] fileset = {
  "042x-alpha.png", "042x-black.png", "042x-white.png",
  "052x-alpha.png", "052x-black.png", "052x-white.png",
  "062x-alpha.png", "062x-black.png", "062x-white.png"}; 

/**
*    @param superAsset[]                   list of folders we want to add to our pool and walk through via the SuperResource class
*    @param superAssetNames[]              list of folders we want to add to our pool and walk through via the SuperResource class.
*    @param useNamedAssets                 use superAsset in index or clear name form
*    @param currentSet                     start of the superAsset. usually 0
*    @param currentSetLimit                upper limit of assets that should be loaded into the SuperResource class
*    @param increasePerFrame               how many frames have to elapse before adding anoter asset to the pool ( linear growth ) 
*
*/
int[] superAsset = {20};
String[] superAssetNames = {"jianping-black-letters", "jianping-letters"};
boolean useNamedAssets = true;
int currentSet = 0;
int currentSetLimit = 21;
int increasePerFrame = 1;

/**
*    @param frameRange                     render whole movie or just a range of frames? works with exportMode = 0
*    @param startFrame                     beginning of range in frames
*    @param endFrame                       ending of the range, as an offset: end = startFrame+endFrame  
*/
boolean frameRange = true;
int startFrame = 387;
int endFrame = 125;

/**
*    @param useTimingArray                 should the timingArray be used
*    @param timingArray[]                  single points in time when a new asset set should be added. measurement in frames not millis!
*    @param advanceSetsByForce             instead of peacefully run through the asset, it can be advance when the desired frame is reached
*/
boolean useTimingArray = false;
int[] timingArray = {2, 27, 28};
boolean advanceSetsByForce = false;

/**
*    @param appName                        specify the name of the frame output folder (will be created on disk if it doesn't exist)
*    @param FPS                            specify FPS of the movie, so jumping within frames is accurate
*/
String appName = "quadtreemovie-frameRange-2";
int FPS = 30;

/**
*    @param treeBG                        standard background color of the quadtree in RGB 
*/
color treeBG = color(255, 0, 0);


void setup() {
  println("~ ~ ~ ~ ~ ~ ~ ~ ~ ");
  println("Setup start");
  //size(3200, 1000);
  
  size(100, 100, P2D);
  float[] aspect = {0, 0};
  if(exportMode == 0) {
    mov = new Movie(this, moviename);
    mov.play();
    mov.jump(0);
    mov.pause();
    aspect = calculateAspectRatioFit(mov.width, mov.height, 400, 400);
    if(frameRange) {
      setFrame(startFrame);
      newFrame = startFrame;
      exportHowManyFrames = endFrame;
    } else {
      if(exportMode == 0) exportHowManyFrames = getLength();
    }
  } else if(exportMode == 1) {
    target = loadImage(foldername+filename);
    aspect = calculateAspectRatioFit(target.width, target.height, 400, 400);
  } else if(exportMode == 2) {
    target = loadImage(foldername+fileset[filesetIndex]);
    exportHowManyFrames *= fileset.length;
    aspect = calculateAspectRatioFit(target.width, target.height, 400, 400);
  }
  
  
  surface.setSize((int)aspect[0], (int)aspect[1]);
  surface.setLocation(0, 0);
  
  importer = new Importer("../../../Assets");
  
  resource = new SuperResource();
  resource.setMethod(1);
  if(useNamedAssets) resource.setResources(superAssetNames);
  else resource.setResources(superAsset);
  resource.loadResources();
  resource.setCurrentset(currentSet);
  resource.setCurrentlimit(currentSetLimit); // wieviele sets im anfangsset zu sehen sind 
  resource.update();
  exporter = new Exporter(FPS);
  exporter.setPath(appName);
  exporter.setMode(1);
  exporter.setLimit(exportHowManyFrames);
  
  //processImage();
  background(0);
  println("~ Setup finished");
  println("~ ~ ~ ~ ~ ~ ~ ~ ~ ");
  println();
  
}

void draw() {
  switch(exportMode) {
    
    case 0:
      if(mov != null) {
        //if(exporter.getFrame() % increasePerFrame == 0) resource.update();
        addingAssets();
        Quadtree tree = qtreeExec();
        nextFrame();
        cleanUp(tree);
      }
    break;
    
    case 1:
      //if(exporter.getFrame() % increasePerFrame == 0) resource.update();
      addingAssets();
      //Quadtree tree = qtreeExec();
      cleanUp(qtreeExec());
    break;
    
    case 2:
      //if(exporter.getFrame() % increasePerFrame == 0) resource.update();
      addingAssets();
      //Quadtree tree = qtreeExec();
      cleanUp(qtreeExec());
      if(exporter.getFrame() % (exportHowManyFrames/fileset.length) == 0) {
        filesetIndex++;
        if(filesetIndex < fileset.length) {
          println();
          println("outputting filename= "+ fileset[filesetIndex]);
          target = loadImage(foldername+fileset[filesetIndex]);
        }
      }
    break;
  }

}

// advanceSetsByForce
void addingAssets() {
  if(useTimingArray) {
      if(timingIndex < timingArray.length) {
        
        if(advanceSetsByForce) {
          for(int i = 0; i<timingArray.length; i++) {
            if(exporter.getFrame() > timingArray[timingIndex]) {
              if(timingIndex < timingArray.length) {
                timingIndex++;
                resource.advance();
              }
            }
          }
          
          if(exporter.getFrame() >= timingArray[timingIndex]) {
            if(exporter.getFrame() % increasePerFrame == 0) resource.update();
          }
           
        } else { // advanceSetsByForce
        
          if(exporter.getFrame() >= timingArray[timingIndex]) {
            
              if(!resource.isFinished() ) {
                println("not finished");
                //if(advanceSetsByForce)
                if(exporter.getFrame() % increasePerFrame == 0) resource.update();
              } else {
                timingIndex++;
                println("finished");
                resource.reset();
                timingCheckpoint = false;
              }
            
          }
        }
      }
    
      //timestamp = millis();
      //println("advancing in time");
      //bla
      
     
    //}
  } else {
    if(exporter.getFrame() % increasePerFrame == 0) {
      resource.reset();
      resource.update();
    }
  }
}
