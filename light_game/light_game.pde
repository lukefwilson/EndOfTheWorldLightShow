OPC opc;

GraphicsProgram screen = new GraphicsProgram();
ArrayList<GameLight> lights = new ArrayList();

GameTeam team1 = new GameTeam(1, color(255, 0, 0));
GameTeam team2 = new GameTeam(2, color(0, 0, 255));

void setup()
{
  int lightSize = 20;
  int numStrips = 16;
  int lightsPerStrip = 30;
  
  int totalLEDWidth =  numStrips * lightSize;
  int totalLEDHeight = lightsPerStrip * lightSize;
  size(totalLEDWidth + 200, totalLEDHeight);  
  
  for (int i = 0; i < numStrips; i++) {
    GameLight light = new GameLight((lightSize/2) + (i * lightSize), lightSize/2, lightSize, lightSize, screen);
    lights.add(light);
  }
  
  team1.addLight(lights.get(0));
  team1.addLight(lights.get(1));
  team1.addLight(lights.get(2));
  team1.addLight(lights.get(3));
  
  team2.addLight(lights.get(4));
  team2.addLight(lights.get(5));
  team2.addLight(lights.get(6));
  team2.addLight(lights.get(7));
  team2.addLight(lights.get(8));
  team2.addLight(lights.get(9));
  team2.addLight(lights.get(10));
  team2.addLight(lights.get(11));
  
  team1.addLight(lights.get(12));
  team1.addLight(lights.get(13));
  team1.addLight(lights.get(14));
  team1.addLight(lights.get(15));
      
  // LED strip Setup
  opc = new OPC(this, "127.0.0.1", 7890);

  int LEDHeight = 30;
  int LEDWidth = 16;
  
  // int index, int count, float x, float y, float spacing, float angle, boolean reversed

  float ledStripY = totalLEDHeight/2;
  float ledStripYSpacing = totalLEDHeight/lightsPerStrip;
  
  for (int i = 0; i < 16; i++) {
    opc.ledStrip( i * 30, 30, lightSize * i + (LEDWidth/2), ledStripY, ledStripYSpacing, -PI/2, false);
  }

}

void drawGameStats() {
  fill(team1.teamColor);
  text("Team 1", 100, 100); 
}

void draw() {
  background(0);
  
  
  for (GameLight light : lights) {
    light.update(); 
  }
  
  team1.update();
  team2.update();
  
  screen.display();
  
  drawGameStats();
}

void keyPressed() {
//  println(keyCode);
  if (keyCode == 32) { // Space bar
    hitLight(lights.get(0));
  } else if (keyCode == 81) { // Q
    hitLight(lights.get(1));
  } else if (keyCode == 87) { // W
    hitLight(lights.get(2)); 
  } else if (keyCode == 69) { // E
    hitLight(lights.get(3));
  } else if (keyCode == 82) { // R
    hitLight(lights.get(4));
  } else if (keyCode == 65) { // A 
    hitLight(lights.get(5));
  } else if (keyCode == 83) { // S
    hitLight(lights.get(6));
  } else if (keyCode == 68) { // D
    hitLight(lights.get(7));
  } else if (keyCode == UP) { 
    hitLight(lights.get(8));
  } else if (keyCode == RIGHT) { 
    hitLight(lights.get(9));
  } else if (keyCode == DOWN) { 
    hitLight(lights.get(10));
  } else if (keyCode == LEFT) { 
    hitLight(lights.get(11));
  } else if (keyCode == 81) { 
    hitLight(lights.get(12));
  } else if (keyCode == 81) { 
    hitLight(lights.get(13));
  } else if (keyCode == 81) { 
    hitLight(lights.get(14));
  } else if (keyCode == 81) { 
    hitLight(lights.get(15));
  }
}

void hitLight(GameLight light) {
  if (light.team.id == team1.id) {
    team1.hitLight(light); 
  } else {
    team2.hitLight(light); 
  }
}
