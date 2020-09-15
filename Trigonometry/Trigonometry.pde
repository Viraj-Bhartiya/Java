/*
* Created by Jan Pernecky on 23.03.2016.
 *  www.rese-arch.org
 */

final float CIRCLE_SIZE = 200;
final float GAP = 25;

void setup(){
  fullScreen();
  //size (675,675);
  noFill();
}

void displayCircle(float phase) {
  pushStyle();
  pushMatrix();

  float radius = CIRCLE_SIZE/2;                  //circle radius
  translate (GAP+radius, GAP+radius);     //move origin to the center of the circle

  stroke(255);                    //white
  strokeWeight(2);                //thin line
  ellipse(0, 0, CIRCLE_SIZE, CIRCLE_SIZE);      //draw circle

  final float ANGLE_SHIFT = 0;            //sync circle (starts at 90 deg) and cosine wave
  float angle = 2*PI*phase+ANGLE_SHIFT;               //current angle
  float relativeX = cos(angle)*radius;    //IMPORTANT: x of the current point
  float relativeY = sin(angle)*radius;    //IMPORTANT: y of the current point

  strokeWeight(1);                //thin line
  stroke(255, 128);                    //transparent white
  line (0, 0, relativeX, relativeY);    //radius line

  stroke (204, 51, 0);                          //red
  line (0, 0, relativeX, 0);                  //line from center to x of the current point
  stroke (102, 153, 51);                        //green
  line (relativeX, 0, relativeX, relativeY);  //line from the current point to the horizontal axis of the circle

  stroke (51, 102, 153);            //blue
  strokeWeight(10);               //thick
  point (relativeX, relativeY);    //current point on the circle

  fill (255);                                 //white text
  rotate (angle);                             //rotate coordinate system to match the current angle
  text((int)degrees(abs(angle-ANGLE_SHIFT))%360+"°", 5, -2);   //display angle in degrees in the center of the circle

  popMatrix();
  popStyle();
}

void sineWave(float phase) {
  pushStyle();
  pushMatrix();

  translate (GAP+CIRCLE_SIZE+GAP, GAP+CIRCLE_SIZE/2);   //move to the beginning fo the sine wave

  float currentAngle = 2*PI*phase;                                //current angle of the circle
  final float WAVE_LENGTH = CIRCLE_SIZE*2;                               //size of a full sine wave in pixels
  float grossLength = width-(GAP+CIRCLE_SIZE+GAP)-GAP;                   //how much space is left for the sine wave
  float length = floor(grossLength/WAVE_LENGTH)*WAVE_LENGTH;      //only draw full 360 deg cosine waves

  float currentX = WAVE_LENGTH * currentAngle / (2 * PI) % length;    //x of the current angle on the sine wave
  float currentY = sin(currentAngle) * CIRCLE_SIZE/ 2;                      //y of the current angle on the sine wave

  stroke(255);                            //white
  strokeWeight(2);                        //thin line
  for (int x=0; x<length; x+=2) {          //for each X
    float angle = 2*PI*x/WAVE_LENGTH;   //angle for current X
    point (x, sin(angle)*CIRCLE_SIZE/2 );      //sine wave point
  }

  strokeWeight(1);                        //thin line
  stroke(255, 128);                        //transparent white
  line (0, currentY, length, currentY);     //full horizontal line
  stroke (102, 153, 51);                    //green
  line (currentX, 0, currentX, currentY);    //vertical green line
  strokeWeight(10);                       //thick
  stroke (51, 102, 153);                    //blue
  point (currentX, currentY);             //current angle on the cosine wave
  point (0, currentY);                    //current angle at the beginning of the white line

  fill (102, 153, 51);  //green text
  //display degrees and sine values
  text("sin("+(int)degrees(currentAngle)%360+"°)="+(int)(-1*sin(currentAngle)*100)/100.0, 10, currentY-2);

  popMatrix();
  popStyle();
}


