int cols, rows;
int scl = 30;
int w = 5000;
int h = 2121;

float flying = 0;
float[][] terrain;

void setup() {
  fullScreen(P3D);
  frameRate(300);
  cols = w / scl;
  rows = h/ scl;
  terrain = new float[cols][rows];
  
  noCursor();
}

void draw() {
  flying -= 0.1;

  float yoff = flying;
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -120, 120);
      xoff += 0.2;
    }
    yoff += 0.2;
  }

  background(0);
  noFill();
  stroke(255);

  translate(width/2, height/2+50);
  rotateX(PI/3);
  translate(-w/2, -h/2);
  for (int y = 0; y < rows-1; y++) {
    beginShape(QUAD_STRIP);
    for (int x = 0; x < cols; x++) {
     
      vertex(x*scl, y*scl, terrain[x][y]);
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
      //rect(x*scl, y*scl, scl, scl);
    }
    endShape();
  }
}
