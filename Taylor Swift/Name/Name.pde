PFont font;
PGraphics pg;

void setup() {
  font = createFont("Taylor Swift Handwriting.ttf", 200);
  size(1000, 1000, P2D);
  pg = createGraphics(1000, 1000, P2D);
}

void draw() {
  background(0);

  // PGraphics 

  pg.beginDraw();
  pg.background(0);
  pg.fill(255);
  pg.textFont(font);
  pg.textSize(190);
  pg.pushMatrix();
  pg.translate(width/2, height/2);
  pg.textAlign(CENTER, CENTER);
  pg.text("Taylor Swift", 0, 0);
  pg.popMatrix();
  pg.endDraw();

  int tilesX =16;
  int tilesY = 16;

  int tileW = int(width/tilesX);
  int tileH = int(height/tilesY);

  for (int y = 0; y < tilesY; y++) {
    for (int x = 0; x < tilesX; x++) {

      // WARP
      int wave = int(sin(frameCount * 0.05 + ( x * y ) * 0.07) * 100);

      // SOURCE
      int sx = x* tileW + wave;
      int sy = y* tileH;
      int sw = tileW;
      int sh = tileH;


      // DESTINATION
      int dx = x*tileW;
      int dy = y*tileH;
      int dw = tileW;
      int dh = tileH;

      copy(pg, sx, sy, sw, sh, dx, dy, dw, dh);
    }
  }
}
