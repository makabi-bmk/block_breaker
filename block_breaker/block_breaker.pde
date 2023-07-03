import java.util.Iterator;

void setup() {
  //init settings
  surface.setSize(START_WIDTH, START_HEIGHT);
  surface.setResizable(false);
  
  initBlockCoordinate();
  initBarArea(); 
  initBar();
  initBall();
  initDango();
  initTime();
  //addBall();
}

void draw() {
  int time = millis() / 1000;
  if (isFinish(time)) FINISH_FLAG = true;
  println(isFinish(time));
  background(255, 255, 255);
  
  if (FINISH_FLAG) {
    drawFinish();
    //noLoop();
  } else {
    drawBlocks();
    drawBarArea();
    drawBar();
    checkCollision();
    drawBalls();
    drawDango();
    drawTime(time);
    drawScore();
  }
}

//check balls and blocks collision
void checkCollision() {
  IntList removeBallsID = new IntList();
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
    else if (ball.isHitDango()) {
      removeBallsID.append(ball.getID());
      if (dango.addMochi(ball.getScore()) >= MAX_MOCHI_NUM) {
        addScore(dango.getScore());
        dango.reset();
      }
    }
    else if (ball.isFrameOut())    removeBallsID.append(ball.getID());
  }
  for (int removeBallID : removeBallsID) {
    deleteBall(removeBallID);
  }
}

void mousePressed() {
  addBall();
}

void keyPressed() {
  if (keyCode == RIGHT || keyCode == LEFT) {
    dango.move(keyCode);
  }
}
