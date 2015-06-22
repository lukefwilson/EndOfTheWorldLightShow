import ddf.minim.analysis.*;
import ddf.minim.*;

OPC opc;
Minim minim;
FFT fft;
float[] fftFilter;

boolean off = false;

float decay = 0.97;

AudioInput in;

GraphicsProgram screen1 = new GraphicsProgram();
GraphicsProgram screen2 = new GraphicsProgram();
GraphicsProgram screen3 = new GraphicsProgram();
GraphicsProgram screen4 = new GraphicsProgram();

int mode = 1;
boolean altMode = false;

int timeTillNext = 0;
float speed = 1;
color bgColor = color(255, 255, 255);

void setup()
{
  size(450, 338);  
  
  // Sound Setup
  minim = new Minim(this);
  
  in = minim.getLineIn(Minim.STEREO, 512);
 
  fft = new FFT(in.bufferSize(), in.sampleRate());
  fftFilter = new float[fft.specSize()]; 
 
  // LED strip Setup
  opc = new OPC(this, "127.0.0.1", 7890);

  int LEDHeight = 32;

  opc.ledStrip( 0 * 30, 30, width *  1/17, height/2, height / LEDHeight, -PI/2, false);
  opc.ledStrip( 1 * 30, 30, width *  2/17, height/2, height / LEDHeight, -PI/2, false);
  opc.ledStrip( 2 * 30, 30, width *  3/17, height/2, height / LEDHeight, -PI/2, false);
  opc.ledStrip( 3 * 30, 30, width *  4/17, height/2, height / LEDHeight, -PI/2, false);
  opc.ledStrip( 4 * 30, 30, width *  5/17, height/2, height / LEDHeight, -PI/2, false);
  opc.ledStrip( 5 * 30, 30, width *  6/17, height/2, height / LEDHeight, -PI/2, false);
  opc.ledStrip( 6 * 30, 30, width *  7/17, height/2, height / LEDHeight, -PI/2, false);
  opc.ledStrip( 7 * 30, 30, width *  8/17, height/2, height / LEDHeight, -PI/2, false);
  opc.ledStrip( 8 * 30, 30, width *  9/17, height/2, height / LEDHeight, -PI/2, false);
  opc.ledStrip( 9 * 30, 30, width * 10/17, height/2, height / LEDHeight, -PI/2, false);
  opc.ledStrip(10 * 30, 30, width * 11/17, height/2, height / LEDHeight, -PI/2, false);
  opc.ledStrip(11 * 30, 30, width * 12/17, height/2, height / LEDHeight, -PI/2, false);
  opc.ledStrip(12 * 30, 30, width * 13/17, height/2, height / LEDHeight, -PI/2, false);
  opc.ledStrip(13 * 30, 30, width * 14/17, height/2, height / LEDHeight, -PI/2, false);
  opc.ledStrip(14 * 30, 30, width * 15/17, height/2, height / LEDHeight, -PI/2, false);
  opc.ledStrip(15 * 30, 30, width * 16/17, height/2, height / LEDHeight, -PI/2, false);
}

void drawDripMode() {
  background(0); 
  timeTillNext--; 
  
  if (timeTillNext <= 0 && speed != 0) {
    int num = round(random(1, 16));
    GRect drip = new GRect( width *  num/17, height, 20, 40);
    drip.setYVel(-5);
    screen1.addObject(drip); 
    if (altMode) {
      colorMode(HSB, 255);
      drip.setFillColor(color(random(0, 255), 255, 255));
    } else {
      colorMode(HSB, 255);
      drip.setFillColor(color(255, 0, 255));
    } 
    timeTillNext = round(random(0, 30/speed));
  }
  
  for (int i = screen1.screenItems.size()-1; i >= 0; i--) {
    GObject obj = screen1.screenItems.get(i);
    if (obj.getY() < -100) {
      screen1.screenItems.remove(i);
    } else {
      obj.move();
    } 
  }
  
  screen1.display(); 
}

