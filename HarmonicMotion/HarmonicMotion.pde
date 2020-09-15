int pendulumWidth;
int STEP = 25;

public void setup() {
  size(900,900);
  pendulumWidth = width-100;
}

void drawPendulum(float stringLength, float phase) {
  float extremeAngle = asin((pendulumWidth/2)/stringLength);
  float myPhase = phase*map(stringLength, pendulumWidth/2, height, 2, 1);
  float easedPosition = sin (map (myPhase, 0, 1, 0, TWO_PI)); //-1..1
  float currentAngle = map (easedPosition, -1, 1, -extremeAngle, extremeAngle);

  int reddish = color(204, 51, 0);
  int greenish = color(102, 153, 51);
  int blueish = color(51, 102, 153);

  pushStyle();
  pushMatrix();
  translate (width/2, 0);

  float x = sin(currentAngle)*stringLength;
  float curvedY = cos(currentAngle)*stringLength;
  float y = map (mouseX, 0, width, stringLength, curvedY);

  float relativestringLength = map(stringLength, pendulumWidth / 2, height, 0, 1);
  int stringColor = lerpColor (reddish, greenish, relativestringLength);

  float currentOpacity = map (mouseX, 0, width, 0, 255);
  stroke (stringColor, currentOpacity);
  strokeWeight(2);
  line (0, 0, x, y);

  stroke (blueish);
  strokeWeight(25);
  point (x, y);
  popMatrix();
  popStyle();
}

void draw() {
  background(32);
  for (int y = (int)pendulumWidth/2; y < height-25; y+= STEP) {
    drawPendulum(y, frameCount / (60f*4));
  }
}
