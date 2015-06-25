public class GameLight extends LEDLightStrip {
  
  int team = 0;
  int timeTillNext = 0;
  boolean charging = false;
  int charge = 0;
  int speed = 1;
  int mode = 0;
  
  color lightColor;
  color teamColor;
  
  GameLight(int initX, int initY, int initWidth, int initHeight, GraphicsProgram initScreen) {
    super(initX, initY, initWidth, initHeight, initScreen);
  }
    
  private void updateTimeTillNext() {
     timeTillNext = 5 / speed;
  }
    
  public void update() {
    timeTillNext--;
    
    if (timeTillNext <= 0 && charging) {  
      charge++;
      
      if (charge > 30) {
        charge = 0; 
        colorFullLight(color(0));
      } else {
        setLightColor(30 - charge, lightColor);      
      }
      
      updateTimeTillNext();
    }
  }
  
  public void startCharging() {
     charge = 0;
     charging = true;
     updateTimeTillNext();
  }
  
  public void setTeam(int newTeam) {
    team = newTeam;
    
    if (team == 1) {
      teamColor = color(255, 0, 0);
      lightColor = teamColor;
    } else if (team == 2) {
      teamColor = color(0, 0, 255); 
      lightColor = teamColor;
    } 
  }
  
  public void colorFullLight(color newColor) {
    for (GRect light : lights) {
      light.setFillColor(newColor);
    }
  }
  
  public void setMode(int initMode) {
    mode = initMode;
    switch (mode) {
      case 0: 
        lightColor = teamColor;
        break; 
      case 1:
        // change lightColor
        break;
    }
  }
  
}

