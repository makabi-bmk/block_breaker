final int MAX_BALL_NUM = 5;
final float BALL_RADIUS = 20;
final float BALL_PADDING = 3;
ArrayList<Ball> balls;

void initBall() {
  balls = new ArrayList<Ball>();
}

void addBall() {
  if (balls.size() <= MAX_BALL_NUM) {
    balls.add(new Ball());
  }
}

void drawBalls() {
  for (Ball ball : balls) {
    ball.updateCoordinate();
    fill(0, 0, 0);
    ellipse(ball.getX(), ball.getY(), BALL_RADIUS, BALL_RADIUS);
  }
}

public class Ball {
  private float x, y;
  private float vx, vy;
  
  public Ball() {
    this.x = START_WIDTH / 2;
    this.y = 700;
    this.vx = 3;
    this.vy = -5;
  }
  
  public float getX() {
    return this.x;
  }
  
  public float getY() {
    return this.y;
  }
   
  public boolean isHitWall() {    
    return ((this.x - BALL_RADIUS < 0) || (width < this.x + BALL_RADIUS) || (this.y - BALL_RADIUS < 0) || (height < this.y + BALL_RADIUS));
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
  
  public int getHitBlock(Block[] blocks) {
    for (Block block : blocks) {
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
    this.vx = -1 * this.vx;
    this.vy = -1 * this.vy;
  }
}
