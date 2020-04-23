import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer player;
AudioMetaData meta;
BeatDetect beat;
int  r = 300;
float rad = 70;
void setup()
{
  fullScreen();
  //size(600, 400);
  minim = new Minim(this);
  player = minim.loadFile("Kings & Queens.mp3");
  meta = player.getMetaData();
  beat = new BeatDetect();
  player.loop();
  //player.play();
  background(-1);
  noCursor();
}

void draw()
{ 
  // background(0);
  //  float t = map(mouseX, 0, width, 0, 1);
  beat.detect(player.mix);
  fill(#1A1F18, 20);
  noStroke();
  rect(0, 0, width, height);
  translate(width/2, height/2);
  noFill();

  fill(0);
  if (beat.isOnset()) rad = rad*0.1;
  else rad = 80;
  ellipse(0, 0, 2*rad, 2*rad);
  int bsize = player.bufferSize();
  for (int i = 0; i < bsize - 1; i+=5)
  {
    float x = (r)*cos(i*2*PI/bsize);
    float y = (r)*sin(i*2*PI/bsize);

    float x2 = (r + player.left.get(i)*150)*cos(i*2*PI/bsize);
    float y2 = (r + player.left.get(i)*150)*sin(i*2*PI/bsize);

    stroke(-1, 100);
    line(x, y, x2, y2);
  }
  beginShape();
  noFill();
  stroke(-1, 50);
  for (int i = 0; i < bsize; i+=30)
  {
    float x2 = (r + player.left.get(i)*100)*cos(i*2*PI/bsize);
    float y2 = (r + player.left.get(i)*100)*sin(i*2*PI/bsize);
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


void showMeta() {
  int time =  meta.length();
  textSize(50);
  textAlign(CENTER);
  text( (int)(time/1000-millis()/1000)/60 + ":"+ (time/1000-millis()/1000)%60, -7, 21);



  boolean flag =false;
  if ( mousePressed) 
    if (dist(mouseX, mouseY, width/2, height/2)<150) 
      flag =!flag;
}


////
//boolean sketchFullScreen() {
//  return true;
//}

void keyPressed() {
  if (key==' ')exit();
  if (key=='s')saveFrame("###.jpeg");
}
