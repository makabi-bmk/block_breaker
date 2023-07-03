import ddf.minim.*;

final float DANGO_BAR_LENGTH = 100;
final String HAND_NAME = "hand.png";
final String EATING_SOUND_NAME = "eating.mp3";
final float HAND_SIZE = 60;
final float DANGO_BAR_WEIGHT = 10;
final float DANGO_VX = 30;
final int MAX_MOCHI_NUM = 3;
float MOCHI_RADIUS; /* BALL_RADIUS * 1.3 */
float[] MOCHI_COORDINATE_Y = new float[MAX_MOCHI_NUM];

Dango dango = new Dango();
PImage hand;

Minim minim;
AudioPlayer player;

void initDango() {
  hand = loadImage(HAND_NAME);
  MOCHI_RADIUS = BALL_RADIUS * 1.3;
  minim = new Minim(this);
  player = minim.loadFile(EATING_SOUND_NAME);
  
  float mochiY = height - (HAND_SIZE + BALL_RADIUS);
  for (int i = 0; i < MAX_MOCHI_NUM; i++) {
    MOCHI_COORDINATE_Y[i] = mochiY;
    mochiY -= MOCHI_RADIUS;
  }
}

void drawDango() {
  dango.updateCorner();
  float[] dangoTopLeftCorner = dango.getTopLeftCorner();
  
  strokeWeight(DANGO_BAR_WEIGHT);
  stroke(0 ,0, 0);
  line(dangoTopLeftCorner[X] + HAND_SIZE / 2, dangoTopLeftCorner[Y], dangoTopLeftCorner[X] + HAND_SIZE / 2, height);
  noStroke();
  
  image(hand, dango.x, dango.y, HAND_SIZE, HAND_SIZE);
  float x = dango.getX();
  for (int i = 0; i < dango.getMochi().size(); i++) {
    Ball mochi = dango.getMochi(i);
    mochi.updateCoordinate(x, MOCHI_COORDINATE_Y[i]);
    
    int[] mColor = mochi.getColor();
    fill(mColor[R], mColor[G], mColor[B]);
    ellipse(dangoTopLeftCorner[X] + HAND_SIZE / 2, MOCHI_COORDINATE_Y[i], MOCHI_RADIUS, MOCHI_RADIUS);
  }
}

public class Dango {
  private float x, y;
  private ArrayList<Ball> mochi;
  private int score;
  private float[][] corners = new float[4][2];
  
  public Dango() {
    this.x = width / 2;
    this.y = START_HEIGHT - HAND_SIZE;
    this.mochi = new ArrayList<Ball>();
    this.score = 0;
  }
  
  public void updateCorner() {
      this.corners[TOP_LEFT][X]     = this.corners[BUTTOM_LEFT][X]  = dango.getX();
      this.corners[TOP_RIGHT][X]    = this.corners[BUTTOM_RIGHT][X] = dango.getX() + HAND_SIZE;
      this.corners[TOP_LEFT][Y]     = this.corners[TOP_RIGHT][Y]    = height - (HAND_SIZE + MOCHI_RADIUS * MAX_MOCHI_NUM);
      this.corners[BUTTOM_RIGHT][Y] = this.corners[BUTTOM_LEFT][Y]  = height;
  }
  
  public int addMochi(int score) { 
    this.mochi.add(new Ball(score));
    this.score += score;
    return this.mochi.size();
  }
  
  public void reset() {
    this.mochi.clear();
    this.score = 0;
  }
  
  public int getScore() { 
    return this.score;
  }
  
  public float[] getTopLeftCorner() {
    float[] topLeftCorner = {this.corners[TOP_LEFT][X], this.corners[TOP_RIGHT][Y]};
    return topLeftCorner;
  }
  
  public float[] getButtomRightCorner() {
    float[] buttomRightCorner = {this.corners[BUTTOM_RIGHT][X], this.corners[BUTTOM_RIGHT][Y]};
    return buttomRightCorner;
  }
  
  public ArrayList<Ball> getMochi() {
    return this.mochi;
  }
  
  public Ball getMochi(int num) {
    return this.mochi.get(num);
  }
  
  public float getX() {
    return this.x;
  }
  
  public void move(int pressedKey) {
    switch(pressedKey) {
      case RIGHT:
        this.x += DANGO_VX;
        if (this.x + HAND_SIZE >= width) this.x = width - HAND_SIZE;
        break;
       
       case LEFT:
         this.x -= DANGO_VX;
         if (this.x < 0) this.x = 0;
         break;
    }
  }
}
