public class LEDLightStrip {
  
  int topX;
  int topY;
  int lightWidth;
  int lightHeight;
  GraphicsProgram screen;
  
  ArrayList<GRect> lights = new ArrayList<GRect>();

  LEDLightStrip(int initX, int initY, int initWidth, int initHeight, GraphicsProgram initScreen) {
    topX = initX;
    topY = initY;
    lightWidth = initWidth;
    lightHeight = initHeight;
    screen = initScreen;
    
    for (int i = 0; i < 30; i++) {
      GRect light = new GRect(topX, topY + i * lightHeight, lightWidth, lightHeight);
      light.setFillColor(color(0));
      lights.add(light);  
      screen.addObject(light);
    }
  }
  
  public void setLightColor(int lightIndex, color lightColor) {
    GRect light = lights.get(lightIndex);
    light.setFillColor(lightColor); 
  }
  
}
