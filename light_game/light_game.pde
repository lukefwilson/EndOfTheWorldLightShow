OPC opc;

GraphicsProgram screen = new GraphicsProgram();

ArrayList<GameLight> lights = new ArrayList();

GameTeam team1 = new GameTeam(1, color(255, 0, 0));
GameTeam team2 = new GameTeam(2, color(0, 0, 255));
               
GameTeam winningTeam;

int round = 0       ;                                                                                      
float roundTime = 60 * 60;
float roundTimer = roundTime;

float roundWaitTime = 10 * 60;
float roundWaitTimer = roundWaitTime;

float startRoundTime = 4 * 60;
float startRoundTimer = startRoundTime;

boolean paused = false;
boolean overtime = false;
static final int menuMode = 0;
static final int playMode = 1;
static final int roundWinnerMode = 2;
static final int startingRoundMode = 3;
static int gameMode = menuMode;

void setup()
{ 
  int lightSize = 20;
  int numStrips = 16;
  int lightsPerStrip = 30;
  
  int totalLEDWidth =  numStrips * lightSize;
  int totalLEDHeight = lightsPerStrip * lightSize;
  size(totalLEDWidth + 400, totalLEDHeight);  
  
  for (int i = 0; i < numStrips; i++) {
    GameLight light = new GameLight((lightSize/2) + (i * lightSize), lightSize/2, lightSize, lightSize, screen);
    lights.add(light);
  }
  
 // Order matters!
  team1.addLight(lights.get(14));
  team1.addLight(lights.get(13));
  team1.addLight(lights.get(15));
  team1.addLight(lights.get(12));
  team1.addLight(lights.get(0));
  team1.addLight(lights.get(11));
  team1.addLight(lights.get(1));
  team1.addLight(lights.get(10));

  
  team2.addLight(lights.get(5));
  team2.addLight(lights.get(6));
  team2.addLight(lights.get(4));
  team2.addLight(lights.get(7));
  team2.addLight(lights.get(3));
  team2.addLight(lights.get(8));
  team2.addLight(lights.get(2));
  team2.addLight(lights.get(9));
      
  // LED strip Setup
  opc = new OPC(this, "127.0.0.1", 7890);

  int LEDHeight = 30;
  int LEDWidth = 16;
  
  float ledStripY = totalLEDHeight/2;
  float ledStripYSpacing = totalLEDHeight/lightsPerStrip;
  
  for (int i = 0; i < 16; i++) {
    opc.ledStrip( i * 30, 30, lightSize * i + (LEDWidth/2), ledStripY, ledStripYSpacing, -PI/2, false);
  }

}

void drawMenu() {
  int centerX = 510;
  
  textAlign(CENTER);
  textSize(20);
  
  fill(255);
  text("Game Name!", centerX, 100); 
  
  textSize(16);
  text("Press spacebar to start", centerX, 160); 


}

void drawGameStats() {
  int centerX = 510;
  
  textAlign(CENTER);
  
  if (overtime) {
    textSize(29);
    fill(100, 200, 0);
    text("Overtime!", centerX, 140);
  }
  
  textSize(20);
  fill(255);
  text("Round " + round + "   -   " + round(roundTimer/60), centerX, 100); 
  
  fill(team1.teamColor);
  text("Team 1", centerX, 300); 
  text("Score: " + team1.score, centerX, 340); 
  
  fill(team2.teamColor);
  text("Team 2", centerX, 400); 
  text("Score: " + team2.score, centerX, 440); 
}


