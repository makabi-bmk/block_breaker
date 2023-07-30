final int MAX_BALL_NUM = 5;
final float BALL_RADIUS = 30;
final float BALL_PADDING = 3;
final float MIN_VELOCITY = 3;
int[] BALL_DEFAULT_COLOR; /* BLOCK_COLORS[STATUS_N] */

/* ~0 BAD, 0~10 NORMAL, 11~30 GOOD 30^ VERYGOOD */
int[] SCORE_THRESHOLD = {0, 10, 30};

ArrayList<Ball> balls;
int LAST_BALL_ID = 0;

boolean addBallFlag = true;

void initBall() {
  BALL_DEFAULT_COLOR = BLOCK_COLORS[STATUS_N];
  balls = new ArrayList<Ball>();
}

void addBall() {
  if (balls.size() <= MAX_BALL_NUM) {
    balls.add(new Ball());
  }
}

void addBall(float x, float y) {
  if (balls.size() <= MAX_BALL_NUM) {
    balls.add(new Ball(x, y));
    addBallFlag = false;
  }
}

void deleteBall(int ballID) {
  for (int i = 0; i < balls.size(); i++) {
    if (balls.get(i).getID() == ballID) balls.remove(i);
  }
}

int getBallID() {
  return LAST_BALL_ID++;
}

void drawBalls() {
  for (Ball ball : balls) {
    ball.updateCoordinate();
    int[] mColor = ball.getColor();
    fill(mColor[R], mColor[G], mColor[B]);
    ellipse(ball.getX(), ball.getY(), BALL_RADIUS, BALL_RADIUS);
  }
}

public class Ball {
  private int ID;
  private float x, y;
  private float vx, vy;
  private int score;
  private int[] mColor = new int[3];
  
  public Ball() {
    this.ID = getBallID();
    this.x = mouseX;
    this.y = mouseY;
    this.vx = random(4);
    this.vy = -5;
    this.mColor[R] = BALL_DEFAULT_COLOR[R];
    this.mColor[G] = BALL_DEFAULT_COLOR[G];
    this.mColor[B] = BALL_DEFAULT_COLOR[B];
  }
  
  public Ball(float x, float y) {
    this.ID = getBallID();
    this.x = x;
    this.y = y;
    this.vx = random(4);
    this.vy = -5;
    this.mColor[R] = BALL_DEFAULT_COLOR[R];
    this.mColor[G] = BALL_DEFAULT_COLOR[G];
    this.mColor[B] = BALL_DEFAULT_COLOR[B];
  }
  
  public Ball(int score) {
    setColor(score);
  }
  
  public int getID() {
    return this.ID;
  }
  
  public float getX() {
    return this.x;
  }
  
  public float getY() {
    return this.y;
  }
  
  public int getScore() {
    return this.score;
  }
   
  public boolean isHitSideWall() {    
    return ((this.x - BALL_RADIUS < 0) || (width < this.x + BALL_RADIUS));
  }
  
  public boolean isHitTopWall() {
    return (this.y - BALL_RADIUS < 0);
  }
  
  public boolean isFrameOut() {
    return (height < this.y + BALL_RADIUS);
    
  }
  
  public boolean isHitDango() {
    float[] dangoTopLeftCorner = dango.getTopLeftCorner();
    float[] dangoButtomRightCorner = dango.getButtomRightCorner();
    
    float dangoLeft = dangoTopLeftCorner[X];
    float dangoRight = dangoButtomRightCorner[X];
    float dangoTop = dangoTopLeftCorner[Y];
    
    if (dangoLeft <= this.x && this.x <= dangoRight) {
      if (dangoTop < this.y) {
        return true;
      }
    }
    return false;
  }
  
  public boolean isHitBar(Bar bar) {
    if (bar.getVisiable() == false) return false;
    
    float[] barTopLeftCorner = bar.getTopLeftCorner();
    float[] barButtomRightCorner = bar.getButtomRightCorner();
    
    float barLeft = barTopLeftCorner[X];
    float barRight = barButtomRightCorner[X];
    float barTop = barTopLeftCorner[Y];
    float barButtom = barButtomRightCorner[Y];
    
    if (barLeft <= this.x && this.x <= barRight) {
      if (barTop <= this.y && this.y <= barButtom) {
        return true;
      }
    }
    
    return false;
  }
  
  public void updateCoordinate() {
    this.x += this.vx;
    this.y += this.vy;
  }
  
  public void updateCoordinate(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  public void addScore(int statusNum) {
    this.score += STATUS_SCORE[statusNum];
    setColor();
  }
  
  private void setColor() {
    int status;
    if      (this.score < SCORE_THRESHOLD[0]) status = STATUS_B;
    else if (this.score < SCORE_THRESHOLD[1]) status = STATUS_N;
    else if (this.score < SCORE_THRESHOLD[2]) status = STATUS_R;
    else                                      status = STATUS_SR;
    this.mColor[R] = BLOCK_COLORS[status][R];
    this.mColor[G] = BLOCK_COLORS[status][G];
    this.mColor[B] = BLOCK_COLORS[status][B];
  }
  
  private void setColor(int score) {
    int status;
    if      (score < SCORE_THRESHOLD[0]) status = STATUS_B;
    else if (score < SCORE_THRESHOLD[1]) status = STATUS_N;
    else if (score < SCORE_THRESHOLD[2]) status = STATUS_R;
    else                                      status = STATUS_SR;
    this.mColor[R] = BLOCK_COLORS[status][R];
    this.mColor[G] = BLOCK_COLORS[status][G];
    this.mColor[B] = BLOCK_COLORS[status][B];
  }
  
  public int[] getColor() {
    return this.mColor;
  }
  
  public int getHitBlock(Block[] blocks) {
    for (Block block : blocks) {
      if (block.getVisiable() == false) continue;
      float[] blockTopLeftCorner = block.getTopLeftCorner();
      
      if (blockTopLeftCorner[X] <= this.x + BALL_RADIUS && this.x - BALL_RADIUS <= blockTopLeftCorner[X] + BLOCK_SIZE) {
        if (blockTopLeftCorner[Y] <= this.y && this.y <= blockTopLeftCorner[Y] + BLOCK_SIZE) {
          return block.getID();
        }
      } 
    }
    return NONE;
  }
  
  public void bounce() {
    this.vx = (random(1) > 0.5) ? this.vx : -1 * this.vx;
    this.vy = (random(1) > 0.9) ? this.vy : -1 * this.vy;
  }
  
  public void bounce(boolean isTop) {
    if (isTop) {
      this.y = BALL_RADIUS;
      this.vy = abs(this.vy);
    }
    else this.vx = -1 * this.vx;
  }
  
  public void bounce(Bar bar) {
    BarStatus status = bar.getStatus();
    //println(bar.vx);
    //println(bar.vy);
    //println("---------");
    
    if (status == BarStatus.Top){
      this.vx = -1 * max(bar.vx, MIN_VELOCITY);
      this.vy = abs(this.vy);
    } else if (status == BarStatus.Buttom) {
      this.vx = -1 * max(bar.vx, MIN_VELOCITY);
      this.vy = -1 * abs(this.vy);
    } else if (status == BarStatus.Right) {
      this.vy = max(bar.vy, MIN_VELOCITY);
      this.vx = -1 * abs(this.vx);
    } else if (status == BarStatus.Left) {
      this.vy = max(bar.vy, MIN_VELOCITY);
      this.vx = abs(this.vx);
    }
  }
}
