final int START_HEIGHT = 800;
final int START_WIDTH = 600;
final int VERTICAL_RATIO = 4;
final int HORIZONTAL_RATIO = 3;

int nowHeight = START_HEIGHT;
int nowWidth = START_WIDTH;

public void SET_SCREEN_SIZE(int newWidth) {
  int newHeight = (int)((newWidth / HORIZONTAL_RATIO) * VERTICAL_RATIO);
  println(newWidth);
  nowHeight = newHeight;
  nowWidth = newWidth;
  surface.setSize(newWidth, newHeight);
} 
