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
    if (hitBlockID != NONE) ball.bounce();
    else if (ball.isHitSideWall()) ball.bounce(false);
    else if (ball.isHitTopWall())  ball.bounce(true);
    else if (ball.isHitBar(bar)) ball.bounce(bar);
  }
}

void mousePressed() {
  addBall();
}
