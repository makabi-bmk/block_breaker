void setup() {
  //init settings
  surface.setSize(START_WIDTH, START_HEIGHT);
  surface.setResizable(true);
}

void draw() {
  if (height != nowHeight || width != nowWidth) {
    SET_SCREEN_SIZE(width);
  }
}
