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


Star[] stars = new Star[1000];

float speed;

void setup() {
  fullScreen();

  minim = new Minim(this);
  in = minim.getLineIn(Minim.STEREO, width);
  beat = new BeatDetect();
  beat.setSensitivity(500);
  cam = new PeasyCam(this, 450);

smooth();

  for (int i = 0; i < stars.length; i++) {
    stars[i] = new Star();
  }
}

void draw() {
  beat.detect(in.mix);

  //  speed = map(mouseX, 0, width, 0, 50);
  background(0);
  for (int i = 0; i < stars.length; i++) {
    resetMatrix();
    pushMatrix();
   

    //  println(in.mix.get(i));
    speed =map(in.mix.get(i)*2, 1*2, -1*2, -100, 100);
     translate(width/2, height/2);

    stars[i].update();
    stars[i].show();

    noFill();
    ellipseMode(CENTER);
    stroke(255);
    ellipse(0, 0, in.mix.get(i)*450, in.mix.get(i)*450);

    popMatrix();
  }
}
