import java.util.Iterator;

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
  IntList removeBallsID;
  //Iterator iterator = ball.iterator();
  for (Ball ball : balls) {
  //Iterator<Ball> ballIterator = balls.iterator();
  //while (ballIterator.hasNext()) {
    //Ball ball = ballIterator.next();
    int hitBlockID = ball.getHitBlock(blocks);
    //println(hitBlockID);
    if (hitBlockID != NONE) {
      ball.bounce();
      ball.addScore(blocks[hitBlockID].getStatus());
      deleteBlock(hitBlockID);
    }
    else if (ball.isHitSideWall()) ball.bounce(false);
    else if (ball.isHitTopWall())  ball.bounce(true);
    else if (ball.isHitBar(bar))   ball.bounce(bar);
    //else if (ball.isFrameOut())    deleteBall(ball.getID());
    else if (ball.isFrameOut())    removeBallsID.set(ball.getID()));
  }
  for ()
}

void mousePressed() {
  addBall();
}
