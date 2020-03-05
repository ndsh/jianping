// options
String imagePath = "image2.jpg";
float res = 10; // resolution, dot density
float zoom = 1.0; // proportion to zoom image 
boolean isAdditive = true; // true = RGB, false = CMY
float offsetAngle = PI * 2; // affects dot pattern
/*
  0 = no patter
  0.05 = slight offset
  1 = slight offset
  0.1 = start noticing rings
  0.25 = rings
  PI / 3 = angled
  PI / 2 = small rings
  PI * 2 / 3 = angled other way
  PI = horizontal angled
*/


// vars and utilities
PGraphics flatImg;
PImage img;
float rt3 = sqrt(3);
//float radius = 2.1 * res / rt3;
float radius = 1.4 * res;
 
void setup() {
  noLoop();
  smooth();
  img = loadImage( imagePath );
  size(200, 200);
  surface.setSize(floor(img.width*zoom), floor(img.height*zoom));
  //size(floor(img.width*zoom), floor(img.height*zoom));
}
 
void draw() {
  noStroke();
 
  flatImg = createGraphics(width, height);
  flatImg.beginDraw();
  flatImg.background(255);
  flatImg.image(img, 0, 0);
  flatImg.endDraw();
  
  flatImg.updatePixels();
 
  int bgColor = isAdditive ? 0 : 255;
  background( bgColor );
  renderMatrix(      0.3, 255, 0, 0 );
  renderMatrix(  0.3 + offsetAngle, 0, 255, 0 );
  renderMatrix( 0.3 -offsetAngle, 0, 0, 255 );
  println("?");
}
 
void renderMatrix( float theta, int r, int g, int b ) {
  PGraphics buffer = createGraphics(width, height);
  
  buffer.beginDraw();
  buffer.smooth();
  buffer.noStroke();
  
  buffer.background(0);
  

  float zoomWidth = width * zoom;
  float zoomHeight = height * zoom;
  float xLen = zoomWidth / res;
  float yLen = zoomHeight / ( res );
  float diag = sqrt( zoomWidth * zoomWidth + zoomHeight * zoomHeight ) / res;
  float size;
  float x1, y1, x2, y2;
  float hueValue;
  // center values
  float xc = zoomWidth / 2;
  float yc = zoomHeight / 2;
  for (int i = floor((xLen-diag)/2); i<diag; i++){
    for (int j = floor((yLen-diag)/2); j<diag; j++){
      x1 = ( i + 0.5 ) * res;
      y1 = ( j + 0.5 ) * res;
      // shift to center
      x1 -= xc;
      y1 -= yc;
      // rotate grid
      x2 = x1 * cos(theta) - y1 * sin(theta) + xc;
      y2 = x1 * sin(theta) + y1 * cos(theta) + yc;
      // get color of pixel
      color pixel = flatImg.get( floor(x2 / zoom), floor(y2 / zoom) );
      // red
      size = 0;
      if ( r == 255 ) {
        hueValue = red(pixel);
      } else if ( g == 255 ) {
        hueValue = green(pixel);
      } else {
        hueValue = blue(pixel);
      }
      size = hueValue / 255;
      if ( !isAdditive ) {
        size = 1 - size;
      }
      size *= radius;
      buffer.fill( r, g, b );
      buffer.ellipse( x2, y2, size, size );
    }
  }
  
  buffer.endDraw();

  if ( isAdditive ) {
    blend( buffer, 0, 0, width, height, 0, 0, width, height, ADD);
  } else {
    blend( buffer, 0, 0, width, height, 0, 0, width, height, SUBTRACT);
  }
  
 
}
