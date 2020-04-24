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
int exportMode = 0;
int exportHowManyFrames = 1;

/**
*    @param foldername                     where the target files ( stills / movies ) reside
*    @param filename                       for movie target in exportMode = 0
*    @param filename                       for single target in exportMode = 1
*    @param fileset[]                      walk through array for exportMode = 2;
*/
String foldername = "targets/";
String moviename = "trgt-200423.mp4";
String filename = "062x-black.png";
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
//String[] superAssetNames = {"jianping-raster", "jianping-printmarks", "jianping-trashbags-marx", "jianping-farbe-pink", "jianping-farbe-blau"};
//String[] superAssetNames = {"01_bodoni","02-raster_01","03-printmarks_03","jianping-shapes"};

// BLOCK 1
/*String[] superAssetNames = {
  "jianping-white-letters-22",
  "jianping-shapes-35",

  "jianping-bodoni-white-62",
  "jianping-printmarks-209",
  "jianping-raster-99"
};*/

/*
// BLOCK 2
String[] superAssetNames = {
  "jianping-raster-99",
  "jianping-werbung-108",
  "jianping-auto-200305_130039__hsb_270_360_0_100_0_100",
  "jianping-letters-89"

};
*/
// BLOCK 3
/*
String[] superAssetNames = {
  //"jianping-bodoni-white-62",
  //"jianping-raster-99",
  //"jianping-white-letters-57",
  "jianping-faces-62",
  "jianping-printmarks-209",
  "jianping-richard1-152",
  "jianping-farbe-rgb",
  "jianping-auto-200305_124255__rgb_0_143_0_255_0_229",
  "jianping-werbung-108",
  "jianping-random-178",
  "jianping-raster-99",
  "jianping-bodoni-white-62",
  "jianping-faces-62",
  "jianping-printmarks-209",
  "jianping-raster-99",
  "jianping-bodoni-white-62",
  "jianping-raster-99",
  "jianping-white-letters-57",
  "jianping-faces-62",
  "jianping-printmarks-209",
  "jianping-richard1-152",
  "jianping-farbe-rgb",
  "jianping-auto-200305_124255__rgb_0_143_0_255_0_229",
  "jianping-werbung-108",
  "jianping-random-178",
  "jianping-raster-99",
  "jianping-bodoni-white-62",
  "jianping-faces-62",
  "jianping-printmarks-209",
  "jianping-raster-99"
};
*/
String[] superAssetNames = {"jianping-white-letters-22", "jianping-shapes-35", "jianping-bodoni-white-62", "jianping-farbe-pink", "jianping-printmarks-209", "jianping-raster-99", "jianping-raster-99", "jianping-werbung-108", "jianping-farbe-brownish", "jianping-auto-200305_130039__hsb_270_360_0_100_0_100", "jianping-letters-89", "jianping-farbe-gruen", "jianping-farbe-gelb", "jianping-farbe-blau", "jianping-farbe-pink", "jianping-farbe-rot", "jianping-faces-62", "jianping-richard1-152", "jianping-farbe-rgb", "jianping-richard1-152", "jianping-farbe-rgb", "jianping-richard1-152", "jianping-farbe-rgb", "jianping-raster-99", "jianping-random-178", "jianping-black-letters-50", "jianping-extracts-3298", "jianping-raster-99", "jianping-bodoni-white-62", "jianping-white-letters-57", "jianping-bodoni-black", "jianping-auto-200305_130039__hsb_270_360_0_100_0_100", "jianping-random-178", "jianping-extracts-3298", "05-mix-47", "jianping-faces-31", "jianping-trashbags-marx-35", "jianping-shapes-35", "jianping-printmarks-209", "jianping-black-letters-50", "jianping-farbe-lila", "jianping-raster-99", "jianping-white-letters-22"};

/*
// BLOCK 4
String[] superAssetNames = {
  "jianping-faces-31",

};
*/
//jianping-farbe-rgb

/*
MIX
"05-mix-47"
"jianping-auto-200305_124255__rgb_0_143_0_255_0_229"
"jianping-auto-200305_130039__hsb_270_360_0_100_0_100"
"jianping-random-178"
  !!! "jianping-extracts-3298" !!!

COLOR
"jianping-faces-31"
"jianping-printmarks-209"
"jianping-werbung-108"
"jianping-richard1-152"

BW
"jianping-raster-99"
"jianping-black-letters-50"
"jianping-bodoni-white-62"
"jianping-letters-89"
"jianping-shapes-35"
"jianping-trashbags-marx-35"
"jianping-white-letters-22"
*/

