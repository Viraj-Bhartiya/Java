ArrayList<PVector> heart = new ArrayList<PVector>();
float a = 0;
PFont  bold, sharp, big;
PFont TSfont, red, lover, reputation, fearless, speakNow, TS1989, austraLove, everything, everythingB,youBelong , americana;


void setup() {
  fullScreen();
  bold = loadFont("AdobeArabic-Bold-50.vlw");
  sharp = loadFont("AdobeDevanagari-Bold-48.vlw");
  big = loadFont("Broadway-54.vlw");

  TSfont = createFont("Taylor Swift Handwriting.ttf", 50);
  red = createFont("Max-SemiBold.ttf", 40);
  lover = createFont("Soulmate.ttf", 45);
  reputation  = createFont("Olde English Regular.ttf", 70);
  fearless = createFont("Satisfaction.ttf", 30);
  speakNow = createFont("Satisfaction.ttf", 60);
  TS1989 = createFont("Taylor Swift Handwriting.ttf", 60);
  austraLove = createFont("Australove.ttf", 60);
  everything = createFont("Moontells Demo.ttf", 20);
  everythingB = createFont("Moontells Demo.ttf", 30);
  youBelong = createFont("Black Jack.ttf",50);
  americana = loadFont("TimesNewRomanPSMT-48.vlw");
}

void draw() {

  background(0);
  translate(width/2, height/2);

  stroke(#903371);
  strokeWeight(3);
  fill(#F511A9);
  beginShape();
  for (PVector v : heart) {
    vertex(v.x, v.y);
  }
  endShape(CLOSE);
  float r = height/90;
  float x =  r * 16 * pow(sin(a), 3);
  float y = -r * (13 * cos(a) - 5 * cos(2 * a) - 2 * cos(3 * a)- cos(4 * a));
  heart.add(new PVector(x, y));
  endShape(CLOSE);

  if (a > TWO_PI) {
    pushMatrix();
    translate(-(width/2), -( height/2));
    textAlign(CENTER, CENTER);

    strokeWeight(3);
    word();
    popMatrix();
    noLoop();
  }
  a += 0.03;
}
void word() {

  textAlign(CENTER, CENTER);
  fill(255);
  textFont(TS1989);
  text("-Taylor Swift", width-200, height-50);

  textAlign(LEFT, CENTER);

  textFont(TS1989);
  text("1989", width/2, 200);

  text("Its a \nLove Story \nBaby just say \nYES !", 190, height/2);

  textFont(big);
  text("HAPPY\nFREE\nCONFUSED\nand\nLONELY\nin the best way ", 60, 200);

  text("It feels like one of those nights...", width/2-500, 50);

  textFont(red);
  textSize(60);
  fill(#F01111);
  text("RED", width-320, height-870);
  text("13", width-550, height-150);
  text("22", 600, height/2-120);

  textFont(lover);
  fill(#F01BC2);
  text("Lover", 500, 200);

  textFont(reputation);
  fill(255);
  text("Reputation", width/2-100, height/2+430);
  text("Look what you made me do", width/2+100, 125);

  textFont(speakNow);
  text("Speak Now", width-430, height/2);

  textFont(fearless);
  text("FEARLESS", 120, height-80);

  textFont(austraLove);
  text("Please Don't be \nin Love with Sormone\n           else", 400, height-250);

  text("we are never \never ever EVER getting \nBACK  TOGRTHER", width-700, height/2+200);

  textFont(everything);
  text("I know since yesterday ", width-550, height/2-200);
  text("          that", width-600, height/2-160);
  text("EVERYTHING HAS CHANGED", width-550, height/2-120);

  textFont(everythingB);
  text("Darling, I'm ", 60, height-250-20-40);
  text("a nightmre ", 60, height-190-20-40);
  text("dressed like ", 60, height-150-20-40);
  text("a daydream", 60, height-110-20-40);
  
  textFont(youBelong);
  text("You belong with me !",width/2-150,height/2-200);
  
  textFont(americana);
  fill(#7B33A2);
  text("Miss Americana",width/2-150,275);
}
