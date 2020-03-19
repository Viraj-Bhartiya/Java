/*
   Viraj Bhartiya
 Code Freak
 Parametric Cos
 
 */

static final int NUM_triangleS = 7;

float t;
float angle = 0.0;
void setup() {
  fullScreen(P3D);
}

void draw() {
  angle += 0.02;
  background(0);
  noFill();
  strokeWeight(4);
  translate(width/2, height/2);


  for (int i = 0; i < NUM_triangleS; i++) {
    stroke(127, 255, 0 );
    triangle(x1(t +i*2+PI), y1(t+i*2+PI), x2(t+i*2+PI), y2(t+i*2)*2.7 +PI, x3(t+i*2)*2.7 +PI, y3(t+i*2)*2.7 +PI);
    stroke(0, 255, 0);
    triangle(-(x1(t +i*2+PI)), (-(y1(t+i*2+PI))), (-(x2(t+i*2+PI))), (-(y2(t+i*2)*2.7+PI)), (-(x3(t+i*2)*2.7+PI)), (-(y3(t+i*2)*2.7+PI)) );
    stroke(223, 0, 0);
    triangle(-(x1(t +i*2+PI)), y1(t+i*2+PI), (-(x2(t+i*2+PI))), y2(t+i*2)*2.7+PI,(-(x3(t+i*2+PI))), y3(t+i*2)*2.7+PI );
    stroke(137, 20, 240);
    triangle(x1(t +i*2+PI), (-(y1(t+i*2+PI))), x2(t+i*2+PI), (-(y2(t+i*2)*2.7+PI)) , x3(t+i*2+PI), (-(y3(t+i*2)*2.7+PI)) );
  } 
  t+=0.005;
}


float x1(float t) {
  return sin(t)*200 * cos(t)*20;
}
float y1(float t) {
  return cos(t)*200;
}
float x2(float t) {
  return cos(t)*400 * sin(t)*2;
}
float y2(float t) {
  return sin(t)*400 * cos(t) * 20;
}
float x3(float t) {
  return cos(t)*400 * cos(t)*2;
}
float y3(float t) {
  return sin(t)*400 * sin(t) * 20;
}
