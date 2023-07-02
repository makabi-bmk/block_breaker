final int MAX_BALL_NUM = 5;
final float BALL_RADIUS = 40;
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
    return false;
  }
  
  public void updateCoordinate() {
    this.x += this.vx;
    this.y += this.vy;
  }
  
  public int getHitBlock(Block[] blocks) {
    for (Block block : blocks) {
      float[] blockTopLeftCorner = block.getTopLeftCorner();
      float[] blockButtomRightCorner = block.getButtomRightCorner();
      
      //println("--------------");
      //println(blockTopLeftCorner);
      //println(blockButtomRightCorner);
      //println(this.x);
      //println(this.y);
      
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
      float[] blockButtomRightCorner = block.getButtomRightCorner();
      
      //println("--------------");
      //println(blockTopLeftCorner);
      //println(blockButtomRightCorner);
      //println(x);
      //println(y);
      
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
    println(this.x);
    println(this.y);
    println("--------------");
    this.x = -1 * this.x;
    this.y = -1 * this.y;
    //println("bounce");
    println(this.x);
    println(this.y);
  }
  
  public void bounce(float x, float y) {
    println(x);
    println(y);
    println("--------------");
    this.x = -1 * x;
    this.y = -1 * y;
    //println("bounce");
    println(this.x);
    println(this.y);
  }
}
