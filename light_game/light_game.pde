OPC opc;

GraphicsProgram screen = new GraphicsProgram();
ArrayList<GameLight> lights = new ArrayList();

GameTeam team1 = new GameTeam(1);
GameTeam team2 = new GameTeam(2);

void setup()
{
  int lightSize = 20;
  int numStrips = 16;
  int lightsPerStrip = 30;
  size(numStrips * lightSize, lightsPerStrip * lightSize);  
  
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
  
//  lights.get(2).startCharging();
    
  // LED strip Setup
  opc = new OPC(this, "127.0.0.1", 7890);

  int LEDHeight = 30;
  int LEDWidth = 16;

  opc.ledStrip( 0 * 30, 30, width *  1/LEDWidth + (LEDWidth/2), height/2, height / LEDHeight, -PI/2, false);
  opc.ledStrip( 1 * 30, 30, width *  2/LEDWidth + (LEDWidth/2), height/2, height / LEDHeight, -PI/2, false);
  opc.ledStrip( 2 * 30, 30, width *  3/LEDWidth + (LEDWidth/2), height/2, height / LEDHeight, -PI/2, false);
  opc.ledStrip( 3 * 30, 30, width *  4/LEDWidth + (LEDWidth/2), height/2, height / LEDHeight, -PI/2, false);
  opc.ledStrip( 4 * 30, 30, width *  5/LEDWidth + (LEDWidth/2), height/2, height / LEDHeight, -PI/2, false);
  opc.ledStrip( 5 * 30, 30, width *  6/LEDWidth + (LEDWidth/2), height/2, height / LEDHeight, -PI/2, false);
  opc.ledStrip( 6 * 30, 30, width *  7/LEDWidth + (LEDWidth/2), height/2, height / LEDHeight, -PI/2, false);
  opc.ledStrip( 7 * 30, 30, width *  8/LEDWidth + (LEDWidth/2), height/2, height / LEDHeight, -PI/2, false);
  opc.ledStrip( 8 * 30, 30, width *  9/LEDWidth + (LEDWidth/2), height/2, height / LEDHeight, -PI/2, false);
  opc.ledStrip( 9 * 30, 30, width * 10/LEDWidth + (LEDWidth/2), height/2, height / LEDHeight, -PI/2, false);
  opc.ledStrip(10 * 30, 30, width * 11/LEDWidth + (LEDWidth/2), height/2, height / LEDHeight, -PI/2, false);
  opc.ledStrip(11 * 30, 30, width * 12/LEDWidth + (LEDWidth/2), height/2, height / LEDHeight, -PI/2, false);
  opc.ledStrip(12 * 30, 30, width * 13/LEDWidth + (LEDWidth/2), height/2, height / LEDHeight, -PI/2, false);
  opc.ledStrip(13 * 30, 30, width * 14/LEDWidth + (LEDWidth/2), height/2, height / LEDHeight, -PI/2, false);
  opc.ledStrip(14 * 30, 30, width * 15/LEDWidth + (LEDWidth/2), height/2, height / LEDHeight, -PI/2, false);
  opc.ledStrip(15 * 30, 30, width * 16/LEDWidth + (LEDWidth/2), height/2, height / LEDHeight, -PI/2, false);
}


void draw() {
  background(0);
  
  for (GameLight light : lights) {
    light.update(); 
  }
  
  team1.update();
  team2.update();
  
  screen.display();
}

void keyPressed() {
  if (keyCode == 32) {
    hitLight(lights.get(0));
  }
}

void hitLight(GameLight light) {
  if (light.team == team1.id) {
    team1.hitLight(light); 
  } else {
    team2.hitLight(light); 
  }
}
