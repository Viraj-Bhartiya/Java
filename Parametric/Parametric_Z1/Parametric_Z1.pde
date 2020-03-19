/*
   Viraj Bhartiya
   Code Freak
   Parametric Z1
   
*/

static final int NUM_LINES = 10;

float t;

void setup() {
  fullScreen();
}

void draw() {
  background(20);
  strokeWeight(3);
  translate(width/2, height/2);

  for (int i = 0; i < NUM_LINES; i++) {
    stroke(191, 255, 0 );
    stroke(137, 207, 240 );
    stroke(227, 38, 54 );
    line(-(x1(t +i*2)), y1(t+i*2), (-(x2(t+i*2))), y2(t+i*2)*2.7 );
    stroke(242, 133, 0);
    line(x1(t +i*2), (-(y1(t+i*2))), x2(t+i*2), (-(y2(t+i*2)*2.7)) );

    scale(-2);
    stroke(191, 255, 0 );
    stroke(137, 207, 240 );
    line(-(x1(t +i*2)), (-(y1(t+i*2))), (-(x2(t+i*2))), (-(y2(t+i*2)*2.7)) );
    stroke(227, 38, 54 );
    stroke(242, 133, 0);
    line(x1(t +i*2), (-(y1(t+i*2))), x2(t+i*2), (-(y2(t+i*2)*2.7)) );

    stroke(191, 255, 0 );
    line(x1(t +i*2), y1(t+i*2), x2(t+i*2), y2(t+i*2)*2.7 );
    stroke(137, 207, 240 );
    line(-(x1(t +i*2)), (-(y1(t+i*2))), (-(x2(t+i*2))), (-(y2(t+i*2)*2.7)) );
    stroke(227, 38, 54 );
    stroke(242, 133, 0);

    stroke(191, 255, 0 );
    stroke(137, 207, 240 );
    line(-(x1(t +i*2)), (-(y1(t+i*2))), (-(x2(t+i*2))), (-(y2(t+i*2)*2.7)) );
    stroke(227, 38, 54 );
    line(-(x1(t +i*2)), y1(t+i*2), (-(x2(t+i*2))), y2(t+i*2)*2.7 );
    stroke(242, 133, 0);
  } 
  t+=0.5;
}


float x1(float t) {
  return sin(t/10)*100 + sin(t/5)*20;
}
float y1(float t) {
  return cos(t /10)*100;
}
float x2(float t) {
  return sin(t/10)*200 + sin(t)*2;
}
float y2(float t) {
  return cos(t /20)*200 + cos(t/12) * 20;
}
