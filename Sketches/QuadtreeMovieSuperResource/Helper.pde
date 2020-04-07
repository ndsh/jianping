void keyPressed() {
  // SPACE to save
  if(keyCode == 32) {
//    save();
  } else if (key == 'r') {
      record = !record;
      println("record= " + record);
    }
}

void processImage() {
  imgsb = new ArrayList<LImage>();
  parts = new HashMap<String, ArrayList<Part>>();
  buffer.beginDraw();
  buffer.background(255);
  //println("Preparing data");
  
  prepare_patterns_new();
  segment(0, img.width-1, 0, img.height-1, 2);

  //println("Layering");
  for (String key : parts.keySet ()) {
    ArrayList<Part> p = parts.get(key);
    PImage _img = loadImage(key);
    //image(_img, 0, 0);
    //println("Parts from image: " + key);
    for (Part part : p) {
      buffer.image(_img.get(part.posx, part.posy, part.w, part.h), part.x, part.y);
      //coordinates.append(part.posx +","+ part.posy+","+ part.w+","+ part.h+","+ part.x+","+ part.y);
    }
  }
  //String[] toText = coordinates.array();
  //saveStrings(sketchPath(exportPath+textFileOutput), toText);

  //println("done");
  done = true;
  // END CODE HERE!

  if(do_blend)
    buffer.blend(img,0,0,img.width,img.height,0,0,buffer.width,buffer.height,blend_mode);

  buffer.endDraw();
  //image(buffer,0,0,width,height);
} // end processImage()



void prepare_image() {
  img = mov;
  
  imgb = new PVector[img.width][img.height];
  for (int x=0; x<img.width; x++) {
    for (int y=0; y<img.height; y++) {
      int c = img.get(x, y);
      float r = map((c>>16)&0xff, 0, 255, 0, 1);
      float g = map((c>>8)&0xff, 0, 255, 0, 1);
      float b = map(c&0xff, 0, 255, 0, 1);
      PVector v = new PVector(r, g, b);
      imgb[x][y] = v;
    }
  }
}



void prepare_patterns_new() {
  LImage bi = null;
  
  for (int i = 0; i < resource.size(); i++) {
    //PImage _img = imageList.get(0).get(i);
    //println(fname);
    bi = new LImage();
    //bi.b = new PVector[imageList.get(0).get(i).width][imageList.get(0).get(i).height];
    bi.b = new PVector[resource.getImageList().get(i).width][resource.getImageList().get(i).height];
    
    
    //bi.name = importer.getFiles().get(i);
    bi.name = resource.getFilenames().get(i);
    bi.w = resource.getImageList().get(i).width;
    bi.h = resource.getImageList().get(i).height;
    for (int x=0; x<resource.getImageList().get(i).width; x++) {
      for (int y=0; y<resource.getImageList().get(i).height; y++) {
        int c = resource.getImageList().get(i).get(x, y);
        float r = map((c>>16)&0xff, 0, 255, 0, 1);
        float g = map((c>>8)&0xff, 0, 255, 0, 1);
        float b = map(c&0xff, 0, 255, 0, 1);
        PVector v = new PVector(r, g, b);
        bi.b[x][y] = v;
      }
    }
    imgsb.add(bi);
  }
}

void find_match(int posx, int posy, int w, int h) {
  float br = 0;
  if (mode == AVG_MODE) {
    for (int x=posx; x< (posx+w); x++) {
      for (int y=posy; y< (posy+h); y++) {
        br+= getLuma(imgb[x][y]);
      }
    }
  }

  float currdiff = 1.0e10;
  int currxx = -1;
  int curryy = -1;
  LImage currimg = null;

  for (int i=0; i<number_of_iterations; i++) {
    //println(imgsb.size() + " +++ " + number_of_iterations);
    LImage _img = imgsb.get( (int)random(imgsb.size()) );
    //LImage _img = imgsb.get( imgsb.size()-4 );
    //LImage _img = imgsb.get( imgsb.size()-1 );
    for (int iter = 0; iter<number_of_blocks; iter++) {
      int a = _img.w-w-1;
      int xx = (int)random(a);
      //xx = a-1;
      
      //int xx = (_img.w-w-1)/2;
      //println(_img.w-w-1);
      int b = _img.h-h-1;
      int yy = (int)random(b);
      //int yy = b-1;
      //int yy = (_img.h-h-1)/2;
      //int xx = _img.w;
      //int yy = _img.h;

      if(xx+w >= _img.w || yy+h >= _img.h) break;

      float lbr = 0;
      for (int x=xx, xi=posx; x< (xx+w); x++, xi++) {
        for (int y=yy, yi=posy; y< (yy+h); y++, yi++) {
          if(mode == DIST_MODE)
            lbr += _img.b[x][y].dist(imgb[xi][yi]);
          else if(mode == AVG_MODE)
            lbr += getLuma(_img.b[x][y]);
          else if(mode == ABS_MODE)
            lbr += abs(getLuma(_img.b[x][y])-getLuma(imgb[xi][yi]));
          }
        }


      float ldiff = mode == AVG_MODE?abs(br-lbr):lbr;
      if (ldiff<currdiff) {
        currdiff = ldiff;
        currxx = xx;
        curryy = yy;
        currimg = _img;
      }
    }
  }

  Part p = new Part();
  p.posx = currxx;
  p.posy = curryy;
  p.w = w;
  p.h = h;
  p.x = posx;
  p.y = posy;

  ArrayList<Part> list;
  if(currimg != null) {
    if (parts.containsKey(currimg.name)) {
      list = parts.get(currimg.name);
    } else {
      list = new ArrayList<Part>();
      parts.put(currimg.name, list);
    }
    list.add(p);
  
    //println("Matched: " + currimg.name + "; " + p);
  }
}

