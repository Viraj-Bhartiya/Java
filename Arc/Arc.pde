int num =30;
float step, sz, offSet, theta, angle;

void setup() {
  fullScreen();

  //strokeWeight(5);  
  step = 30;
}

void draw() {
  background(20);
  translate(width/2, height/2);

  angle=0;

  colorMode(HSB, 255, 100, 100);

  for (int i=0; i<num; i++) {
    stroke(255/num*i, 90, 90);
    noFill();

    sz = i*step;

    float offSet = TWO_PI/num * i;
    float arcEnd = map(sin(theta+offSet), -1, 1, PI/2, TWO_PI+PI);
    float strWt = map(sin(theta+offSet), 1, -1, 6, 1);

    strokeWeight(strWt);

    arc(0, 0, sz, sz, PI, arcEnd);
  }

  colorMode(RGB);
  resetMatrix();

  theta += 0.06;  
  //  theta += map(mouseX,0,width,0.006,0.07);
}
