Snake s;
int scl = 20;
int frame = 7;

PVector food;

void setup() {
  fullScreen();
  s = new Snake();

  pickLocation();
}


void pickLocation() {
  int cols = width/scl;
  int rows = height/scl;
  food = new PVector(floor(random(cols)), floor(random(rows)));
  food.mult(scl);
}


void mousePressed() {
  s.total++;
}


void draw() {

  fill(255);
  textSize(30);
  text(s.total, width/2, height/2);

  background(15);
  frameRate(frame);
  if (s.eat(food)) {
    pickLocation();
  }
  s.death();
  s.update();
  s.show();


  fill(255, 0, 100);
  rect(food.x, food.y, scl, scl);
}
void keyPressed() {
  if (keyCode == UP) {
    s.dir(0, -1);
  } else if (keyCode == DOWN) {
    s.dir(0, 1);
  } else if (keyCode == RIGHT) {
    s.dir(1, 0);
  } else if (keyCode == LEFT) {
    s.dir(-1, 0);
  }

  if (key == '+') {
    if (frame<20) {
      frame++;
    }
  } else if (key == '-') {
    if (frame>1)
      frame--;
  }
}  
