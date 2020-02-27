class LImage {
  PVector[][] b;
  String name;
  int w, h;
}

class Part {
  int posx, posy, w, h;
  int x, y;

  String toString() {
    return "(" + posx + "," + posy + "," + w + "," + h + ") -> (" + x + "," + y + ")" ;
  }
}
