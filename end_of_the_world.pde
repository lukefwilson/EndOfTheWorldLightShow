import ddf.minim.analysis.*;
import ddf.minim.*;

OPC opc;
PImage rainbowGradient;
Minim minim;
FFT fft;
float[] fftFilter;


boolean off;

float decay = 0.97;

// Luke
AudioInput in;
GraphicsProgram screen;
GRect bg;
GSprite rainbow1;
GSprite rainbow2;

GRect centerRect1;
GRect centerRect2;
float centerRectSize = 40;



color bgHue = 0;
color hueMax = 1000;

color rainbowAlpha = 255;

float numModes = 2;
float mode1Alpha = 0;
int mode1AlphaVel = 1;
float mode2Alpha = 1;
int mode2AlphaVel = -1;

void setup()
{
  size(450, 338);
  screen = new GraphicsProgram();
  
  bg = new GRect(width/2, height/2, width, height);
  screen.addObject(bg);
  
  rainbow1 = new GSprite("rainbow.png", width/2, height/2, width, height);
  rainbow1.setXVel(-0.5);
  rainbow2 = new GSprite("rainbow.png", width/2+width, height/2, width, height);
  rainbow2.setXVel(-0.5);
  screen.addObject(rainbow1);
  screen.addObject(rainbow2);
  
  centerRect1 = new GRect(width/4, height/2, centerRectSize, centerRectSize);
  centerRect1.setFillColor(color(0));
  centerRect2 = new GRect(3*width/4, height/2, centerRectSize, centerRectSize);
  centerRect2.setFillColor(color(0));
  screen.addObject(centerRect1);
  
  off = false;
  
  rainbowGradient = loadImage("rainbow.png");
  
  minim = new Minim(this);
  
  in = minim.getLineIn(Minim.STEREO, 512);
 
 // Small buffer size!
  fft = new FFT(in.bufferSize(), in.sampleRate());
  fftFilter = new float[fft.specSize()]; 
  


  // Connect to the local instance of fcserver
  opc = new OPC(this, "127.0.0.1", 7890);

  opc.ledStrip( 0 * 30, 30, width *  1/17, height/2, height / 32, -PI/2, false);
  opc.ledStrip( 1 * 30, 30, width *  2/17, height/2, height / 32, -PI/2, false);
  opc.ledStrip( 2 * 30, 30, width *  3/17, height/2, height / 32, -PI/2, false);
  opc.ledStrip( 3 * 30, 30, width *  4/17, height/2, height / 32, -PI/2, false);
  opc.ledStrip( 4 * 30, 30, width *  5/17, height/2, height / 32, -PI/2, false);
  opc.ledStrip( 5 * 30, 30, width *  6/17, height/2, height / 32, -PI/2, false);
  opc.ledStrip( 6 * 30, 30, width *  7/17, height/2, height / 32, -PI/2, false);
  opc.ledStrip( 7 * 30, 30, width *  8/17, height/2, height / 32, -PI/2, false);
  opc.ledStrip( 8 * 30, 30, width *  9/17, height/2, height / 32, -PI/2, false);
  opc.ledStrip( 9 * 30, 30, width * 10/17, height/2, height / 32, -PI/2, false);
  opc.ledStrip(10 * 30, 30, width * 11/17, height/2, height / 32, -PI/2, false);
  opc.ledStrip(11 * 30, 30, width * 12/17, height/2, height / 32, -PI/2, false);
  opc.ledStrip(12 * 30, 30, width * 13/17, height/2, height / 32, -PI/2, false);
  opc.ledStrip(13 * 30, 30, width * 14/17, height/2, height / 32, -PI/2, false);
  opc.ledStrip(14 * 30, 30, width * 15/17, height/2, height / 32, -PI/2, false);
  opc.ledStrip(15 * 30, 30, width * 16/17, height/2, height / 32, -PI/2, false);
}

void nextBGHue() {
   bgHue++;
   if (bgHue > hueMax) {
      bgHue = 0; 
   }
}

//void nextRectHue() {
//   rectHue++;
//   if (rectHue > hueMax) {
//      bgHue = 0; 
//   }
//}

float nextMode1Alpha() {
  mode1Alpha += 0.005 * mode1AlphaVel;
  if (mode1Alpha > 2) {
    mode1AlphaVel = -1; 
  } else if (mode1Alpha < -1) {
    mode1AlphaVel = 1; 
  }
  return mode1Alpha;
}  

float nextMode2Alpha() {
  mode2Alpha += 0.005 * mode2AlphaVel;
  if (mode2Alpha > 2) {
    mode2AlphaVel = -1; 
  } else if (mode2Alpha < -1) {
    mode2AlphaVel = 1; 
  }
  return mode2Alpha;
}



void draw()
{
    println(nextMode1Alpha(), nextMode2Alpha());
    nextBGHue();
    colorMode(HSB, hueMax);
    
    bg.setFillColor(color(bgHue, hueMax, hueMax, nextMode1Alpha() * hueMax));
    
    colorMode(RGB, 255);
    color rainbowTint = color(255, nextMode2Alpha() * 255);
    rainbow1.move();
    rainbow1.setTintColor(rainbowTint);
    rainbow2.move();
    rainbow1.setTintColor(rainbowTint);
    
    if (rainbow1.getRight() < 0) {
      rainbow1.setX(width/2+width); 
    }
    if (rainbow2.getRight() < 0) {
      rainbow2.setX(width/2+width); 
    }    
  // Scale the image so that it matches the width of the window
//  int imHeight = rainbowGradient.height * width / rainbowGradient.width;
//  int imWidth = rainbowGradient.width * height / rainbowGradient.height;

//  int imHeight = rainbowGradient.height;
//  int imWidth = rainbowGradient.width;

  // Scroll down slowly, and wrap around
//  float y = 10;
//  float x = (millis() * -0.075) % imWidth;
  
  // Use two copies of the image, so it seems to repeat infinitely  

  
  screen.display();

//  image(rainbowGradient, x, y, width, imHeight);
////  image(rainbowGradient, x + imWidth, y + imHeight, width, imHeight);
////  image(rainbowGradient, x, y + imHeight, width, imHeight);
//  image(rainbowGradient, x + imWidth, y, width, imHeight);

//  
  
  fft.forward(in.mix);  
  for (int i = 0; i < fftFilter.length; i++) {
    fftFilter[i] = max(fftFilter[i] * decay, log(1 + fft.getBand(i)));
  }
  

  for (int i = 4; i < fftFilter.length; i+= 2) {
    if (i > 34) break;

    fill(240, 240, 240);
    stroke(240, 240, 240);
    float value = pow((fftFilter[i] + fftFilter[i+1])/2, 0.75) * pow(60/(60-i), 0.4);

    rectMode(CORNER);
    rect(((i-4)/2 + 0.5) * width / 17 + 10, -30, width / 17, (height - value * height/2.5));
  }
  
  centerRect1.setRotation(centerRect1.getRotation()+0.01);
  float size = centerRectSize*fftFilter[10];
  centerRect1.setWidth(size);
  centerRect1.setHeight(size);

  centerRect2.setRotation(centerRect2.getRotation()+0.01);
  centerRect2.setWidth(size);
  centerRect2.setHeight(size);

  centerRect1.display();
  centerRect2.display();


  if (off || keyPressed) {
    fill(0, 0, 0);
    stroke(0, 0, 0);
    rect(0, 0, width, height);
  }
}

