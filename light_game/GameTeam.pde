public class GameTeam {
  int id;
  int score;
  float speed = 1;
  float timeTillNext = 0;
  
  ArrayList<GameLight> lights = new ArrayList<GameLight>();
  
  GameTeam(int initTeamNumber) {
    id = initTeamNumber;
  }
  
  private void setTimeTillNext() {
     timeTillNext = random(40, 60) / speed;
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
    
    speed += 0.001;
  }
  
  public void addLight(GameLight light) {
    lights.add(light); 
    light.setTeam(id);
  }
  
  public void removeLight(GameLight light) {
    lights.remove(light); 
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