boolean useNamedAssets = true;
int currentSet = 0;
int currentSetLimit = 0;
int increasePerFrame = 1;

/**
*    @param frameRange                     render whole movie or just a range of frames? works with exportMode = 0
*    @param startFrame                     beginning of range in frames
*    @param endFrame                       ending of the range, as an offset: end = startFrame+endFrame  
*/
boolean frameRange = false;
int startFrame = 2352;// abgebrochen bei 4800; 20 frames zurückgesprungen
int endFrame = 4953;

/**
*    @param useTimingArray                 should the timingArray be used
*    @param timingArray[]                  single points in time when a new asset set should be added. measurement in frames not millis!
*    @param advanceSetsByForce             instead of peacefully run through the asset, it can be advance when the desired frame is reached
*/
boolean useTimingArray = true;
//int[] timingArray = {0,40,150,1086,1311};        // BLOCK1 1.575 frames
//int[] timingArray = {0,105,917,1353,1545};       // BLOCK2 1.575 frames
//int[] timingArray = {2,750,1575,3150,4725,6300,7875,9450};       // BLOCK3 1.575 frames
//int[] timingArray = {10, 20, 30, 501, 675, 880, 900, 1125, 1320, 1576, 1702, 1800, 1912, 1968, 2025, 2142, 2223, 2260, 2315, 2352, 2406, 2442, 2475, 2590, 2822, 3050, 3159, 3376, 3516, 3528, 3600, 3714, 3825, 3959, 4033, 4163, 4385, 4489, 4559, 4644, 4738, 4953, 4954};
int[] timingArray = {20, 40, 225, 400, 501, 675, 880, 900, 1125, 1320, 1576, 1702, 1800, 1912, 1968, 2025, 2142, 2223, 2260, 2315, 2352, 2406, 2442, 2475, 2590, 2822, 3050, 3159, 3376, 3516, 3528, 3600, 3714, 3825, 3959, 4033, 4163, 4385, 4489, 4559, 4644, 4738, 4953};
int[] timingCheckpoints;
boolean advanceSetsByForce = true;

/**
*    @param appName                        specify the name of the frame output folder (will be created on disk if it doesn't exist)
*    @param FPS                            specify FPS of the movie, so jumping within frames is accurate
*/
String appName = "jianping-movie";
int FPS = 30;

/**
*    @param treeBG                        standard background color of the quadtree in RGB 
*/
color treeBG = color(255, 255, 255);


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
  
  
  importer = new Importer("../../../Assets");
  
  resource = new SuperResource();
  resource.setMethod(2);
  if(useNamedAssets) resource.setResources(superAssetNames);
  else resource.setResources(superAsset);
  resource.loadResources();
  //resource.loadSpecificResource(currentSet);
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
  surface.setLocation(0, 0);
  
  timingCheckpoints = new int[timingArray.length];
  for(int i = 0; i < timingCheckpoints.length; i++) timingCheckpoints[i] = 0; 
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


void addingAssets() {
  if(useTimingArray) {
      if(timingIndex < timingArray.length) {

        // <start advanceSetsByForce>
        if(advanceSetsByForce) {
          /*
          for(int i = 0; i<timingArray.length; i++) {
            if(exporter.getFrame() > timingArray[timingIndex]) {
              if(timingIndex < timingArray.length) {
                timingIndex++;
                resource.advance();
              }
            }
          }
          */
          if(exporter.getFrame() >= timingArray[timingIndex] && timingCheckpoints[timingIndex] == 0) {
            timingCheckpoints[timingIndex] = 1;
            resource.reset();
            timingIndex++;
            resource.advance();
            int current = resource.getCurrentset();
            println("the current set is now: " + current + "[" + superAssetNames[timingIndex] +"]");
            //resource.loadSpecificResource(current);
            //resource.setCurrentset(current);
            //resource.setCurrentlimit(0);
            //resource.update();
            currentSet = current;
          
            
          }
          //if(exporter.getFrame() >= timingArray[timingIndex]) {
            if(exporter.getFrame() % increasePerFrame == 0) resource.update();
          //}
           
        } else { // </end advanceSetsByForce>
        
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
                
                int current = resource.getCurrentset();
                println("the current set is now: " + current);
                resource.loadSpecificResource(current);
                resource.setCurrentset(current);
                resource.setCurrentlimit(0);
              }
            }
          }
        } else timingIndex = 0;
      
    
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
