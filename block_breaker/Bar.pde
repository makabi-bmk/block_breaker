final float BAR_SHORT_SIZE = 20;
final int[] BAR_COLOR = {12, 49, 152};
final float BAR_VELOCITY = 5;
float BAR_LONG_SIZE;  // BAR_AREA_SIZE


BarStatus nowBarDirection;

Bar bar;

void initBar() {
  BAR_LONG_SIZE = BAR_AREA_SIZE;
  bar = new Bar();
}

void setBar(int direction) {
  switch(direction) {
    case 1:
      nowBarDirection = BarStatus.Top;
      break;
    case 2:
      nowBarDirection = BarStatus.Buttom;
      break;
    case 3:
      nowBarDirection = BarStatus.Left;
      break;
    case 4:
      nowBarDirection = BarStatus.Right;
      break;
  }
}

void drawBar() {
  bar.setBarVelocity();
  
  for (int i = 0; i < 4; i++) {
    if (barAreas[i].getStatus() == nowBarArea) {
      bar.setBarCorner(barAreas[i], nowBarDirection);
      bar.setStatus(barAreas[i].status);

      float[] topLeftCorner = bar.getTopLeftCorner();
      float[] buttomRightCorner = bar.getButtomRightCorner();
      
      fill(BAR_COLOR[R], BAR_COLOR[G], BAR_COLOR[B]);
      rect(topLeftCorner[X], topLeftCorner[Y], buttomRightCorner[X] - topLeftCorner[X], buttomRightCorner[Y] - topLeftCorner[Y]);
      bar.setVisiable(true);
      return;
    }
  }
  bar.setVisiable(false); 
}

/*
void drawBar() {
  bar.setBarVelocity(mouseX, mouseY);
  
  for (int i = 0; i < 4; i++) {
    if (barAreas[i].inRange(mouseX, mouseY)) {
      bar.setBarCorner(barAreas[i], mouseX, mouseY);
      bar.setStatus(barAreas[i].status);

      float[] topLeftCorner = bar.getTopLeftCorner();
      float[] buttomRightCorner = bar.getButtomRightCorner();
      
      fill(BAR_COLOR[R], BAR_COLOR[G], BAR_COLOR[B]);
      rect(topLeftCorner[X], topLeftCorner[Y], buttomRightCorner[X] - topLeftCorner[X], buttomRightCorner[Y] - topLeftCorner[Y]);
      bar.setVisiable(true);
      return;
    }
  }
  bar.setVisiable(false);
}
*/

public class Bar {
  private float[][] corners = new float[4][2];
  private boolean visiable;
  
  private float x, y;
  
  private float pastX, pastY;
  private float vx, vy;
  private BarStatus status;
  
  public Bar() {
    this.x = 0;
    this.y = 0;
    this.pastX = mouseX;
    this.pastY = mouseY;
  }
  
  public float getX() {
    return this.x;
  }
  
  public float getY() {
    return this.y;
  }
  
  public void setBarCorner(BarArea barArea, BarStatus direction) {
    this.visiable = false;
    
    float[] barButtomRightCorner = barArea.getButtomRightCorner();
    
    float vx = 0;
    float vy = 0;
    if (direction == BarStatus.Top || direction == BarStatus.Buttom) {
      vy = (direction == BarStatus.Top) ? -BAR_VELOCITY : BAR_VELOCITY; 
    } else if (direction == BarStatus.Left || direction == BarStatus.Right) {
      vx = (direction == BarStatus.Left) ? -BAR_VELOCITY : BAR_VELOCITY;
    }
    
    x += vx;
    y += vy;
    if (x < BLOCK_AREA_START) x = BLOCK_AREA_START;
    if (x > BLOCK_AREA_END)   x = BLOCK_AREA_END;
    if (y < BLOCK_AREA_START) y = BLOCK_AREA_START;
    if (y > BLOCK_AREA_END)   y = BLOCK_AREA_END;
    
    if (barArea.status == BarStatus.Top || barArea.status == BarStatus.Buttom) {
      this.corners[TOP_LEFT][X]     = this.corners[BUTTOM_LEFT][X]  = x - BAR_LONG_SIZE;
      this.corners[TOP_RIGHT][X]    = this.corners[BUTTOM_RIGHT][X] = x + BAR_LONG_SIZE;
      if (barArea.status == BarStatus.Top) {
        this.corners[TOP_LEFT][Y]     = this.corners[TOP_RIGHT][Y]    = 0;
        this.corners[BUTTOM_RIGHT][Y] = this.corners[BUTTOM_LEFT][Y]  = BAR_SHORT_SIZE;
      } else {
        this.corners[TOP_LEFT][Y]     = this.corners[TOP_RIGHT][Y]    = barButtomRightCorner[Y] - BAR_SHORT_SIZE;
        this.corners[BUTTOM_RIGHT][Y] = this.corners[BUTTOM_LEFT][Y]  = barButtomRightCorner[Y];
      }
    } else {
      this.corners[TOP_LEFT][Y]     = this.corners[TOP_RIGHT][Y]    = y - BAR_LONG_SIZE;
      this.corners[BUTTOM_LEFT][Y]  = this.corners[BUTTOM_RIGHT][Y] = y + BAR_LONG_SIZE;
      if (barArea.status == BarStatus.Left) {
        this.corners[TOP_LEFT][X]     = this.corners[BUTTOM_LEFT][X]  = 0;
        this.corners[BUTTOM_RIGHT][X] = this.corners[BUTTOM_LEFT][X]  = BAR_SHORT_SIZE;
      } else {
        this.corners[TOP_LEFT][X]     = this.corners[BUTTOM_LEFT][X]  = barButtomRightCorner[X] - BAR_SHORT_SIZE;
        this.corners[BUTTOM_RIGHT][X] = this.corners[BUTTOM_LEFT][X]  = barButtomRightCorner[X];
      }
    }
  }
  
