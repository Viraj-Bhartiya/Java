String txt;

float y = 0;

void setup() {
  fullScreen(P3D);
  String[] lines = loadStrings("apple.txt");
  txt = join(lines, "\n");
  y = height/2;
}

void draw() {
  background(0);
  translate(width/2, height/2);

  fill(93,138,168);
  textSize(width*0.02);
  textAlign(CENTER);
  rotateX(PI/4);
  float w = -width;
  text(txt, -w/2, y, w, height*10);

  y-=2;
}
