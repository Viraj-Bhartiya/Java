float n = 11, d = 56;
//float n = 11, d = 100;
//float n = 13, d = 77;
//float n = 8, d = 99;
void setup() {
  fullScreen();
}

void draw() {
  background(0);
  translate(width/2, height/2);

  noFill();
  strokeWeight(1.2);
  // scale(1.5);

  beginShape();
  for (float i = 0; i<TWO_PI +1; i += (TWO_PI/360)) {
    float k = i * d;
    float r = 500 * sin(n*k);
    float x  = r * cos(k);
    float y = r*sin(k);

    stroke(255, 225);

    vertex(x, y);
  } 
  endShape();
  n+=0.00007;
  d+=0.00007;

  if (key == ' ')exit();
}
