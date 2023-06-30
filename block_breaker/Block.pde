/* STATIC AREA START */
// arrangement setting

final int BLOCK_AREA_DIVISION_NUM = 20;
final int BLOCK_AREA_NUM = BLOCK_AREA_DIVISION_NUM * BLOCK_AREA_DIVISION_NUM;
final int BLOCK_MAX_NUM = BLOCK_AREA_NUM / 4;
final float[] blockAreaStart  = {100, 100};
final float[] blockAreaEnd    = {500, 500};

// status setting
final int STATUS_B = 0;
final int STATUS_N = 1;
final int STATUS_R = 2;
final int STATUS_SR = 3;
final int[][] BLOCK_COLORS = {{180, 207, 143}, {125, 125, 125}, {255, 165, 0}, {139, 0, 0}};

// manage arrangement
boolean[] blockExists = new boolean[BLOCK_AREA_NUM];
Block[] blocks = new Block[BLOCK_MAX_NUM];

void initBlockCoordinate() {
  IntList b = new IntList();
  for (int i = 0; i < BLOCK_AREA_NUM; i++) b.append(i);
  b.shuffle();
  
  for(int i = 0; i < BLOCK_MAX_NUM; i++) {
    int x = getBlockCoordinateX(b.get(i));
    int y = getBlockCoordinateY(b.get(i));
    blockExists[i] = true;
    blocks[i] = new Block(i, x, y);
    println(blocks[i]);
  }
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
  private int[] myColor = new int[3];
  private int x;
  private int y;
  
  public Block(int ID, int x, int y) {
    this.ID = ID;
    this.x = x;
    this.y = y;
    initStatus();
    initColor();
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
    this.myColor[R] = BLOCK_COLORS[this.status][R];
    this.myColor[G] = BLOCK_COLORS[this.status][G];
    this.myColor[B] = BLOCK_COLORS[this.status][B];
  }
  
  public String toString() {
    return "ID = " + this.ID + ", x = " + this.x + ", y = " + this.y + ", status = " + this.status + ", color = {" + this.myColor[R] + "," + this.myColor[G] + "," + this.myColor[B] + "}";
  }
}
/* CLASS AREA END */
