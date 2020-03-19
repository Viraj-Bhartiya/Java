float angle = 45;
float ratio = 0.67;
float n = 100;


void setup() {
  fullScreen();
}

void draw() {
  background(15);
  stroke(255);
  translate(width/2, height);
  n = map(mouseX,0,width,100,300);
  branch(n);
}

void branch(float len) {
  line(0, 0, 0, -len);
  translate(0, -len);
  if (len > 4) {
    pushMatrix();
    rotate(angle);
    branch(len * ratio);
    popMatrix();
    pushMatrix();
    rotate(-angle);
    branch(len * ratio);
    popMatrix();
  }
}
void keyPressed(){
  if(key == '+'){
    if (angle<100)angle+=5;
  }
  else if(key == '-'){
    if(angle>20)angle-=5;
  }
}
