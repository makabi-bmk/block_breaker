/* STATIC AREA START */
final float BAR_SHORT_SIZE = 20;
float BAR_LONG_SIZE;  // BAR_AREA_SIZE * 2

// manage arrangement
Bar bar;

void initBar() {
  BAR_LONG_SIZE = BAR_AREA_SIZE * 2;
  bar = new Bar();
}

void drawBar() {
  for (int i = 0; i < 4; i++) {
    if (barAreas[i].inRange(mouseX, mouseY)) {
      bar.setBarCorner(barAreas[i], mouseX, mouseY);

      float[] topLeftCorner = bar.getTopLeftCorner();
      float[] buttomRightCorner = bar.getButtomRightCorner();
      
      //fill(colors[R], colors[G], colors[B]);
      fill(0, 0, 0);
      rect(topLeftCorner[X], topLeftCorner[Y], buttomRightCorner[X] - topLeftCorner[X], buttomRightCorner[Y] - topLeftCorner[Y]);
      bar.setVisiable(true);
      return;
    }
  }
  bar.setVisiable(false);
}

///* STATIC AREA END */

///* CLASS AREA START */
public class Bar {
  private float[][] corners = new float[4][2];
  private boolean visiable;
  
  public void setBarCorner(BarArea barArea, float x, float y) {
    
    //println(barArea);
    this.visiable = false;
    float[] barTopLeftCorner = barArea.getTopLeftCorner();
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
///* CLASS AREA END */
