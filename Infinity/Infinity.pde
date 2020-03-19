PVector target;
PVector[] points;
float x, y, angle, ease = 0.5;
boolean easing = true;
int num=140, frames=165;

void setup() {
  fullScreen();
  colorMode(RGB, 360, 0, 100);
  points = new PVector[num];

  for (int i=0; i<num; i++) {
    points[i] = new PVector(width/2, height/2);
  }
}

void draw() {
  background(0);
  noStroke();

  float d = 200;

  x = width/2+cos(angle)*d;
  y = height/2+sin(angle*2)*d;

  target = new PVector(x, y);

  PVector leader = new PVector(target.x, target.y);

  for (int i=0; i<num; i++) {
    fill(0, 150, 200.0/num*i);

    PVector point = points[i];
    PVector distance = PVector.sub(leader, point);
    PVector velocity = PVector.mult(distance, ease);

    point.add(velocity);

    ellipse(point.x, point.y, 50, 50);

    leader = point;
  }
  angle += TWO_PI/frames;

  //if (frameCount>250 && frameCount<=250+frames) saveFrame("image-###.gif");
}
