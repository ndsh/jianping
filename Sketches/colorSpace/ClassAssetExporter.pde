class AssetExporter {
  // AssetExporter receives an Array or an ArrayList and saves
  // the output as a JSON file

  // Later on another module (probably called "AssetPacker") will take the JSON
  // and repack original JPG files into the respective files

  AssetExporter() {
  }

  void parse() {
    StringList files = new StringList();
    String header = "";
    header += (mode==0?"hsb":"rgb");
    header += ","+componentMin[0];
    header += ","+componentMax[0];
    header += ","+componentMin[1];
    header += ","+componentMax[1];
    header += ","+componentMin[2];
    header += ","+componentMax[2];
    files.append(header);
    for (int i = 0; i<nodes.size(); i++) {
      int[] d = nodes.get(i).getPosition();
      boolean show = false;
      if (filter) {
        if (mode == 1) {
          float x = (int)d[0];
          float y = (int)d[1];
          float z = (int)d[2];

          if ( (x >= componentMin[0] && x <= componentMax[0]) && (y >= componentMin[1] && y <= componentMax[1]) && (z >= componentMin[2] && z <= componentMax[2]) ) show = true;
          //else println(componentMin[0] + "/" + componentMax[0] + "= "+ t.x +" | "+ componentMin[1] + "/" + componentMax[1] + "= "+ t.y +" | "+ componentMin[2] + "/" + componentMax[2] + "= "+ t.z);
        } else {
          if ( (d[0] >= componentMin[0] && d[0] <= componentMax[0]) && (d[1] >= componentMin[1] && d[1] <= componentMax[1]) && (d[2] >= componentMin[2] && d[2] <= componentMax[2]) ) show = true;
          //else println(componentMin[0] + "/" + componentMax[0] + "= "+ d.x +" | "+ componentMin[1] + "/" + componentMax[1] + "= "+ d.y +" | "+ componentMin[2] + "/" + componentMax[2] + "= "+ d.z);
        }
      } else show = true;
      
      if(show) {
        files.append(nodes.get(i).getName());
      }
    }
    if(files.size() > 0) {
      String y = year()+"";
      y = y.substring(2);
      String m = leadingZero(month());
      String d = leadingZero(day());
      String h = leadingZero(hour());
      String i = leadingZero(minute());
      String s = leadingZero(second());
      println("Exporting " + files.size() + " file(s)");
      String[] filesArray = files.array();
      String folderFormat = y + m + d + "_" + h + i + s;
      String output = folderFormat +"_"+ (mode==0?"hsb":"rgb")+".txt";
      saveStrings("data/AssetExports/"+ output, filesArray);
      println("Saved in file= " + output);
    }
  }
  
  String leadingZero(int i) {
    String s = ""+i;
    if(i < 10) return s = "0"+s;
    else return s;
  }
}
