public static final color NO_TINT = -1;

public class GSprite extends GObject {
  PImage image;
  color tintColor;
  
  GSprite(String imageName, float initX, float initY, float initWidth, float initHeight) {
    super(initX, initY, initWidth, initHeight);
    
    image = loadImage(imageName);
    tintColor = NO_TINT;

  }

  void display() {
    super.display();
    imageMode(CENTER);
    
    if (tintColor != NO_TINT) tint(tintColor);
    
    image(image, 0, 0, getWidth(), getHeight()); 
    
    resetMatrix();
  } 
  
  void setImage(String newImageName) {
    image = loadImage(newImageName); 
  }
  
  color getTintColor() {
    return tintColor; 
  }
  
  void setTintColor(color newTintColor) {
    tintColor = newTintColor; 
  }
}
