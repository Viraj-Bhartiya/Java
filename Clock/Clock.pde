/*
   Viraj Bhartiya
   Code Freak
   Clock
   
*/

void setup() {
  fullScreen();
}

void draw() {
  background(0);
  translate(width/2,height/2);
  rotate(-HALF_PI);
  
  int hr = hour();
  int mn = minute();
  int sc = second();
  
  scale(1.5);

  strokeWeight(8);
  stroke(255, 100, 150);
  noFill();
  float secondAngle = map(sc, 0, 60, 0, TWO_PI);
  arc(0, 0, 300, 300, 0, secondAngle);

  stroke(150, 100, 255);
  float minuteAngle = map(mn, 0, 60, 0, TWO_PI);
  arc(0, 0, 280, 280, 0, minuteAngle);

  stroke(150, 255, 100);
  float hourAngle = map(hr % 12, 0, 12, 0, TWO_PI);
  arc(0, 0, 260, 260, 0, hourAngle);

  pushMatrix();
  rotate(secondAngle);
  stroke(255, 100, 150);
  line(0, 0, 100, 0);
  popMatrix();

  pushMatrix();
  rotate(minuteAngle);
  stroke(150, 100, 255);
  line(0, 0, 75, 0);
  popMatrix();

  pushMatrix();
  rotate(hourAngle);
  stroke(150, 255, 100);
  line(0, 0, 50, 0);
  popMatrix();

  stroke(255);
  point(0, 0);
}
