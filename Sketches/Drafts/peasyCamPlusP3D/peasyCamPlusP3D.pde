import peasy.*;
PGraphics pg;
PeasyCam cam;

PMatrix mat_scene; // to store initial PMatrix

public void setup() {
  size(800, 800, P3D);
  mat_scene = getMatrix();
  pg = createGraphics(width, height, P3D);
  cam = new PeasyCam(this, 300);
}

public void draw() {
  background(50);

  pg.beginDraw();
  {
    pg.setMatrix(getMatrix()); // replace the PGraphics-matrix
    pg.background(102);
    pg.stroke(255, 0, 0); 
    pg.line(0, 0, 0, 100, 0, 0);
    pg.stroke(0, 255, 0); 
    pg.line(0, 0, 0, 0, 100, 0);
    pg.stroke(0, 0, 255); 
    pg.line(0, 0, 0, 0, 0, 100);
    pg.stroke(0);
    pg.fill(200);
    pg.rect(10, 10, 200, 100);
  }
  pg.endDraw();

  setMatrix(mat_scene); // replace the PeasyCam-matrix
  image(pg, 10, 10, 500, 500);

  fill(255, 100);
  rect(400, 400, 100, 200);
}
