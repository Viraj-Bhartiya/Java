import peasy.*;

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
AudioInput in;  
BeatDetect beat;
PeasyCam cam;
 
void setup() {
  fullScreen(P3D);
  noCursor();
  smooth();

  minim = new Minim(this);
  in = minim.getLineIn(Minim.STEREO, width);
  beat = new BeatDetect();
  beat.setSensitivity(350);
  cam = new PeasyCam(this, width);
}

void draw() {
  beat.detect(in.mix);

  // blendMode(NORMAL);
  background(0);

  cam.beginHUD();
  translate(width/2, height/2, 0);
  hint(DISABLE_DEPTH_TEST);
  int total = 200;
  PVector[][] pp = new PVector[total][total];

  for (int i = 0; i < total; i++) {
    float lat = map(i, 0, total-1, -HALF_PI, HALF_PI);

    for (int j =0; j<total; j++) {
      //float lon = map(j, 0, total-1, -TWO_PI, TWO_PI);
      float lon = map(j, 0, total-1, -PI, PI);

      int imnd = i+j*total;
      float r =400 + in.mix.get(imnd%width)*400;

      float x = r*cos(lat)*cos(lon);
      float y = r*sin(lat)*sin(lon);
      float z = r*sin(lon);

      pp[i][j] = new PVector(x, y, z);
    }
  }

  blendMode(ADD);

  for (int i = 0; i<total-1; i++) {
    beginShape(TRIANGLE_STRIP);
    noFill();

    for (int j = 0; j<total; j++) {
      if (random(100)<50) stroke(22, 22, 222, in.mix.get(i)*500);
      else stroke(#03FC2A, in.mix.get(i)*500);

      vertex(pp[i][j].x, pp[i][j].y, pp[i][j].z);
      vertex(pp[i+1][j].x, pp[i+1][j].y, pp[i+1][j].z);
    }
    endShape();
  }

  if (beat.isOnset()) background(255, 100);

  cam.endHUD();   

  if (key == ' ')exit();
}
