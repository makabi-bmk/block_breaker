void setup() {
  //init settings
  surface.setSize(START_WIDTH, START_HEIGHT);
  surface.setResizable(false);
  
  initBlockCoordinate();
  initBarArea(); 
  initBar();
}

void draw() {
  background(255, 255, 255);
  drawBlocks();
  drawBarArea();
  drawBar();
}
