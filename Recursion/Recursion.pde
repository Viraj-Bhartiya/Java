float t_step;
int num_dots;

void setup() {
  size(800, 800);
  colorMode(HSB, 255);
  background(0);
  frameRate(30);
  num_dots = 40;
}

void draw() {
  t_step += TWO_PI/120;

  background(0);
  for (float t = 0; t < TWO_PI; t += TWO_PI/num_dots) {

    float x = 1 * cos(t);
    float y = 1 * sin(t);

    x = map(x, -1, 1, 100, width-100);
    y = map(y, -1, 1, height-100, 100);

    float h = map(t, 0, TWO_PI, 0, 255);

    fill(h, 255, 255);
    noStroke();
    ellipse(x, y, 5, 5);

    float x_c = 0.5 * cos(t + t_step);
    float y_c = 0.5 * sin(t + t_step);

    x_c = map(x_c, -1, 1, 100, width-100);
    y_c = map(y_c, -1, 1, height-100, 100);

    ellipse(x_c, y_c, 5, 5);
    stroke(h, 255, 255);
    strokeWeight(1.7);
    line(x, y, x_c, y_c);
  }
  if (t_step < TWO_PI) {
    //saveFrame("cblah###.png");
  }
}
