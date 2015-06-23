public class GLine extends GObject {
  PVector first;
  PVector second;
  int strokeCap;

  GLine(float initX1, float initY1, float initX2, float initY2) {
    super(GUtils.average(initX1, initX2), GUtils.average(initY1, initY2), GUtils.difference(initX1, initX2), GUtils.difference(initY1, initY2));

    first = new PVector(initX1, initY1);
    second = new PVector(initX2, initY2);
    strokeCap = ROUND;
    setStrokeSize(1);
  }

  void display() {
    super.display();
    
    strokeCap(strokeCap);

    float avgX = GUtils.average(first.x, second.x);
    float avgY = GUtils.average(first.y, second.y);

    line(first.x-avgX, first.y-avgY, second.x-avgX, second.y-avgY); 

    resetMatrix();
  }

  void setPoints(float x1, float y1, float x2, float y2) {
    first.x = x1;
    first.y = y1;
    second.x = x2;
    second.y = y2;
    
    setX(GUtils.average(x1, x2));
    setY(GUtils.average(y1, y2));
    setWidth(GUtils.difference(x1, x2));
    setHeight(GUtils.difference(y1, y2));
  }
  
  PVector getFirstPoint() {
    return first; 
  }
  
  PVector getSecondPoint() {
    return second;
  }
  
  int getStrokeCap() {
    return strokeCap; 
  }
  
  void setStrokeCap(int newStrokeCap) {
    strokeCap = newStrokeCap;
  }
}

