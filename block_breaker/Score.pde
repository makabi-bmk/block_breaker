final int TIMER_TEXT_SIZE = 30;
final int SCORE_TEXT_SIZE = 30;
final float TEXT_COORDINATE = 10;
float TEXT_COORDINATE_Y; /* BLOCK_AREA_END + BAR_AREA_SIZE + 40 */

int totalScore = 0;

void initTime() {
  TEXT_COORDINATE_Y = BLOCK_AREA_END + BAR_AREA_SIZE + 40;
  FINISH_FLAG = false;
}

void drawTime(int m) {
  textSize(TIMER_TEXT_SIZE);
  fill(0, 0, 0);
  text("time  :" + (MAX_TIME - m), TEXT_COORDINATE, TEXT_COORDINATE_Y);
}

boolean isFinish(int m) {
  //return false;
  return (m >= MAX_TIME) ;
}

void drawScore() {
  textSize(SCORE_TEXT_SIZE);
  fill(0, 0, 0);
  text("score:" + totalScore, TEXT_COORDINATE, TEXT_COORDINATE_Y + TIMER_TEXT_SIZE);
}

void addScore(int score) {
  totalScore += score;
}
