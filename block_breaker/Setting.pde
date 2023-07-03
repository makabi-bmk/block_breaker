final int START_HEIGHT = 900;
final int START_WIDTH = 600;
final int MAX_TIME = 3;

final int FINISH_TEXT_COORDINATE_Y = 300;
final int FINISH_TEXT_SIZE = 50;

final int X = 0;
final int Y = 1;

final int R = 0;
final int G = 1;
final int B = 2;

final int TOP_LEFT     = 0;
final int TOP_RIGHT    = 1;
final int BUTTOM_LEFT  = 2;
final int BUTTOM_RIGHT = 3;

final int NONE = -1;

boolean FINISH_FLAG = false;
final String DANGO_IMG_NAME = "dango.png";
final float DANGO_IMG_SIZE = 300;
PImage dangoImg;

enum BarStatus {
  Left,
  Right,
  Top,
  Buttom
};

float calcDistance(float a, float b) {
  return abs(a - b);
}

void drawFinish() {
  background(255, 255, 255);
  
  textSize(FINISH_TEXT_SIZE);
  text("score : " + totalScore, width / 2 - DANGO_IMG_SIZE / 2, FINISH_TEXT_COORDINATE_Y);
  
  dangoImg = loadImage(DANGO_IMG_NAME);
  image(dangoImg, width / 2 - DANGO_IMG_SIZE / 2, FINISH_TEXT_COORDINATE_Y + FINISH_TEXT_SIZE, DANGO_IMG_SIZE, DANGO_IMG_SIZE);
}
