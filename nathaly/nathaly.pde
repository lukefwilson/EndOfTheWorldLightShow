
OPC opc;

float r = 0;
float g = 0;
float b = 0;

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
  background(r, g, b);
}

void keyPressed() {
  println(keyCode); 
  //r = keycode
  if (keyCode == 82) {
     r = 255;
     g = 0;
     b = 0;
  }
  //o = keycode
  if (keyCode == 79) {
    r = 252;
    g = 140;
    b = 3;
  }
  
  //y = keycode
  if(keyCode == 89) {
    r = 252;
    g = 255;
    b = 77;
  } 

  //g = keycode
  if(keyCode == 71) {
    r = 5;
    g = 250;
    b = 31;
  }

  //b = keycode
  if(keyCode == 66) {
    r = 16;
    g = 130;
    b = 222;
  }    
  //t = keycode
  if(keyCode == 84) {
    r = 13;
    g = 255;
    b = 204;
  }
  //v = keycode
  if(keyCode == 86) {
    r = 108;
    g = 9;
    b = 175;
  }
  //p = keycode
  if(keyCode == 80) {
    r = 250;
    g = 5;
    b = 206;
  }
}

