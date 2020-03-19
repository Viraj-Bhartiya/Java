color FG = #111111;
color BG = 0;
PImage img ; 
PFont TSfont, red, lover, reputation, fearless, speakNow, TS1989;

void setup() {
  size(800, 800);
  background(BG);
  img = loadImage("taylor1.jpg");
  img.resize(900, 900);

  TSfont = createFont("Taylor Swift Handwriting.ttf", 50);
  red = createFont("Max-SemiBold.ttf", 40);
  lover = createFont("Soulmate.ttf", 45);
  reputation  = createFont("Olde English Regular.ttf", 70);
  fearless = createFont("Satisfaction.ttf", 30);
  speakNow = createFont("Satisfaction.ttf", 60);
  TS1989 = createFont("Taylor Swift Handwriting.ttf", 60);
}

void draw() {
  float tileX =100;
  float tileSize = width/tileX;

  for (int y = 0; y< img.height; y+=tileSize) {
    for (int x = 0; x<img.width; x += tileSize) {
      color c = img.get(x, y);
      float b = map(brightness(c), 0, 255, 0, 1);
      pushMatrix();
      fill(255);
      translate(x, y);
      ellipse(0, 0, b * tileSize, b * tileSize);
      popMatrix();
    }
  }
 // word();
}

void word() {

  textAlign(CENTER, CENTER);

  textFont(TSfont);
  text("-Taylor Swift", width-150, height-50);

  textFont(TS1989);
  text("1989", width/2, 130);

  textFont(red);
  textSize(60);
  fill(#F01111);
  text("RED", 75, 125);

  textFont(lover);
  fill(#F01BC2);
  text("Lover", width-160, 42);

  textFont(reputation);
  fill(255);
  text("Reputation", width-200-32, 140);

  textFont(speakNow);
  text("Speak Now", width/2-175+60-20, 40);

  textFont(fearless);
  text("FEARLESS", 175, 180);
}
