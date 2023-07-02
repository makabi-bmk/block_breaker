final int MAX_BALL_NUM = 5;
final float BALL_RADIUS = 30;
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
    this.vx = 0;
    this.vy = -5;
  }
  
  public float getX() {
    return this.x;
  }
  
  public float getY() {
    return this.y;
  }
  
  public boolean isHitWall() {
    println(this.x);
    println(this.y);
    return false;
  }
  
  public void updateCoordinate() {
    this.x += this.vx;
    this.y += this.vy;
  }
  
  // このメソッドはthis.xとthis.yが動かない なぜ
  public int getHitBlock(Block[] blocks) {
    for (Block block : blocks) {
      float[] blockTopLeftCorner = block.getTopLeftCorner();
      float[] blockButtomRightCorner = block.getButtomRightCorner();
      
      if (blockTopLeftCorner[X] <= this.x && this.x <= blockButtomRightCorner[X]) {
        if (blockTopLeftCorner[Y] <= this.y && this.y <= blockButtomRightCorner[Y]) {
          //println("collision");
          return block.getID();
        }
      } 
    }
    return NONE;
  }
  
  public int getHitBlock(Block[] blocks, float x, float y) {
    for (Block block : blocks) {
      float[] blockTopLeftCorner = block.getTopLeftCorner();
      
      if (blockTopLeftCorner[X] <= x && x <= blockTopLeftCorner[X] + BLOCK_SIZE) {
        if (blockTopLeftCorner[Y] <= y && y <= blockTopLeftCorner[Y] + BLOCK_SIZE) {
          println("collision");
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