void segment(int x1, int x2, int y1, int y2, int obl) {
  int diffx = x2-x1;
  int diffy = y2-y1;
  if ((obl>0) || (diffx>MINR && diffy>MINR && godeeper(x1, x2, y1, y2))) {
    //int midx = (int)random(diffx/2-diffx/4, diffx/2+diffx/4);
    //int midy = (int)random(diffy/2-diffy/4, diffy/2+diffy/4);
    int midx = diffx/2-diffx/4;
    int midy = diffy/2-diffy/4;
    segment(x1, x1+midx, y1, y1+midy, obl-1);
    segment(x1+midx+1, x2, y1, y1+midy, obl-1);
    segment(x1, x1+midx, y1+midy+1, y2, obl-1);
    segment(x1+midx+1, x2, y1+midy+1, y2, obl-1);
  } else {
    find_match(x1, y1, diffx+1, diffy+1);
  }
}

final float getLuma(PVector v) {
  return v.x*0.3+0.59*v.y+0.11*v.z;
}

final int getLumaN(PVector v) {
  return (int)(255*getLuma(v));
}

boolean godeeper(int x1, int x2, int y1, int y2) {
  int[] h = new int[256];
  // top and bottom line
  for (int x=x1; x<=x2; x++) {
    h[getLumaN(imgb[x][y1])]++;
    h[getLumaN(imgb[x][y2])]++;
  }
  // left and right, without corners
  for (int y=y1+1; y<y2; y++) {
    h[getLumaN(imgb[x1][y])]++;
    h[getLumaN(imgb[x2][y])]++;
  }
  int midx = x1+(x2-x1)/2;
  int midy = y1+(y2-y1)/2;
  // horizontal, without endpoints
  for (int x=x1+1; x<x2; x++) h[getLumaN(imgb[x][midy])]++;
  // vertical, without endpoints
  for (int y=y1+1; y<y2; y++) h[getLumaN(imgb[midx][y])]++;
  // remove crossingpoint
  h[getLumaN(imgb[midx][midy])]--;

  // calculate mean
  float mean = 0;
  int sum = 0;
  for (int i=0; i<256; i++) {
    mean += i * h[i];
    sum += h[i];
  }
  mean /= sum;

  float stddev = 0;
  for (int i=0; i<256; i++) {
    stddev += sq(i-mean)*h[i];
  }
  stddev = sqrt(stddev/sum);

  return stddev > THR;
}

//

final static int[] blends = {ADD, SUBTRACT, DARKEST, LIGHTEST, DIFFERENCE, EXCLUSION, MULTIPLY, SCREEN, OVERLAY, HARD_LIGHT, SOFT_LIGHT, DODGE, BURN};

// ALL Channels, Nxxx stand for negative (255-value)
// channels to work with
final static int RED = 0;
final static int GREEN = 1;
final static int BLUE = 2;
final static int HUE = 3;
final static int SATURATION = 4;
final static int BRIGHTNESS = 5;
final static int NRED = 6;
final static int NGREEN = 7;
final static int NBLUE = 8;
final static int NHUE = 9;
final static int NSATURATION = 10;
final static int NBRIGHTNESS = 11;

float getChannel(color c, int channel) {
  int ch = channel>5?channel-6:channel;
  float cc;

  switch(ch) {
    case RED: cc = red(c); break;
    case GREEN: cc = green(c); break;
    case BLUE: cc = blue(c); break;
    case HUE: cc = hue(c); break;
    case SATURATION: cc = saturation(c); break;
    default: cc= brightness(c); break;
  }

  return channel>5?255-cc:cc;
}


// movie functions
void movieEvent(Movie m) {
  m.read();
}

void nextFrame() {
  if (newFrame < getLength() - 1) newFrame++;
  setFrame(newFrame);
}

int getFrame() {    
  return ceil(mov.time() * FPS) - 1;
}

void setFrame(int n) {
  mov.play();
    
  // The duration of a single frame:
  float frameDuration = 1.0 / mov.frameRate;
    
  // We move to the middle of the frame by adding 0.5:
  float where = (n + 0.5) * frameDuration; 
    
  // Taking into account border effects:
  float diff = mov.duration() - where;
  if (diff < 0) {
    where += diff - 0.25 * frameDuration;
  }
    
  mov.jump(where);
  mov.pause();  
}  

int getLength() {
  return int(mov.duration() * mov.frameRate);
}
