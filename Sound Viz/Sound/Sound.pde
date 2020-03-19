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
  fullScreen();
  noCursor();
  //  frameRate(1000);
  background(0);

  minim = new Minim(this);
  in = minim.getLineIn(Minim.STEREO, width);
  beat = new BeatDetect();
  beat.setSensitivity(500);
  cam = new PeasyCam(this, 450);
}
void draw() {
  beat.detect(in.mix);
  cam.beginHUD();
  blendMode(NORMAL);

  rectMode(CENTER);
  noStroke();
  fill(0, 25);
  rect(width*.5, height*.5, width, height); 
  blendMode(ADD);

  //stroke(25, 25, 222);
  //line(0, height/2, width, height/2);

  for (int i=0; i<128; i++) {

    stroke(222, 25, 25) ;
    if (beat.isOnset()) {
      //stroke(255);
      //noFill();
      //ellipseMode(CENTER);
      //ellipse(width*.5, height*.5, in.mix.get(i)*450, in.mix.get(i)*450);


      //stroke(25, 25, 222);
      //line(0, height/2, width, height/2);

      background(50,200);
    }
    //noFill();
    //ellipseMode(CENTER);
    //ellipse(width*.5, height*.5, in.mix.get(i)*450, in.mix.get(i)*450);
    float x = map(i, 0, 128, 0, width);
    line(x, height/2-in.mix.get(i)*550, x, height/2+in.mix.get(i)*550);
  }

  PVector[] points = new PVector[300];
  for (int i = 0; i<points.length; i++) {
    //float a = map(i, 0, points.length-1, 0, TWO_PI);
    //points[i] = new PVector(width/2+cos(a)*(200+in.mix.get(i)*200), height/2+sin(a)*(200+in.mix.get(i)*200));
    float x = map(i, 0, 127, 0, width);
    points[i] = new PVector(x, height/2-in.mix.get(i)*450);
  }
  for (int i = 0; i<points.length; i++) {
    for (int j =0; j<points.length; j++) {
      if (points[i].dist(points[j])<100) {
        stroke(#07F521);
        //stroke(225, 25);
        line(points[i].x, points[i].y, points[j].x, points[j].y);
      }
    }
  }

  cam.endHUD();
  
  if(key == ' ') exit();
}
