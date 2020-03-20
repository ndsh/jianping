class LImage {
  PVector[][] b;
  String name;
  int w, h;
}

class Part {
  int posx, posy, w, h;
  int x, y;
  
  Part() {
  }

  String toString() {
    return "(" + posx + "," + posy + "," + w + "," + h + ") -> (" + x + "," + y + ")" ;
  }
}
