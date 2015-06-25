public class GameLight extends LEDLightStrip {
  
  int team;
  
  GameLight(int initX, int initY, int initWidth, int initHeight, GraphicsProgram initScreen, int initTeam) {
    super(initX, initY, initWidth, initHeight, initScreen);
    
    team = initTeam;
  }
  
  public void setTeam(int newTeam) {
    team = newTeam;
    if (team == 1) {
      colorFullLight(color(255, 0, 0)); 
    } else if (team == 2) {
      colorFullLight(color(0, 0, 255)); 
    } 
  }
  
  public void colorFullLight(color newColor) {
    for (GRect light : lights) {
      light.setFillColor(newColor);
    }
  }

  
}

