Path path;

void setup() {
  size(600, 600, P3D);
  
  // The file "bot.obj" must be in the data folder
  // of the current sketch to load successfully
  path = new Path("curve2.obj");
}

void draw() {
  background(200);
  
  path.update();
  path.display();
  path.show3D();
  

}
