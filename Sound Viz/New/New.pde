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
PeasyCam cam ;

float alpha = 25;
int tot = 100;
PVector[][] vertices = new PVector[tot][tot];
PVector[] points = new PVector[tot];
float m1, n11, n12, n13, m2, n21, n22, n23 = 0;

void setup() {
  fullScreen();
  minim = new Minim(this);
  in = minim.getLineIn(Minim.STEREO, 1024);
  beat = new BeatDetect();
  beat.setSensitivity(300);
  cam = new PeasyCam(this, 500);
}
int savedTime;
void draw() {
  background(0);
  cam.beginHUD();

  if (alpha<=25) {
    pushStyle();
    stroke(255, 255-alpha);
    strokeWeight(in.mix.level()*500);
    line(0, height/2, width, height/2);
    popStyle();
  }  
  
  if (alpha>=25 && alpha<=50) {
    int index = 0;
    for (int x = 0; x<width; x++) {
      stroke(in.mix.get(index%1024)*1000, alpha);
      strokeWeight(1); 
      line(x, height/4+height/4, x, height/4-height/4);
      line(width-x, height-(height/4+height/4), width-x, height-(height/4-height/4));
      index++;
    }
  }

  for (int i = 0; i<points.length; i++) {
    float x  = map(i, 0, points.length, 0, width);
    float y = height/2+ in.mix.get(i*4)*500;
    points[i] = new PVector(x, y);
  }

  if (alpha >50) {
    for (int i = 0; i<points.length; i++) {
      PVector p1 = points[i];
      for (int j = 0; j<points.length-1; j++) {
        PVector p2 = points[j];
        stroke(255, 25);
        line(p1.x, p1.y, p2.x, p2.y);
      }
    }
  }

  if (beat.isKick()) alpha = random(100);

  cam.endHUD();
  
  
  if(key == ' ') exit();
}
