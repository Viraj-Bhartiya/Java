/*
   Viraj Bhartiya
   Code Freak
   Leibniz
   
*/

float pi = 4;
int iterations = 0;
FloatList history = new FloatList();

float minY = 2;
float maxY = 4;

void setup() {
  fullScreen();
}

void draw() {
  background(0);
  float den = iterations * 2 + 3;
  if (iterations % 2 == 0) {
    pi -= (4 / den);
  } else {
    pi += (4 / den);
  }
  history.append(pi);

  float piY = map(PI, minY, maxY, height, 0);
  line(0, piY, width, piY);

  stroke(255);
  noFill();
  beginShape();
  float spacing = width / (float) history.size();
  for (int i = 0; i < history.size(); i++) {
    float x = i * spacing;
    float y = map(history.get(i), minY, maxY, height, 0);
    vertex(x, y);
  }
  endShape();
  println(pi);
  iterations++;
}
