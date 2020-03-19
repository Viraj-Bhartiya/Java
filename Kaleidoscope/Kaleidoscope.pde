int symmetry = 6;
int angle = 360 / symmetry;
float strokeSize = 4; // use + and - keys to change instead of slider
float xoff;
// press s to save
// press c to clear

void setup() {
  size(800, 800);
  background(0);
  colorMode(HSB);
}

void keyPressed() {
  if (key == 's' || key == 'S') {
    save("snowflake.png");
    println("snowflake saved!");
  } else if (key == 'c' || key == 'C') {
    background(127);
  }
}

void draw() {
  translate(width / 2, height / 2);
  
  int mx = mouseX - width / 2;
  int my = mouseY - height / 2;
  int pmx = pmouseX - width / 2;
  int pmy = pmouseY - height / 2;
  
  if (mousePressed) {
    int hu = int(map(sin(radians(xoff)), -1, 1, 0, 255));
   //float dist = sqrt(sq(mouseY - height/2) + sq(mouseX - width/2));
    xoff += 1;
    stroke(hu, 100);
    //stroke(map(dist, 0, sqrt(sq(width/2) * 2), 0, 255), 255, 255);
    
    for (int i = 0; i < symmetry; i++) {
      rotate(radians(angle));
      
      // float d = dist(mx, my, pmx, pmy);
      // float sw = map(d, 0, 16, 16, 2);
      float sw = strokeSize;
      strokeWeight(sw);
      
      line(mx, my, pmx, pmy);
      
      push();
      scale(1, -1);
      line(mx, my, pmx, pmy);
      pop();
    }
  }
  
  if (keyPressed) {
    if (key == '+' || key == '=') {
      strokeSize = constrain(strokeSize + 0.1, 1, 32);
      println("strokeSize is " + strokeSize);
    } else if (key == '-' || key == '_') {
      strokeSize = constrain(strokeSize - 0.1, 1, 32);
      println("strokeSize is " + strokeSize);
    }
  }
}
