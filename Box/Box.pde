float ang = PI/360;
float ang1 = PI/360;

void setup() {
  fullScreen(P3D);
  smooth();
  frameRate(30);
}

void draw() {
  background(0);

  noFill();
  stroke(255, 150);
  translate(width/2, height/2, 0);
  // rotateX(ang);
  rotateZ(ang);
  rotateY(ang);

  for (int i = 0; i<9; i++) {
    rotate(ang1);
    strokeWeight(1+i*1.07);
    box(50+(i*80));
  }
  ang1+=0.003;
  ang+=0.07;
}
