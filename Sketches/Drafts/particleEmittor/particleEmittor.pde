String assets[] = {
  "2xGoldstein.jpg",
  "Bruno.jpg",
  "Kari.jpg"
};

PImage loadedAssets[];

ArrayList<Sprite> sprites = new ArrayList<Sprite>();
int amount = 100;

void setup() {
  size(1920, 1080, P3D);
  
  loadedAssets = new PImage[assets.length];
  for(int i = 0; i<assets.length; i++) loadedAssets[i] = loadImage(assets[i]);
  
  for(int i = 0; i<amount; i++) sprites.add(new Sprite(loadedAssets[(int)random(assets.length-1)]));
  noStroke();
}

void draw() {
  fill(255, 15);
  rect(0, 0, width, height);
  for (Sprite sprite : sprites) {
    sprite.update();
    sprite.display();
  }
  push();
  fill(255);
  textSize(200);
  textAlign(CENTER, CENTER);
  text("DAYDREAM", width/2, height/2);
  pop();
}
