float theta  = tan(sqrt(10));

void setup () {

  fullScreen();
  colorMode(HSB);
  frameRate(9999999);
}

void draw () {
  background(0);
  float col  = map(theta, 10000, sqrt(sq(width/2)), 255, 255);
  
  for (float i = 0; i<PI*2; i+=PI/10) {
    stroke(random(col), 255, 255);
    pushMatrix();
    translate(width/2, height/2);
    rotate(theta+i);
    line(height, 0, 40, 0);
    theta += 0.002;

    for (float j = 0; j<PI*2; j+=PI/2  ) {

      pushMatrix();
      translate(0, 300);
      rotate(-theta-1);
      line(0, 0, 800, 800);
      popMatrix();
      theta +=0.00004;
    }
      for (float j = 0; j<PI*2; j+=PI/2  ) {

      pushMatrix();
      translate(0, 800);
      rotate(theta-1);
      line(0, 0, 800, 800);
      popMatrix();
      theta +=0.000004;
    }
    
      for (float j = 0; j<PI*2; j+=PI/2  ) {

      pushMatrix();
      translate(0, 800);
      rotate(-theta+1);
      line(0, 0, 800, 800);
      popMatrix();
      theta +=0.000004;
    }
    popMatrix();
  }
}
