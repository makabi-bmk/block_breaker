final int MAX_BALL_NUM = 5;
final float BALL_RADIUS = 20;
final float BALL_PADDING = 3;
final float MIN_VELOCITY = 3;
int[] BALL_DEFAULT_COLOR; /* BLOCK_COLORS[STATUS_N] */

/* ~0 BAD, 0~5 NORMAL, 6~10 GOOD 11^ VERYGOOD */
int[] SCORE_THRESHOLD = {0, 5, 10};

ArrayList<Ball> balls;
int LAST_BALL_ID = 0;

void initBall() {
  BALL_DEFAULT_COLOR = BLOCK_COLORS[STATUS_N];
  balls = new ArrayList<Ball>();
}

void addBall() {
  if (balls.size() <= MAX_BALL_NUM) {
    balls.add(new Ball(getBallID()));
  }
}

void deleteBall(int ballID) {
  for (int i = 0; i < balls.size(); i++) {
    println("balls remove : " + i);
    if (balls.get(i).getID() == ballID) balls.remove(i);
    println("ballSize = " + balls.size());
  }
}

int getBallID() {
  return LAST_BALL_ID++;
}

void drawBalls() {
  for (Ball ball : balls) {
    ball.updateCoordinate();
    int[] mColor = ball.getColor();
    //fill(0, 0, 0);
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
  
  public Ball(int ID) {
    this.ID = ID;
    this.x = START_WIDTH / 2;
    this.y = 700;
    this.vx = random(4);
    this.vy = -5;
    this.mColor[R] = BALL_DEFAULT_COLOR[R];
    this.mColor[G] = BALL_DEFAULT_COLOR[G];
    this.mColor[B] = BALL_DEFAULT_COLOR[B];
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
   
  public boolean isHitSideWall() {    
    return ((this.x - BALL_RADIUS < 0) || (width < this.x + BALL_RADIUS));
  }
  
  public boolean isHitTopWall() {
    return (this.y - BALL_RADIUS < 0);
  }
  
  public boolean isFrameOut() {
    return (height < this.y + BALL_RADIUS);
    
  }
  
  public boolean isHitBar(Bar bar) {
    if (bar.getVisiable() == false) return false;
    
    float barLeft = (bar.getTopLeftCorner())[X];
    float barRight = (bar.getButtomRightCorner())[X];
    float barTop = (bar.getTopLeftCorner())[Y];
    float barButtom = (bar.getButtomRightCorner())[Y];
    
    if ((barLeft <= getLeft()) && (getRight() <= barRight)) {
      if (barTop <= getButtom() && calcDistance(barTop, getButtom()) < BALL_RADIUS
     || getTop() <= barButtom && calcDistance(getTop(), barButtom) < BALL_RADIUS) {
        return true;
      }
    }
    return false;
  }
  
  public void updateCoordinate() {
    this.x += this.vx;
    this.y += this.vy;
  }
  
  private float getLeft() {
    return this.x - BALL_RADIUS;
  }
  
  private float getRight() {
    return this.x + BALL_RADIUS;
  }
  
  private float getTop() {
    return this.y - BALL_RADIUS;
  }
  
  private float getButtom() {
    return this.y + BALL_RADIUS;
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
    //TODO: 跳ね返り方どうしよう
    this.vx = (random(1) > 0.5) ? this.vx : -1 * this.vx;
    //this.vy = -1 * this.vy;
    this.vy = (random(1) > 0.9) ? this.vy : -1 * this.vy;
  }
  
  public void bounce(boolean isTop) {
    if (isTop) {
      //this.vx = -1 * this.vx;
      this.vy = -1 * this.vy;
    } else {
      this.vx = -1 * this.vx;
      //this.vy = -1 * this.vy;
    }
    
  }
  
  public void bounce(Bar bar) {
    BarStatus status = bar.getStatus();
    if (status == BarStatus.Top || status == BarStatus.Buttom) {
      //this.vx = max(bar.vx,MIN_VELOCITY);
      this.vy = -1 * max(this.vy, MIN_VELOCITY);
    } else if (status == BarStatus.Top || status == BarStatus.Buttom) {
      //this.vx = -1 * max(this.vx, MIN_VELOCITY);
      this.vy = max(bar.vy, MIN_VELOCITY);
    }
  }
}
