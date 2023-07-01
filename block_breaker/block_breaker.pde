void setup() {
  //init settings
  surface.setSize(START_WIDTH, START_HEIGHT);
  surface.setResizable(false);
  background(255, 255, 255);
  initBlockCoordinate();
  initBarArea(); 
}

void draw() {
    drawBlocks();
    drawBarArea();
}
