/*
   Viraj Bhartiya
   Code Freak
   Pi Day
   
*/
String pi;
int[] digits;
int[] counts = new int[15];
int index = 1;

void setup() {
  fullScreen();
  pi = loadStrings("pi-1million.txt")[0];

  String[] sdigits = pi.split("");

  digits = int(sdigits);

  background(0);
  stroke(255);
  noFill();
  translate(width/2, height/2);
  ellipse(0,0,500,500);
}

void draw() {
  
  translate(width/2, height/2);
  
  int digit = digits[index];
  int nextDigit = digits[index+1];
  index++;
  
  float diff = TWO_PI/15;
  
  float a1 = map(digit,0,10,0,TWO_PI) + random(-diff,diff);
  float a2 = map(nextDigit,0,10,0,TWO_PI) + random(-diff,diff);
  
  float x1 = 250 * cos(a1);
  float y1 = 250 * sin(a1);
  
  float x2 = 250 * cos(a2);
  float y2 = 250 * sin(a2);
  
  stroke(255,51);
  line(x1,y1,x2,y2);

}




/*

String pi;
int[] digits;
int[] counts = new int[15];
int index = 1;

void setup() {
  fullScreen();
  pi = loadStrings("pi-1million.txt")[0];

  String[] sdigits = pi.split("");

  digits = int(sdigits);

  background(0);
  stroke(255);
  noFill();
  translate(width/2, height/2);
  ellipse(0,0,500,500);
}

void draw() {
  
  translate(width/2, height/2);
  
  int digit = digits[index];
  int nextDigit = digits[index+1];
  index++;
  
  float diff = TWO_PI/15;
  
  float a1 = map(digit,0,10,0,TWO_PI) + random(-diff,diff);
  float a2 = map(nextDigit,0,10,0,TWO_PI) + random(-diff,diff);
  
  float x1 = 250 * cos(a1);
  float y1 = 250 * sin(a1);
  
  float x2 = 250 * cos(a2);
  float y2 = 250 * sin(a2);
  
  stroke(random(255),random(255),random(255),random(255));
  line(x1,y1,x2,y2);

}
*/
