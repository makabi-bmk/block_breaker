void setup() {
  surface.setSize(START_WIDTH, START_HEIGHT);
  surface.setResizable(false);
  
  initBlockCoordinate();
  initBarArea(); 
  initBar();
  initBall();
  initDango();
  initTime();
  initSerial();
}

void draw() {
  int time = millis() / 1000;
  if (isFinish(time)) FINISH_FLAG = true;
  background(255, 255, 255);
  
  if (FINISH_FLAG) {
    drawFinish();
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

void checkCollision() {
  IntList removeBallsID = new IntList();
  for (Ball ball : balls) {
    int hitBlockID = ball.getHitBlock(blocks);
    if (hitBlockID != NONE) {
      ball.bounce();
      ball.addScore(blocks[hitBlockID].getStatus());
      deleteBlock(hitBlockID);
    }
    else if (ball.isHitSideWall()) ball.bounce(false);
    else if (ball.isHitTopWall())  ball.bounce(true);
    else if (ball.isHitBar(bar))   ball.bounce(bar);
    else if (ball.isFrameOut())    removeBallsID.append(ball.getID());
    else if (ball.isHitDango()) {
      removeBallsID.append(ball.getID());
      if (dango.addMochi(ball.getScore()) >= MAX_MOCHI_NUM) {
        player.play();
        player.rewind();
        addScore(dango.getScore());
        dango.reset();
      }
    }
  }
  for (int removeBallID : removeBallsID) {
    deleteBall(removeBallID);
  }
}

void mousePressed() {
  addBall();
}

void keyPressed() {
  if (keyCode == RIGHT || keyCode == 'D') {
    dango.move(true);
  } else if(keyCode == LEFT || keyCode == 'A') {
    dango.move(false);
  }
}

void stop() {
  player.close();
  minim.stop();
  super.stop();
}
