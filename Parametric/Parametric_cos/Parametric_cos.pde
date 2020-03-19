/*
   Viraj Bhartiya
   Code Freak
   Parametric Cos
   
*/

static final int NUM_LINES = 10;

float t;

void setup(){
  fullScreen();
}

void draw(){
  background(20);
  //stroke(167,252,0 );
  //stroke(120);
  strokeWeight(3);
  translate(width/2,height/2);

   
  for (int i = 0;i < NUM_LINES ; i++){
  stroke(127,255,212 );
  line(x1(t +i*2),y1(t+i*2),x2(t+i*2),y2(t+i*2)*2.7 );
  stroke(102,255,0);
  line(-(x1(t +i*2)),(-(y1(t+i*2))),(-(x2(t+i*2))),(-(y2(t+i*2)*2.7)) );
  stroke(223,255,0);
  line(-(x1(t +i*2)),y1(t+i*2),(-(x2(t+i*2))),y2(t+i*2)*2.7 );
  stroke(137,207,240);
  line(x1(t +i*2),(-(y1(t+i*2))),x2(t+i*2),(-(y2(t+i*2)*2.7)) );
  } 
  t+=0.5;
 // t++;
 // t = t-5;
}


float x1(float t){
  return cos(t/50)*200 * cos(t/5)*20;
}
float y1(float t){
  return cos(t /50)*200;
}
float x2(float t){
  return cos(t/50)*400 * cos(t)*2;
}
float y2(float t){
  return cos(t /40)*400 * cos(t/12) * 20;
}