void draw() {
  background(0);
  
  if (paused) {    
    for (int i = 0; i < 16; i++) {
      GameLight light = lights.get(i);
      light.colorFullLight(light.team.teamColor);
    }
    
    screen.display();  
    
    int centerX = 510;
    fill(255);
    text("Paused", centerX, 100); 
  } else if (gameMode == menuMode) {
    drawMenu();
  } else if (gameMode == playMode) {
    roundTimer--;
    
    if (roundTimer < 0) {
      roundTimer = -1;
      if (team1.numChargingLights() == 0 && team2.numChargingLights() == 0) {
        // wait until all lights stop spawning then
        declareWinners();
      }
    } else {
      team1.update();
      team2.update();
    }
    
    for (GameLight light : lights) {
      light.update(); 
    }
    
    screen.display();
    
    
    drawGameStats();
  } else if (gameMode == roundWinnerMode) {
    int centerX = 510;
    if (team1.lights.size() == 0 || team2.lights.size() == 0) {
      fill(winningTeam.teamColor);
      rectMode(CORNER);
      rect(0, 0, 20 * 16, height);
      
      text("Team " + winningTeam.id + " won the game in " + round + " rounds", centerX, 100); 

      return;
    }
    
    roundWaitTimer--;
    
    if (round(roundWaitTimer/60)% 2 == 0) {
      fill(winningTeam.teamColor);
    } else {
      fill(0);
    }
       
    rectMode(CORNER);
    rect(0, 0, 20 * 16, height);
    
           
    textSize(20);
    fill(255);
    text("Team " + winningTeam.id + " won Round " + round, centerX, 100); 
    
    if (roundWaitTimer < 7 * 60) {
      fill(50, 150, 255);
      text("Relax a bit...", centerX, 140);
    } 
    
    
    if (roundWaitTimer <= 0) {
       countDownNextRound(); 
    }
  } else if (gameMode == startingRoundMode) {
    startRoundTimer--;
      
    int centerX = 510;
    textSize(20);
    fill(255);
    text("Starting Round " + (round+1) + " in... " + round(startRoundTimer/60), centerX, 100); 

    screen.display();
    
    int lightIndex = floor(startRoundTimer/15);
    GameLight light = lights.get(lightIndex);
    light.colorFullLight(light.team.teamColor);

    if (startRoundTimer <= 0) {
      startNextRound();
    }
  }
}

void declareWinners() {
  gameMode = roundWinnerMode;
  roundWaitTimer = roundWaitTime;
  
  if (team1.score > team2.score) {
    winningTeam = team1; 
    team1.wins++;
    GameLight light1 = team2.removeNextLight();
    GameLight light2 = team2.removeNextLight();
    team1.addLight(light1);
    team1.addLight(light2);
  } else if (team2.score > team1.score) {
    winningTeam = team2;
    team2.wins++;
    GameLight light1 = team1.removeNextLight();
    GameLight light2 = team1.removeNextLight();
    team2.addLight(light1);
    team2.addLight(light2);
  } else { // draw
    gameMode = playMode;
    roundTimer = 10 * 60;
    overtime = true;
  }
}

void countDownNextRound() {
  gameMode = startingRoundMode;
  
  startRoundTimer = startRoundTime;
}

void startNextRound() {
  team1.nextRound();
  team2.nextRound();
  round++; 
  roundTimer = roundTime;
  overtime = false;
  
  gameMode = playMode;
}

void keyPressed() {
  println(keyCode);
  if (keyCode == 32 && gameMode == menuMode) { // Space bar
    countDownNextRound();
  }
  
  if (gameMode == playMode) {
    if (keyCode == 80) { // P for pause
      paused = !paused;
    } else if (keyCode == LEFT) {
      hitLight(lights.get(9));
    } else if (keyCode == UP) {
      hitLight(lights.get(8));
    } else if (keyCode == RIGHT) {
      hitLight(lights.get(7));
    } else if (keyCode == DOWN) {
      hitLight(lights.get(6));
    } else if (keyCode == 32) { // SPACE 
      hitLight(lights.get(5));
    } else if (keyCode == 87) { // W 
      // light 4 handled in mouse click
      hitLight(lights.get(3));
    } else if (keyCode == 65) { // A 
      hitLight(lights.get(2));
    } else if (keyCode == 83) { // S
      hitLight(lights.get(1));
    } else if (keyCode == 70) { // F
      hitLight(lights.get(0));
    } else if (keyCode == 68) { // D
      hitLight(lights.get(15));
    } else if (keyCode == 71) { // G
      hitLight(lights.get(14));
    }
  }
}

void mousePressed() {
  if (mouseButton == LEFT) {
    hitLight(lights.get(4));
  } else if (mouseButton == RIGHT) {
    hitLight(lights.get(13));
  }
}

void mouseMoved() {
  int xDiff = mouseX - pmouseX; 
  int yDiff = mouseY - pmouseY;
  
  if (yDiff > 0) { // move down
    hitLight(lights.get(11));
  } else if (yDiff < 0) { // move up
    hitLight(lights.get(12));
  } else if (xDiff > 0) { // move right
    hitLight(lights.get(10));
  }
  
}

void hitLight(GameLight light) {
  if (light.team.id == team1.id) {
    team1.hitLight(light); 
  } else {
    team2.hitLight(light); 
  }
}
