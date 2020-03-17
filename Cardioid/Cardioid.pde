/*
   Viraj Bhartiya
   Code Freak
   Cardioid
   
*/

float r;
float factor = 0;

void setup() {
  fullScreen();
  r = height/2 - 100;
  frameRate(99999999);
  colorMode(HSB);
}

PVector getVector(float index, float total) {
  float angle = map(index % total, 0, total, 0, TWO_PI);
  PVector v = PVector.fromAngle(angle + PI);
  v.mult(r);
  return v;
}

void draw() {
  background(12);
  int total = 175;
  factor += 0.03 ; 
  
  
  translate(width/2, height/2);
  stroke(110);
  strokeWeight(3);
  noFill();
  ellipse(0, 0, r*2,r*2);
  strokeWeight(1.5);
  
  for (int i = 0; i <= total; i++) {
    PVector a = getVector(i, total);
    PVector b = getVector(i * factor, total);
    stroke(140);
    line(a.x, a.y, b.x, b.y);
  }
}




/*
float r;
float factor = 0;

void setup() {
  fullScreen();
  r = height/2 - 100;
  frameRate(999999999);
  colorMode(RGB);
}

PVector getVector(float index, float total) {
  float angle = map(index % total, 0, total, 0, TWO_PI);
  PVector v = PVector.fromAngle(angle + PI);
  v.mult(r);
  return v;
}

void draw() {
  background(255,50);
  int total = 200;
  factor += 0.1;

  translate(width/2, height/2);
  stroke(25);
  strokeWeight(2);
  noFill();
  ellipse(0, 0, r*2,r*2);
  
  strokeWeight(2);
  for (int i = 0; i <= total; i++) {
    PVector a = getVector(i, total);
    PVector b = getVector(i * factor, total);
    line(a.x, a.y, b.x, b.y);
  }
}
*/
