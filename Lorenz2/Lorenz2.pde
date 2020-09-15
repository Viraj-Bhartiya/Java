float x = 0;
float y = 0.01;
float z = 0;

float t = 0;

float a = 10;
float b = 28;
float c = 8/3.0;
ArrayList<PVector> points = new ArrayList<PVector>();

void setup() {
  fullScreen(P3D);
  colorMode(HSB);
}
void draw() {
  background(0);

  float dt = 0.01;
  float dx = (a * (y - x)) * dt;
  float dy = (x * (b - z) - y) * dt;
  float dz = (x * y - c * z) * dt;

  x += dx;
  y += dy;
  z += dz;

  translate(0, 0);
  translate(width/2, height/2);

  noFill();
  scale(6);
  stroke(255);
  rotateX(PI/3 *t);
  rotateY(PI/3 *t);
  rotateZ(PI/3 *t);

  points.add(new PVector(x, y, z));
  lorenz();
  
  t+=0.01;
}

void lorenz() {
  int hu = 0;

  beginShape(TRIANGLE);
  for (PVector v : points) {
    stroke(hu, 255, 255);
    hu +=1;

    if (hu>255)
      hu=0;
    vertex(v.x, v.y, v.z);
  }
  endShape();
}
