

void setup() {
  //init settings
  surface.setSize(START_WIDTH, START_HEIGHT);
  surface.setResizable(false);
  initBlockCoordinate();
  background(255, 255, 255);
}

void draw() {
    drawBlocks();
}