void cosineWave(float phase) {
  pushStyle();
  pushMatrix();

  translate (GAP+CIRCLE_SIZE/2, GAP+CIRCLE_SIZE+GAP);   //move to the beginning fo the cosine wave

  float currentAngle = 2*PI*phase;                                //current angle of the circle
  final float WAVE_LENGTH = CIRCLE_SIZE*2;                               //size of a full cosine wave in pixels
  float grossLength = height-(GAP+CIRCLE_SIZE+GAP)-GAP;                  //how much space is left for the cosine wave
  float length = floor(grossLength/WAVE_LENGTH)*WAVE_LENGTH;      //only draw full 360 deg cosine waves

  float currentX = cos(currentAngle) * CIRCLE_SIZE/ 2;                      //x of the current angle on the cosine wave
  float currentY = WAVE_LENGTH * currentAngle / (2 * PI) % length;    //y of the current angle on the cosine wave

  stroke(255);                                //white
  strokeWeight(2);                            //thin line
  for (int y=0; y<length; y+=2) {              //for each X
    float angle = 2*PI*(y/WAVE_LENGTH);     //angle for current X
    point ( cos(angle)*CIRCLE_SIZE/2, y );         //cosine wave point
  }

  strokeWeight(1);                        //thin line
  stroke(255, 128);                        //transparent white
  line (currentX, 0, currentX, length);    //full vertical line
  stroke (204, 51, 0);                      //red
  line (0, currentY, currentX, currentY);    //horizontal red line
  strokeWeight(10);                       //thick
  stroke (51, 102, 153);                    //blue
  point (currentX, currentY);             //current angle on the cosine wave
  point (currentX, 0);                     //current angle at the beginning of the white line

  fill (204, 51, 0);        //red text
  translate(currentX, 0);  //move origin to the beginning of the white line
  rotate (PI/2);          //rotate clockwise
  //display degrees and cosine values
  text("cos("+(int)degrees(currentAngle)%360+"°)="+(int)(cos(currentAngle)*100)/100.0, 10, -2);

  popMatrix();
  popStyle();
}

void tanWave(float phase) {
  pushStyle();
  pushMatrix();

  float currentAngle = 2*PI*phase;                                //current angle of the circle
  final float WAVE_LENGTH = CIRCLE_SIZE*2;                               //size of a full cosine wave in pixels
  float grossHorizontalLength = width-(GAP+CIRCLE_SIZE+GAP)-GAP;                         //how much space is left
  float horizontalLength = floor(grossHorizontalLength/WAVE_LENGTH)*WAVE_LENGTH;  //only draw full 360 deg waves
  float verticalLength = height-(GAP+CIRCLE_SIZE+GAP)-GAP;                               //how much space is left

  translate (GAP+CIRCLE_SIZE+GAP, GAP+CIRCLE_SIZE+GAP+verticalLength/2);      //move to the beginning fo the cosine wave

  float currentX = WAVE_LENGTH * currentAngle / (2 * PI) % horizontalLength;  //x of the current angle on the wave
  float currentY = -1*tan(currentAngle) * CIRCLE_SIZE/ 2;             //y of the current angle on the wave

  stroke(255);                                        //white
  strokeWeight(2);                                    //thin line
  for (int x=0; x<horizontalLength; x++) {             //for each X
    float angle = 2*PI*x/WAVE_LENGTH;   //angle based on  X
    float y = -1*tan(angle)*CIRCLE_SIZE/2;                 //y based on tan of the angle
    if (abs(y)<verticalLength/2) {                  //only draw if on canvas
      point (x, y);                                //tan wave point
    }
  }

  strokeWeight(1);                                        //thin line
  if (abs(currentY)<verticalLength/2) {                   //only draw if on canvas
    stroke(255, 128);                                   //transparent white
    line(0, currentY, horizontalLength, currentY);      //full horizontal line
  } else {                                                //else
    currentY = currentY/abs(currentY)*verticalLength/2; //change the currentY to either top or bottom of canvas
  }

  stroke (51, 102, 153);                        //blue
  line(currentX, 0, currentX, currentY);      //vertical blue line
  strokeWeight(10);                           //thick
  point (currentX, currentY);                 //current angle on the cosine wave
  point (0, currentY);                        //current angle at the beginning of the white line

  fill (51, 102, 153);  //blue text
  //display degrees and tan values
  text("tan("+(int)degrees(currentAngle)%360+"°)="+(int)(tan(currentAngle)*100)/100.0, 10, currentY-2);

  popMatrix();
  popStyle();
}

public void draw() {
  background(32);
  float phase = frameCount/(60f*15);  //15 seconds to make the full circle
  displayCircle(phase);
  cosineWave(phase);
  sineWave(phase);
  tanWave(phase);
}
