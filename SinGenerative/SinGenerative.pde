float a = 0;
void setup() {
  size(500, 300);
  colorMode(HSB, 100);
  background(0);
  noStroke();
}

void draw() {

  float x = map(sin(a)*sin(a*0.8), -1, 1, 0, width);
  float y = map(sin(a*1.1+1.5)*sin(a*3.1), -1, 1, 0, height);
  float col = map(sin(a*0.03), -1, 1, 0, 100);
  float sz = map(sin(a*1.7)*sin(a*2.3), -1, 1, 5, 30);
  float bright = map(sin(a*1.3)*sin(a*4.1),-1,1,10,60);

  fill(col, 50, bright);

  ellipse(x, y, sz, sz);

  a+=0.07;
}
