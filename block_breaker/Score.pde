final int TIMER_TEXT_SIZE = 30;
final int SCORE_TEXT_SIZE = 30;
final float TEXT_COORDINATE = 10;
float TEXT_COORDINATE_Y; /* BLOCK_AREA_END + BAR_AREA_SIZE + 40 */

final int[] TIME_BONUS_THRESHOLD = {3, 6, 9};
final int[] TIME_BONUS = {4, 3, 2};
final int TIME_BONUS_NONE = 3;

float totalScore = 0;
int lastTimeForEatting;

void initTime() {
  TEXT_COORDINATE_Y = BLOCK_AREA_END + BAR_AREA_SIZE + 40;
  FINISH_FLAG = false;
  lastTimeForEatting = 0;
  lightUpHungerData(0);
}

void setLastTimeForEatting(int time) {
  for (int i = 0; i < TIME_BONUS_THRESHOLD.length; i++) {
    int timeBonus = TIME_BONUS_THRESHOLD[i];
    if (time - lastTimeForEatting < timeBonus) {
      lightUpHungerData(i);
      return;
    }
  }
  lightUpHungerData(TIME_BONUS_NONE);
  return;
}

void drawTime(int m) {
  textSize(TIMER_TEXT_SIZE);
  fill(0, 0, 0);
  text("Time left : " + (MAX_TIME - m), TEXT_COORDINATE, TEXT_COORDINATE_Y);
}

boolean isFinish(int m) {
  return (m >= MAX_TIME) ;
}

void drawScore() {
  textSize(SCORE_TEXT_SIZE);
  fill(0, 0, 0);
  text("Score : " + totalScore, TEXT_COORDINATE, TEXT_COORDINATE_Y + TIMER_TEXT_SIZE);
}

void addScore(int score, int time) {
  float bonus = 1;
  for (int i = 0; i < TIME_BONUS_THRESHOLD.length; i++) {
    if (lastTimeForEatting < TIME_BONUS_THRESHOLD[i]) {
      bonus = TIME_BONUS[i];
      break;
    }
  }
  
  totalScore += bonus * score;
  lastTimeForEatting = time;
}
