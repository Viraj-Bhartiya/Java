float theta ;
void setup() {
  size(800, 800);
}
void draw() {
  background(0);
  noFill();
  stroke(255);
  strokeWeight(15);
  translate(width/2, height/2);
  for (int i =1; i<=30; i++) {
    float offSet = TWO_PI/30 * i;
    float strWt = map(sin(theta+offSet), -1, 1, 10, 1);
    strokeWeight(strWt);

    ellipse(0, 0, 18*i, 18*i);
  }
  theta -= 0.09;
}
