/**
 * Dominant Color Sort I (v1.03)
 * GoToLoop (2016-Jan-11)
 * forum.Processing.org/two/discussion/14393/getting-the-dominant-color-of-an-image
 */
 
static final int QTY = 5, VARIATION = 390;
final color[] dominantArr  = new color[QTY];
final IntDict dominantDict = new IntDict(QTY);
 
IntDict sortedDict;
PImage pic;
int len;
 
void setup() {
  size(800, 600);
  noLoop();
 
  pic = loadImage("img.jpg");//createImage(width, height, ARGB);
  len = pic.pixels.length;
}
 
void draw() {
  background(randomPixels(pic, VARIATION));
 
  sortedDict = countColorsIntoDict(pic.pixels);
  sortedDict.sortValuesReverse();
 
  dominantDict.clear();
  java.util.Arrays.fill(dominantArr, 0);
 
  final int dictSize = sortedDict.size(), limit = min(QTY, dictSize);
  println("\nUnique colors found:", dictSize, "\tfrom:", len, ENTER);
 
  for (int i = 0; i != limit; ++i) {
    final String k = sortedDict.key(i);
    dominantDict.set(k, sortedDict.value(i));
    dominantArr[i] = int(k) | #000000;
  }
 
  for (int i = 0; i != QTY; ++i)
    println(i, "->", hex(dominantArr[i], 6), "\tcount:", dominantDict.value(i));
 
  println();
  println(dominantDict, ENTER);
  println(dominantArr);
}
 
void mousePressed() {
  redraw = true;
}
 
PImage randomPixels(final PImage img, final int v) {
  final color p[] = img.pixels, d = 0400 - min(0400, abs(v));
 
  for (int i = 0; i != p.length; p[i++] = color(
    (color) random(d, 0400), 
    (color) random(d, 0400), 
    (color) random(d, 0400)));
 
  img.updatePixels();
  return img;
}
 
static final IntDict countColorsIntoDict(final color... colors) {
  final IntDict iDict = new IntDict();
  for (color c : colors)  iDict.increment(str(c & ~#000000));
  return iDict;
}
