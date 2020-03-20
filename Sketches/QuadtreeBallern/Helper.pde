
void keyPressed() {
  if (keyCode == RIGHT) {
    if(normalizedBorders[0] < 500) normalizedBorders[0]++;
  } else if(keyCode == LEFT) {
    if(normalizedBorders[0] >= 0) normalizedBorders[0]--;
  } else if(keyCode == UP) {
    if(globalSizeLimit < 500)
    globalSizeLimit++;
    
    
  } else if(keyCode == DOWN) {
    if(globalSizeLimit >= 0)
    globalSizeLimit--;
    
  }
}
