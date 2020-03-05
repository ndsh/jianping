Importer importer;
String saveTo = "../../Assets";


void setup() {
  importer = new Importer("../colorSpace/data");
  String path = sketchPath(saveTo);
  String[] contents;
  println("saveTo= "+ path);
  println(importer.getFiles());
  if(importer.getFolders().size() > 0) {
    if(importer.getFiles().size() > 0) {
      for(int j = 0; j<importer.getFiles().size(); j++) {
        String fullPath = importer.getFiles().get(j);
        String result = getFileFromPath(fullPath);
        println();
        
        // date formatting
        String y = year()+"";
        y = y.substring(2);
        String m = leadingZero(month());
        String d = leadingZero(day());
        String h = leadingZero(hour());
        String i = leadingZero(minute());
        String s = leadingZero(second());
        
        if(getExt(result).equals("txt")) {
          contents = loadStrings(fullPath);
          String folderFormat = y + m + d + "_" + h + i + s;
          String newFolder = "jianping-auto-" + folderFormat +"__"+ replaceCharacter(contents[0], ",","_");
          
          for(int k = 1; k<contents.length; k++) {
            String fn = getFileFromPath(contents[k]);
            copyFile(contents[k], path+"/"+newFolder+"/"+fn);
          }
          
        }        
      }
    }
  }
  exit();
}

void draw() {
}

void copyFile(String sourceFile, String destFile){
  byte[] source = loadBytes(sourceFile);
  saveBytes(destFile, source);
}

String getFileFromPath(String s) {
  String[] split = split(s, "/");
  split = split(split[split.length-1], ".");
  return split[0] +"."+ split[1];
}

String getExt(String s) {
  String[] split = split(s, ".");
  return split[split.length-1];
}

String replaceCharacter(String haystack, String a, String b) {
  String[] split = split(haystack, a);
  String output = "";
  for(int i = 0; i<split.length; i++) {
    output += split[i] + (i<split.length-1?b:"");
  }
  
  return output;
}

String leadingZero(int i) {
  String s = ""+i;
  if(i < 10) return s = "0"+s;
  else return s;
}
