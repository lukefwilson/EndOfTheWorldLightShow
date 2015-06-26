public class GameTeam {
  int id;
  int score;
  float speed = 1;
  float timeTillNext = 0;
  int round = 0;
  int wins = 0;
  
  color teamColor;
  
  ArrayList<GameLight> lights = new ArrayList<GameLight>();
  
  GameTeam(int initTeamNumber, color initTeamColor) {
    id = initTeamNumber;
    teamColor = initTeamColor;
  }
  
  private void setTimeTillNext() {
     timeTillNext = random(100, 120) / speed;
  }
  
  private int getRandomLightIndex() {
    int random = round(random(0, lights.size()-1));
    int count = 0;
    while(lights.get(random).charging && count < 10) {
      random = round(random(0, lights.size()-1));
      count++;
    }
    if (count >= 10) return -1;
    return random;
  }
  
  public int numChargingLights() {
    int count = 0;
    for (GameLight light : lights) {
      if (light.charging) count++;
    } 
    return count;
  }
    
  
  public void update() {
    timeTillNext--;
    
    if (timeTillNext <= 0) {
      int index = getRandomLightIndex();
      
      if (index != -1) {
        GameLight light = lights.get(index);
        light.startCharging();
      }
      
      setTimeTillNext();
    }
    
    speed += 0.0005;
  }
  
  public void addLight(GameLight light) {
    lights.add(light); 
    light.setTeam(this);
    light.setMode(0);
  }
  
  public void removeLight(GameLight light) {
    lights.remove(light); 
  }
  
  public void reset() {
    score = 0; 
    speed = 1 + round * 0.1;
    for (GameLight light : lights) {
      light.resetCharge();
    }
  }
  
  public void nextRound() {
    round++;
    reset();
  }
  
  public void hitLight(GameLight light) {
    if (light.charge > 27) {
      println("success"); 
      score += 1;
    } else {
      println("woops!"); 
    }
    
    light.hit();
  }
    
}