  public void setBarCorner(BarArea barArea, float x, float y) {
    this.visiable = false;
    
    float[] barButtomRightCorner = barArea.getButtomRightCorner();
    
    if (barArea.status == BarStatus.Top || barArea.status == BarStatus.Buttom) {
      //this.corners[TOP_LEFT][Y]     = this.corners[TOP_RIGHT][Y]    = ((barButtomRightCorner[Y] + barTopLeftCorner[Y]) / 2) - (BAR_SHORT_SIZE / 2);
      //this.corners[BUTTOM_RIGHT][Y] = this.corners[BUTTOM_LEFT][Y]  = ((barButtomRightCorner[Y] + barTopLeftCorner[Y]) / 2) + (BAR_SHORT_SIZE / 2);
      this.corners[TOP_LEFT][X]     = this.corners[BUTTOM_LEFT][X]  = x - BAR_LONG_SIZE;
      this.corners[TOP_RIGHT][X]    = this.corners[BUTTOM_RIGHT][X] = x + BAR_LONG_SIZE;
      if (barArea.status == BarStatus.Top) {
        this.corners[TOP_LEFT][Y]     = this.corners[TOP_RIGHT][Y]    = 0;
        this.corners[BUTTOM_RIGHT][Y] = this.corners[BUTTOM_LEFT][Y]  = BAR_SHORT_SIZE;
      } else {
        this.corners[TOP_LEFT][Y]     = this.corners[TOP_RIGHT][Y]    = barButtomRightCorner[Y] - BAR_SHORT_SIZE;
        this.corners[BUTTOM_RIGHT][Y] = this.corners[BUTTOM_LEFT][Y]  = barButtomRightCorner[Y];
      }
    } else {
      //this.corners[TOP_LEFT][X]     = this.corners[BUTTOM_LEFT][X]  = ((barButtomRightCorner[X] + barTopLeftCorner[X]) / 2) - (BAR_SHORT_SIZE / 2);
      //this.corners[BUTTOM_RIGHT][X] = this.corners[BUTTOM_LEFT][X]  = ((barButtomRightCorner[X] + barTopLeftCorner[X]) / 2) + (BAR_SHORT_SIZE / 2);
      this.corners[TOP_LEFT][Y]     = this.corners[TOP_RIGHT][Y]    = y - BAR_LONG_SIZE;
      this.corners[BUTTOM_LEFT][Y]  = this.corners[BUTTOM_RIGHT][Y] = y + BAR_LONG_SIZE;
      if (barArea.status == BarStatus.Left) {
        this.corners[TOP_LEFT][X]     = this.corners[BUTTOM_LEFT][X]  = 0;
        this.corners[BUTTOM_RIGHT][X] = this.corners[BUTTOM_LEFT][X]  = BAR_SHORT_SIZE;
      } else {
        this.corners[TOP_LEFT][X]     = this.corners[BUTTOM_LEFT][X]  = barButtomRightCorner[X] - BAR_SHORT_SIZE;
        this.corners[BUTTOM_RIGHT][X] = this.corners[BUTTOM_LEFT][X]  = barButtomRightCorner[X];
      }
    }
  }
  
  public void setBarVelocity(float x, float y) {
      this.vx = x - this.pastX;
      this.vy = x - this.pastY;
      this.pastX = x;
      this.pastY = y;
  }
  
  public void setBarVelocity() {
    this.vx = 1;
    this.vy = 1;
  }
  
  public void setStatus(BarStatus status) {
    this.status = status;
  }
  
  public BarStatus getStatus() {
    return this.status;
  }
  
  public void setVisiable(boolean v) {
    this.visiable = v;
  }
  
  public boolean getVisiable() {
    return this.visiable;
  }
  
  public float[] getTopLeftCorner() {
    float[] topLeftCorner = {this.corners[TOP_LEFT][X], this.corners[TOP_RIGHT][Y]};
    return topLeftCorner;
  }
  
  public float[] getButtomRightCorner() {
    float[] buttomRightCorner = {this.corners[BUTTOM_RIGHT][X], this.corners[BUTTOM_RIGHT][Y]};
    return buttomRightCorner;
  }
}
