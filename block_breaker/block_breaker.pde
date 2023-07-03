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
    int hitBlockID = ball.getHitBlock(blocks);
    //println(hitBlockID);
    if (hitBlockID != NONE) {
      ball.bounce();
    }
    if (ball.isHitWall()) {
      ball.bounce();
    }
    if (ball.isHitBar(bar)) {
      ball.bounce();
    }
  }
}

void mousePressed() {
  addBall();
}
