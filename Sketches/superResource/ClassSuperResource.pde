// a class that handles resource management

// returns a simple ArrayList of all loaded assets

class SuperResource {
  private ArrayList<ArrayList<PImage>> imageList = new ArrayList<ArrayList<PImage>>();
  private ArrayList<StringList> filenames = new ArrayList<StringList>();
  //private StringList output = new StringList();
  
  private ArrayList<PImage> output = new ArrayList<PImage>();
  private StringList namelist = new StringList();
  private int[] resources;
  private int[] maxima;
  private int[] resourceOffset; // "start"
  private int[] resourceLimit; 
  private int mode = 0;
  private int increaseInterval = 10; // every 10 frames increase
  private int currentSet = 0;
  private int current = 0;
  
  SuperResource() {
    
  }
  
  void update() {
    
    assemble();
  }
  
  //unnötig
  //void display() {
  //}
  
  void setResources(int[] _resources) {
    resources = _resources;
    for (int j = 0; j <resources.length; j++) {
      for (int i = 0; i <importer.getFiles().size(); i++) {
        println(importer.getFiles().size());
      }
    }
  }
  
  void loadResources() {
    imageList =  new ArrayList<ArrayList<PImage>>();
    filenames = new ArrayList<StringList>();
    maxima = new int[resources.length];
    resourceOffset = new int[resources.length];
    resourceLimit = new int[resources.length];
    for (int j = 0; j <resources.length; j++) {
      imageList.add(new ArrayList<PImage>());
      filenames.add(new StringList());
      resourceOffset[j] = 0;
      resourceLimit[j] = 0;
      importer.loadFiles(importer.folders.get(resources[j]));
      maxima[j] = importer.getCount(j);
      
      for (int i = 0; i <importer.getFiles().size(); i++) {
        //println(importer.getFiles().get(i));
        imageList.get(j).add(loadImage(importer.getFiles().get(i)));
        //imageList.add(loadImage(importer.getFiles().get(i)));
        filenames.get(j).append(importer.getFiles().get(i));
        //println(importer.getFiles().get(i));
      }
    }
    resourceLimit[0] = 1;
    //println(maxima);
    //println(currentLimit);
  }
  
  
  
  void increase() {
  }
  
  void assemble() {
    // outputs a full, interpolated resource set coming from two asset sets
    boolean setA = false;
    boolean setAoffsetting = false;
    boolean setB = false;
    output = new ArrayList<PImage>();
    int currentSetNext = (currentSet+1) % resources.length;
    
    print("currentSet = "+ currentSet);
    println(" / currentSetNext = "+ currentSetNext);
    
    println("1 " + resourceOffset[currentSet] + " => " + resourceLimit[currentSet] +" | "+ maxima[currentSet]);
    println("2 " + resourceOffset[currentSetNext] + " => " + resourceLimit[currentSetNext] +" | "+ maxima[currentSetNext]);
    
    for(int i = resourceOffset[currentSet]; i<resourceLimit[currentSet]; i++) {
      output.add(imageList.get(currentSet).get(i));
      namelist.append(filenames.get(currentSet).get(i));
    }
    for(int i = resourceOffset[currentSetNext]; i<resourceLimit[currentSetNext]; i++) {
      output.add(imageList.get(currentSetNext).get(i));
      namelist.append(filenames.get(currentSetNext).get(i));
    }
    
    if(resourceLimit[currentSet] < maxima[currentSet]) {
      resourceLimit[currentSet] += 1;
    } else {
      if(resourceOffset[currentSet] < resourceLimit[currentSet]) { 
        resourceOffset[currentSet] += 1;
        
      }
      setAoffsetting = true;
    }
    
    if(setAoffsetting) {
      if(resourceLimit[currentSetNext] < maxima[currentSetNext]) {
        resourceLimit[currentSetNext] += 1;
      } else {
        if(resourceOffset[currentSetNext] < resourceLimit[currentSetNext]) { 
          resourceOffset[currentSetNext] += 1;
        }
      }
    }
    
    if(resourceOffset[currentSet] == maxima[currentSet]) setA = true;
    if(resourceOffset[currentSetNext] == maxima[currentSetNext]) setB = true;
    
    if(setA && setB) {
      //println("a+b");
      currentSet++;
      currentSet %= resources.length;
      //if(currentSet > resources.length) currentSet = 0;
      //println(currentSet);
      for(int i = 0; i<resources.length; i++) {
        resourceOffset[i] = 0;
        resourceLimit[i] = 0;
      }
      resourceLimit[currentSet] = 1;
    }
      
      
    
    // unser momentanes set
    // wenn das momentane set + 1 am limit ankommt 
    //currentSet++;
    //currentSet %= resources.length;
  }
  
  int size() {
    return output.size();
  }
  
  ArrayList<PImage> getImageList() {
    return output;
  }
  
  StringList getFilenames() {
    return namelist;
  }
  
  int getCurrentIndex() {
    return current;
  }
  
  
  
  //String getCurrentFilename() {
//    return output.get(getCurrentIndex());
  //}
  
  
}
