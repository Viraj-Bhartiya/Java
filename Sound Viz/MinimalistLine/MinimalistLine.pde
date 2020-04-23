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


Star[] stars = new Star[5000];
float speed;

int  r = 300;
float rad = 70;


void setup() {
  fullScreen();
  noCursor();
  background(0);

  minim = new Minim(this);
  in = minim.getLineIn(Minim.STEREO, width);
  beat = new BeatDetect();
  beat.setSensitivity(500);
  cam = new PeasyCam(this, 450);

  for (int i = 0; i < stars.length; i++) {
    stars[i] = new Star();
  }
}
void draw() {
  background(0);
  beat.detect(in.mix);
  cam.beginHUD();
  blendMode(NORMAL);

  rectMode(CENTER);
  noStroke();
  fill(0, 25);
  //rect(width*.5, height*.5, width, height); 
  blendMode(NORMAL);

  //for (int i=0; i<150; i++) {

  //  stroke(#08F5FF) ;
  //  //if (beat.isOnset()) {
  //  //  background(50,200);
  //  //}
  //  float x = map(i, 0, 128, 0, width);
  //  line(x, height/2-in.mix.get(i)*550, x, height/2+in.mix.get(i)*550);
  //}

  PVector[] points = new PVector[400];
  for (int i = 0; i<points.length; i++) {
    float x = map(i, 0, points.length, 0, width);
    points[i] = new PVector(x, height/2-in.mix.get(i)*450);
  }
  for (int i = 0; i<points.length; i++) {
    rotate(map(i, 0, points.length, 0, 360));
    for (int j =0; j<points.length/1.5; j++) {
      if (points[i].dist(points[j])<500) {
        stroke(#08F5FF*j) ;
        resetMatrix();
        translate(width/2, height/2);
        rotate(-(map(j, 0, points.length, 0, 360)));
        line(i*.1, height/2-in.mix.get(i)*500, i*.1, height/2+in.mix.get(i)*500);
      }
    }
  }
  //ex();
  cir();
  star();
  cam.endHUD();
  if (key == ' ') exit();
}




void star() {
  beat.detect(in.mix);

  for (int i = 0; i < stars.length; i++) {
    resetMatrix();
    pushMatrix();


    //  println(in.mix.get(i));
    speed =map(in.mix.get(i)*2, 1*2, -1*2, -500, 500);
    translate(width/2, height/2);

    //stars[i].update();
    //stars[i].show();

    noFill();
    ellipseMode(CENTER);
    stroke(255);
    //ellipse(0, 0, in.mix.get(i)*450, in.mix.get(i)*450);

    popMatrix();
  }
}





void cir(){ 
  resetMatrix();
  // background(0);
  //  float t = map(mouseX, 0, width, 0, 1);
  beat.detect(in.mix);
  fill(#1A1F18, 20);
  noStroke();
  rect(0, 0, width, height);
  translate(width/2, height/2);
  noFill();

  fill(0);
  if (beat.isOnset()) rad = rad*0.9;
  else rad = 80;
  ellipse(0, 0, 2*rad, 2*rad);
  int bsize = in.bufferSize();
  for (int i = 0; i < bsize - 1; i+=5)
  {
    float x = (r)*cos(i*2*PI/bsize);
    float y = (r)*sin(i*2*PI/bsize);

    float x2 = (r + in.mix.get(i)*500)*cos(i*2*PI/bsize);
    float y2 = (r + in.mix.get(i)*500)*sin(i*2*PI/bsize);

    stroke(-1, 500);
    line(x, y, x2, y2);
  }
  beginShape();
  noFill();
  stroke(-1, 50);
  for (int i = 0; i < bsize; i+=30)
  {
    float x2 = (r + in.mix.get(i)*300)*cos(i*2*PI/bsize);
    float y2 = (r + in.mix.get(i)*300)*sin(i*2*PI/bsize);
    vertex(x2, y2);

    pushStyle();
    stroke(-1);

    stroke(255);

    strokeWeight(2);
    point(x2, y2);
    popStyle();
  }
  endShape();
  // if (flag)
  // showMeta();

}


/*

void ex(){
  resetMatrix();
  float t = map(mouseX, 0, width, 0, 1);
  beat.detect(in.mix);
  fill(#1A1F18, 20);
  noStroke();
  rect(0, 0, width, height);
  translate(width/2, height/2);
  noFill();
  fill(-1, 10);
  if (beat.isOnset()) rad = rad*0.9;
  else rad = 70;
  ellipse(0, 0, 2*rad, 2*rad);
  stroke(-1, 50);
  int bsize = in.bufferSize();
  for (int i = 0; i < bsize - 1; i+=5)
  {
    float x = (r)*cos(i*2*PI/bsize);
    float y = (r)*sin(i*2*PI/bsize);
    float x2 = (r + in.mix.get(i)*300)*cos(i*2*PI/bsize);
    float y2 = (r + in.mix.get(i)*300)*sin(i*2*PI/bsize);
    line(x, y, x2, y2);
  }
  beginShape();
  noFill();
  stroke(-1, 50);
  for (int i = 0; i < bsize; i+=30)
  {
    float x2 = (r + in.mix.get(i)*300)*cos(i*2*PI/bsize);
    float y2 = (r + in.mix.get(i)*300)*sin(i*2*PI/bsize);
    vertex(x2, y2);
    pushStyle();
    stroke(-1);
    strokeWeight(2);
    point(x2, y2);
    popStyle();
  }
  endShape();
 // if (flag)
 // showMeta();
}
*/
