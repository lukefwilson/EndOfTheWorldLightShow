public class GOval extends GObject {
  GOval(float initX, float initY, float initWidth, float initHeight) {
    super(initX, initY, initWidth, initHeight);
  }

  void display() {
    super.display();
    ellipseMode(CENTER);
    
    ellipse(0, 0, getWidth(), getHeight());     
    
    resetMatrix();
  } 
}
