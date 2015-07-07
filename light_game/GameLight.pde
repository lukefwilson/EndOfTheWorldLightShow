public class GameLight extends LEDLightStrip {
  
  float timeTillNext = 0;
  boolean charging = false;
  int charge = 0;
  float speed = 1;
  
  int regularMode = 0;
  int successHitMode = 1;
  int missHitMode = 2;

  int mode = regularMode;
  
  float feedbackTime = 1 * 30;
  float feedbackTimer = feedbackTime;
  
  color lightColor;
  GameTeam team;
  
  GameLight(int initX, int initY, int initWidth, int initHeight, GraphicsProgram initScreen) {
    super(initX, initY, initWidth, initHeight, initScreen);
  }
    
  private void setTimeTillNext() {
     timeTillNext = 8 / speed;
  }
    
  public void update() {
    if (mode == regularMode) {
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
    } else if (mode == successHitMode) {
      feedbackTimer--;
      
      if (round(feedbackTimer/20) % 2 == 0) {
        colorFullLight(color(0, 255, 0)); 
      } else {
        clearLight(); 
      }
      
      if (feedbackTimer <= 0) {
        readyToCharge(); 
        mode = regularMode;
      }
    }
  }
  
  public void startCharging() {
     charge = 0;
     clearLight();
     charging = true;
     setTimeTillNext();
  }
  
  public boolean hit() {
//    colorFullLight(color(255));
//    return false;
    if (charge > 0) {
      mode = successHitMode;
      feedbackTimer = feedbackTime;
      return true;
    } else {
      readyToCharge();
      return false;
    }
  }
  
  public void readyToCharge() {
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

