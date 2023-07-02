void setup() {
  //init settings
  surface.setSize(START_WIDTH, START_HEIGHT);
  surface.setResizable(false);
  
  initBlockCoordinate();
  initBarArea(); 
  initBar();
  initBall();
  addBall();
}

void draw() {
  background(255, 255, 255);
  drawBlocks();
  drawBarArea();
  drawBar();
  checkCollision();
  drawBalls();
  
}

//check balls and blocks collision
void checkCollision() {
  for (Ball ball : balls) {
    //println(ball.getX());
    //println(ball.getY());
    int hitBlockID = ball.getHitBlock(blocks, ball.getX(), ball.getY());
    //println(hitBlockID);
    if (hitBlockID != NONE) {
      ball.bounce();
    }
    //ball.updatePosition();
  }
}

void mousePressed() {
  addBall();
}
