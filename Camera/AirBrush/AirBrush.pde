import processing.video.*;

Capture cam;
int x, y;
void setup() {
  size(1280, 720);  
  frameRate(10);
  background(0);
  printArray(Capture.list());
  cam = new Capture(this, 1280, 720, "EasyCamera", 10);
  cam.start();
}

void draw() {
  translate(0,height);
  if (cam.available()) {
    cam.read();
    cam.loadPixels();
    loadPixels();
    for (int i = 0; i<cam.pixels.length; i++) {
      if (brightness(cam.pixels[i])>250) {
        pixels[i] = color(255);
      }
      //else pixels[i] = color(0);
    }
    updatePixels();
  }
  if (key == ' ')exit();
  if (key == 'n'||key == 'N') background(0);
}
