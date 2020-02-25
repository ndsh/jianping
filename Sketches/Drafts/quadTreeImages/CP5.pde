void constructGUI() {
  color black = color(0, 0, 0);
  color white = color(255, 255, 255);
  color gray = color(125, 125, 125);
  cp5.setColorForeground(gray);
  cp5.setColorBackground(white);
  cp5.setColorActive(black);
  

  
  s = cp5.addSlider2D("wave")
   .setPosition(10,10)
   .setSize(width/10,height/10)
   .setMinMax(0.0f,0.0f,4.0f,4.0f)
   .setValue(0.5f,0.5f)
   //.disableCrosshair()
   ;
}
