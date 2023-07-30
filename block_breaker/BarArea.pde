float BAR_AREA_SIZE;
float BLOCK_AREA; // BLOCK_AREA_END - BLOCK_AREA_START

final int TOP_AREA    = 0;
final int BUTTOM_AREA = 1;
final int RIGHT_AREA  = 2;
final int LEFT_AREA   = 3;
final int[] NOMAL_COLOR = {229, 246, 251};
final int[] FOCUS_COLOR = {180, 227, 242};

BarArea[] barAreas = new BarArea[4];

void initBarArea() {
  BAR_AREA_SIZE = BLOCK_AREA_START;
  BLOCK_AREA = BLOCK_AREA_END - BLOCK_AREA_START;
  barAreas[TOP_AREA]    = new BarArea(BAR_AREA_SIZE, 0, BarStatus.Top);
  barAreas[BUTTOM_AREA] = new BarArea(BAR_AREA_SIZE, BAR_AREA_SIZE + BLOCK_AREA, BarStatus.Buttom);
  barAreas[RIGHT_AREA]  = new BarArea(BAR_AREA_SIZE + BLOCK_AREA, BAR_AREA_SIZE, BarStatus.Right);
  barAreas[LEFT_AREA]   = new BarArea(0, BAR_AREA_SIZE, BarStatus.Left);
}

void drawBarArea(int area, int direction) {
  for (int i = 0; i < 4; i++) {
    float[] topLeftCorner = barAreas[i].getTopLeftCorner();
    float[] buttomRightCorner = barAreas[i].getButtomRightCorner();
    int[] colors;
    
    if (barAreas[i].inRange(area)) colors = FOCUS_COLOR;
    else colors = NOMAL_COLOR;
    
    fill(colors[R], colors[G], colors[B]);
    rect(topLeftCorner[X], topLeftCorner[Y], buttomRightCorner[X] - topLeftCorner[X], buttomRightCorner[Y] - topLeftCorner[Y]);
  }
}

void drawBarArea() {
  for (int i = 0; i < 4; i++) {
    float[] topLeftCorner = barAreas[i].getTopLeftCorner();
    float[] buttomRightCorner = barAreas[i].getButtomRightCorner();
    int[] colors;
    
    if (barAreas[i].inRange(mouseX, mouseY)) colors = FOCUS_COLOR;
    else colors = NOMAL_COLOR;
    
    fill(colors[R], colors[G], colors[B]);
    rect(topLeftCorner[X], topLeftCorner[Y], buttomRightCorner[X] - topLeftCorner[X], buttomRightCorner[Y] - topLeftCorner[Y]);
  }
}

public class BarArea {
  private float[][] corners = new float[4][2];
  private BarStatus status;
  
  public BarArea(float x, float y, BarStatus status) {
    this.status = status;
    this.corners[TOP_LEFT][X]    = this.corners[BUTTOM_LEFT][X]  = x;
    this.corners[TOP_LEFT][Y]    = this.corners[TOP_RIGHT][Y]    = y;
    
    if (status == BarStatus.Top || status == BarStatus.Buttom) {  
      this.corners[TOP_RIGHT][X]   = this.corners[BUTTOM_RIGHT][X] = x + BLOCK_AREA;
      this.corners[BUTTOM_LEFT][Y] = this.corners[BUTTOM_RIGHT][Y] = y + BAR_AREA_SIZE;
    } else {
      this.corners[TOP_RIGHT][X]   = this.corners[BUTTOM_RIGHT][X] = x + BAR_AREA_SIZE;
      this.corners[BUTTOM_LEFT][Y] = this.corners[BUTTOM_RIGHT][Y] = y + BLOCK_AREA;
    }
  }
  
  public BarStatus getStatus() {
    return this.status;
  }
  
  public float[] getTopLeftCorner() {
    float[] topLeftCorner = {this.corners[TOP_LEFT][X], this.corners[TOP_RIGHT][Y]};
    return topLeftCorner;
  }
  
  public float[] getButtomRightCorner() {
    float[] buttomRightCorner = {this.corners[BUTTOM_RIGHT][X], this.corners[BUTTOM_RIGHT][Y]};
    return buttomRightCorner;
  }
  
  public String toString() {
    return corners[TOP_LEFT][X] + ", " + corners[TOP_LEFT][Y] + ", " + corners[TOP_RIGHT][X] + ", " + corners[TOP_RIGHT][Y] + ", " + corners[BUTTOM_LEFT][X] + ", " + corners[BUTTOM_LEFT][Y] + ", " + corners[BUTTOM_RIGHT][X] + ", " + corners[BUTTOM_RIGHT][Y]; 
  }
  
  public boolean inRange(int area) {
    BarStatus areaStatus;
    switch(area) {
      case 1:
        areaStatus = BarStatus.Top;
        break;
      case 2:
        areaStatus = BarStatus.Buttom;
        break;
      case 3:
        areaStatus = BarStatus.Left;
        break;
      case 4:
        areaStatus = BarStatus.Right;
        break;
    }
    
    if (area == status) {
      return true;
    }
    return false;
  }
  
  public boolean inRange(int x, int y) {
    if (corners[TOP_LEFT][X] < x && x < corners[TOP_RIGHT][X]){
      if (corners[TOP_LEFT][Y] < y && y < corners[BUTTOM_LEFT][Y]) {
        return true;
      }
    }
    return false;
  }
  
  public boolean inRange(BarStatus status) {
    if (this.status == status) return true;
    return false;
  }
}
