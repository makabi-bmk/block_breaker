/* STATIC AREA START */

// arrangement setting
final int BLOCK_AREA_DIVISION_NUM = 20;
final float BLOCK_AREA_START  = 100;
final float BLOCK_AREA_END    = 500;
final float BLOCK_SIZE = (BLOCK_AREA_END - BLOCK_AREA_START) / BLOCK_AREA_DIVISION_NUM;
final int BLOCK_AREA_NUM = BLOCK_AREA_DIVISION_NUM * BLOCK_AREA_DIVISION_NUM;
final int BLOCK_MAX_NUM = BLOCK_AREA_NUM / 5;
final int INTERVAL_TIME = 30;

// status setting
final int STATUS_B = 0;
final int STATUS_N = 1;
final int STATUS_R = 2;
final int STATUS_SR = 3;
final int[][] BLOCK_COLORS = {{50, 168, 82}, {230, 229, 227}, {242, 227, 63}, {189, 91, 53}};
final int[] STATUS_SCORE = {-7, 1, 3, 5};

// manage arrangement
boolean[][] blockExists = new boolean[BLOCK_AREA_DIVISION_NUM][BLOCK_AREA_DIVISION_NUM];
Block[] blocks = new Block[BLOCK_MAX_NUM];

void initBlockCoordinate() {
  IntList b = new IntList();
  for (int i = 0; i < BLOCK_AREA_NUM; i++) b.append(i);
  b.shuffle();
  
  for(int i = 0; i < BLOCK_MAX_NUM; i++) {
    int x = getBlockCoordinateX(b.get(i));
    int y = getBlockCoordinateY(b.get(i));
    blockExists[x][y] = true;
    blocks[i] = new Block(i, x, y);
    //println(blocks[i]);
  }
}

void drawBlocks() {
  noStroke();
  for (Block block : blocks) {
    if (block.getVisiable()) {
      int[] mColor = block.getColor();
      float[] topLeftCorner = block.getTopLeftCorner();
      fill(mColor[R], mColor[G], mColor[B]);
      rect(topLeftCorner[X], topLeftCorner[Y], BLOCK_SIZE, BLOCK_SIZE);
    } else {
      
    }
  }
}

void deleteBlock(int blockID) {
  Block block = blocks[blockID];
  block.delete();
  //block.visiable = false;
  blockExists[block.getX()][block.getY()] = false;
}

int[] getBlockCoordinate(int num) {
  int[] coordinate = {(num / BLOCK_AREA_DIVISION_NUM), num % BLOCK_AREA_DIVISION_NUM};
  return coordinate;
}

int getBlockCoordinate(int x, int y) {
  return x * BLOCK_AREA_DIVISION_NUM + y;
}

int getBlockCoordinateX(int num) {
  return num / BLOCK_AREA_DIVISION_NUM;
}
int getBlockCoordinateY(int num) {
  return num % BLOCK_AREA_DIVISION_NUM;
}

/* STATIC AREA END */

/* CLASS AREA START */
public class Block {
  
  private int ID;
  private int status;
  private int[] mColor = new int[3];
  private int x, y;
  private float[][] corners = new float[4][2];
  private boolean visiable;
  private int interval;
  
  public Block(int ID, int x, int y) {
    this.ID = ID;
    initSettings(x, y);
  }
  
  private void initSettings(int x, int y) {
    this.visiable = true;
    this.interval = 0;
    initCoordinate(x, y);
    initStatus();
    initColor();
  }
  
  public int getID() {
    return this.ID;
  }
  
  public int getStatus() {
    return this.status;
  }
  
  public boolean getVisiable() {
    if (this.visiable == false)  {
      this.interval++;
      if (this.interval > INTERVAL_TIME) generate();
    }
    return this.visiable;
  }
  
  public int[] getColor() {
    return this.mColor;
  }
  
  public int getX() {
    return this.x;
  }
  
  public int getY() {
    return this.y;
  }
  
  public float[] getTopLeftCorner() {
    float[] topLeftCorner = {this.corners[TOP_LEFT][X], this.corners[TOP_RIGHT][Y]};
    return topLeftCorner;
  }
  
  public float[] getButtomRightCorner() {
    float[] buttomRightCorner = {this.corners[BUTTOM_RIGHT][X], this.corners[BUTTOM_RIGHT][Y]};
    return buttomRightCorner;
  }
  
  private void generate() {
    int newX, newY;
    do {
      newX = (int)random(BLOCK_AREA_DIVISION_NUM);
      newY = (int)random(BLOCK_AREA_DIVISION_NUM);
    } while(blockExists[newX][newY] == true);
    initSettings(newX, newY);
  }
  
  private void initCoordinate(int x, int y) {
    this.x = x;
    this.y = y;
    this.corners[TOP_LEFT][X]    = this.corners[BUTTOM_LEFT][X]  = BLOCK_AREA_START + x * BLOCK_SIZE;
    this.corners[TOP_LEFT][Y]    = this.corners[TOP_RIGHT][Y]    = BLOCK_AREA_START + y * BLOCK_SIZE;
    this.corners[TOP_RIGHT][X]   = this.corners[BUTTOM_RIGHT][X] = BLOCK_AREA_START + x + BLOCK_SIZE + BLOCK_SIZE;
    this.corners[BUTTOM_LEFT][Y] = this.corners[BUTTOM_RIGHT][Y] = BLOCK_AREA_START + y * BLOCK_SIZE + BLOCK_SIZE;
  }
  
  private void initStatus() {
    float rand = random(1);
    if      (rand < 0.1) this.status = STATUS_B;
    else if (rand < 0.2) this.status = STATUS_SR;
    else if (rand < 0.4) this.status = STATUS_R;
    else                 this.status = STATUS_N;
    return;
  }
  
  private void initColor() {
    this.mColor[R] = BLOCK_COLORS[this.status][R];
    this.mColor[G] = BLOCK_COLORS[this.status][G];
    this.mColor[B] = BLOCK_COLORS[this.status][B];
  }
  
  public void delete() {
    this.visiable = false;
    this.interval = 0;
  }
  
  public String toString() {
    return "ID = " + this.ID + ", x = " + this.corners[TOP_LEFT][X] + ", y = " + this.corners[TOP_LEFT][Y] + ", status = " + this.status + ", color = {" + this.mColor[R] + "," + this.mColor[G] + "," + this.mColor[B] + "}";
  }
}
/* CLASS AREA END */