void drawSparkleMode() {
  background(0);  
  timeTillNext--;
  
  if (timeTillNext <= 0 && speed != 0) {
    int w = round(random(1, 16));
    int h = round(random(1, 30));
    GRect sparkle = new GRect( width *  w/17, height * h/30, 20, 20);
    screen2.addObject(sparkle);
    
    if (altMode) {
      colorMode(HSB, 255);
      sparkle.setFillColor(color(random(0, 255), 255, 255, 255));
    } else {
      colorMode(HSB, 255);
      sparkle.setFillColor(color(255, 0, 255, 255));
    }
    
    timeTillNext = round(random(0, 8/speed));
  }
  
  for (int i = screen2.screenItems.size()-1; i >= 0; i--) {
    GObject obj = screen2.screenItems.get(i);
    color c = obj.getFillColor();
    float h = hue(c);
    float s = saturation(c);
    float b = brightness(c);
    float a = alpha(c);
    if (a < 0) {
      screen2.screenItems.remove(i);
    } else {
      a -= 5;
      obj.setFillColor(color(h, s, b, a));
    } 
  }
  
  screen2.display(); 
}

void drawEncircleMode() {
  background(0);  
  timeTillNext--;
  
  if (timeTillNext <= 0 && speed != 0) {
    GRect rect = new GRect(10, height-20, 20, 20);
    rect.setXVel(5);
    screen3.addObject(rect);
    
    if (altMode) {
      colorMode(HSB, 255);
      rect.setFillColor(color(random(0, 255), 255, 255, 255));
    } else {
      colorMode(HSB, 255);
      rect.setFillColor(color(255, 0, 255, 255));
    }
    
    timeTillNext = round(random(100/speed, 200/speed));
  }
  
  for (int i = screen3.screenItems.size()-1; i >= 0; i--) {
    GObject obj = screen3.screenItems.get(i);
    if (obj.getX() > width - 20) {
      obj.setX(10);
      obj.setY(obj.getY() - 20);
    }
    if (obj.getY() < 0) {
      screen3.screenItems.remove(i);
    }
    obj.move();
  }
  
  screen3.display(); 
}

void drawEQBarsMode() {
  background(bgColor);
  
  if (altMode) {
    float h = hue(bgColor);
    h += 0.2 * speed;
    if (h > 255) {
      h = 0; 
    }
    bgColor = color(h, 255, 255);
  }

  fft.forward(in.mix);  
  for (int i = 0; i < fftFilter.length; i++) {
    fftFilter[i] = max(fftFilter[i] * decay, log(1 + fft.getBand(i)));
  }
  
  for (int i = 4; i < fftFilter.length; i+= 2) {
    if (i > 34) break;

    float h = hue(bgColor);

    if (altMode) {
      fill((h+150) % 255, 255, 255);
    } else {
      fill(200, 0, 200); 
    }
    noStroke();
    float value = pow((fftFilter[i] + fftFilter[i+1])/2, 0.75) * pow(60/(60-i), 0.4);
    
    value += 0.5;
    
    rectMode(CORNER);
    rect(((i-4)/2 + 0.5) * width / 17, -30, width / 17, (height - value * height/2.5));
  }
}

void draw()
{
  switch (mode) {
    case 1:
      drawDripMode();
      break;
    case 2:
      drawSparkleMode();
      break;
    case 3:
      drawEncircleMode();
      break;
    case 4:
      drawEQBarsMode();
      break;
  }
  
  


  if (off || (keyPressed && keyCode == 16)) { // shift key to strobe
    fill(0, 0, 0);
    stroke(0, 0, 0);
    rect(0, 0, width*10, height*10);
  }
}

void keyPressed() {
//  println(keyCode);
  if (keyCode == 45) { // - key
    altMode = !altMode;
  } else if (keyCode == 16) { // shift key
    // strobe the lights (in draw loop)
  } else if (keyCode == 49) {// 1 key
    mode = 1;
  } else if (keyCode == 50) {// 2 key
    mode = 2;
  } else if (keyCode == 51) {// 3 key
    mode = 3;
  } else if (keyCode == 52) {// 4 key
    mode = 4;
  } else if (keyCode == 38) { // up key
    speed += 0.5;
    println("speed: " + speed);
  } else if (keyCode == 40) { // down key
    speed -= 0.5;
    println("speed: " + speed);
  } else {
    switch (mode) {
      case 1:
        break;
      case 2:
        break;
      case 3:
        break;
      case 4:
        bgColor = color(random(0, 255), 255, 255);
        break;
    }
  }
}

