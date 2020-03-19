int num = 250;
Particle[] p = new Particle[num];
public void settings () {
  fullScreen();
}

void setup() {
  noCursor();
  colorMode(HSB);
  for (int i = 0; i < num; i ++) {
    p[i] = new Particle(new PVector(random(width), random(height)), 150, 150);
  }
//  stroke(255);
}

void draw() {
  background(0);
  for (int i = 0; i < num; i ++) {
    p[i].update(p, i);
  }
}
