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

int cols, rows;
int scl = 30;
int w = 6000;
int h = 4000;

float flying = 0;
float[][] terrain;

void setup() {
  fullScreen(P3D);
  noCursor();
  smooth();

  cols = w / scl;
  rows = h/ scl;
  terrain = new float[cols][rows];

  noCursor();
  
  //frameRate(18);
  
  minim = new Minim(this);
  in = minim.getLineIn(Minim.STEREO, width);
  beat = new BeatDetect();
  beat.setSensitivity(350);
  cam = new PeasyCam(this, width);
}

void draw() {

  cam.beginHUD();
  beat.detect(in.mix);
  //frameRate(60);
  //terrain();
  viz();
  cam.endHUD();
  
  if(key == ' ')exit();

}


void viz() {
  pushMatrix();
  beat.detect(in.mix);
  blendMode(NORMAL);

  rectMode(CENTER);
  noStroke();
  fill(0, 25);
  rect(width*.5, height*.5, width, height); 
  blendMode(ADD);


  for (int i=0; i<128; i++) {

    stroke(#00F4FF);
    //if (beat.isOnset()) {
    //  background(50, 200);
    //}

    float x = map(i, 0, 128, 0, width);
    line(x, height/2-in.mix.get(i)*575, x, height/2+in.mix.get(i)*575);
  }

  PVector[] points = new PVector[300];
  for (int i = 0; i<points.length; i++) {
    float x = map(i, 0, 127, 0, width);
    points[i] = new PVector(x, height/2-in.mix.get(i)*475);
  }
  for (int i = 0; i<points.length; i++) {
    for (int j =0; j<points.length; j++) {
      if (points[i].dist(points[j])<100) {
        stroke(#FFFC00);
        line(points[i].x, points[i].y, points[j].x, points[j].y);
      }
    }
  }
  popMatrix();
}


void terrain() {
  pushMatrix();
  flying -= 0.1+in.mix.level()*1.3;

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
  //stroke(#08E8FF);
  stroke(#9218EA);

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
  popMatrix();
}
