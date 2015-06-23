public class GRect extends GObject {
  GRect(float initX, float initY, float initWidth, float initHeight) {
    super(initX, initY, initWidth, initHeight);
  }

  void display() {
    super.display();
    rectMode(CENTER);
    
    rect(0, 0, widthVal, heightVal); 
    
    resetMatrix();
  } 
}
