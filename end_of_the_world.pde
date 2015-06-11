import ddf.minim.analysis.*;
import ddf.minim.*;

OPC opc;
PImage im;
Minim minim;
FFT fft;
float[] fftFilter;


boolean off;

float decay = 0.97;

// Luke
AudioInput in;
GraphicsProgram screen;


void setup()
{
  size(450, 338);
  screen = new GraphicsProgram();
  
  GRect rect = new GRect(0, 0, width*2, height*2);
  screen.addObject(rect);
  
  off = false;
  
//  im = loadImage("flames.png");
  
  minim = new Minim(this);
  
  in = minim.getLineIn(Minim.STEREO, 512);
 
 // Small buffer size!
  fft = new FFT(in.bufferSize(), in.sampleRate());
  fftFilter = new float[fft.specSize()]; 
  

  // Load a sample image
//  im = loadImage("flames.png");

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

void draw()
{
  
  // Scale the image so that it matches the width of the window
//  int imHeight = im.height * width / im.width;
//  int imWidth = im.width * height / im.height;

  // Scroll down slowly, and wrap around
//  float y = (millis() * -0.1) % imHeight;
//  float x = (millis() * -0.075) % imWidth;
  
  // Use two copies of the image, so it seems to repeat infinitely  
//  image(im, x, y, width, imHeight);
//  image(im, x + imWidth, y + imHeight, width, imHeight);
//  image(im, x, y + imHeight, width, imHeight);
//  image(im, x + imWidth, y, width, imHeight);
  
  screen.display();
  
  fft.forward(in.mix);  
  for (int i = 0; i < fftFilter.length; i++) {
    fftFilter[i] = max(fftFilter[i] * decay, log(1 + fft.getBand(i)));
  }
  

  for (int i = 4; i < fftFilter.length; i+= 2) {
    if (i > 34) break;

    fill(240, 240, 240);
    stroke(240, 240, 240);
    float value = pow((fftFilter[i] + fftFilter[i+1])/2, 0.75) * pow(60/(60-i), 0.4);

    rect(((i-4)/2 + 0.5) * width / 17 + 10, 0, width / 17, (height - value * height/2.5));
  }
  

  if (off) {
    fill(0, 0, 0);
    stroke(0, 0, 0);
    rect(0, 0, width, height);
  }
}

