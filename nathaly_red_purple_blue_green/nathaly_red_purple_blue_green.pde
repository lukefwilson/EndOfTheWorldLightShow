
OPC opc;

float r = 255;
float g = 0;
float b = 0;

float rVel = 0;
float gVel = 0;
float bVel = 1;


void setup()
{
  size(450, 338);  
  
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

void draw() {
  background(0, 0, 0);
  
  fill(r, g, b);
  rect(1, 1, 500, 500);
 
  r = r + rVel;
  g = g + gVel;
  b = b + bVel;
  
  if (b > 255) {
    bVel = -1;
    gVel = 1; 
    rVel = -1;
  }

  if (g > 255) {
    rVel = -1;
    gVel = -1;
    bVel = 1;
  }
}
