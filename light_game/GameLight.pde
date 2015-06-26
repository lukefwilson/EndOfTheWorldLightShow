public class GameLight extends LEDLightStrip {
  
  float timeTillNext = 0;
  boolean charging = false;
  int charge = 0;
  float speed = 1;
  int mode = 0;
  
  color lightColor;
  GameTeam team;
  
  GameLight(int initX, int initY, int initWidth, int initHeight, GraphicsProgram initScreen) {
    super(initX, initY, initWidth, initHeight, initScreen);
  }
    
  private void setTimeTillNext() {
     timeTillNext = 5 / speed;
  }
    
  public void update() {
    timeTillNext--;
    
    if (timeTillNext <= 0 && charging) {  
      charge++;
      
      if (charge > 30) {
        charge = 0; 
        clearLight();
        charging = false;
      } else {
        setLightColor(30 - charge, lightColor);      
      }
      
      setTimeTillNext();
    }
  }
  
  public void startCharging() {
     charge = 0;
     clearLight();
     charging = true;
     setTimeTillNext();
  }
  
  public void hit() {
    charge = 0;
    charging = false;
    clearLight();
  }
  
  public void resetCharge() {
    charge = 0;
    charging = false;
    clearLight();
  }
  
  public void clearLight() {
    
    colorFullLight(color(0)); 
  }
  
  public void colorFullLight(color newColor) {
    for (GRect light : lights) {
      light.setFillColor(newColor);
    }
  }
  
  public void setTeam(GameTeam newTeam) {
    team = newTeam;
  }
  
  public void setMode(int initMode) {
    mode = initMode;
    switch (mode) {
      case 0: 
        lightColor = team.teamColor;
        break; 
      case 1:
        // change lightColor
        break;
    }
  }
  
}

