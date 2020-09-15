void setup() {
  size(500, 500);
  background(225);
  rectMode(CENTER);
}
void draw() {
  PVector ltImgPos = new PVector(width/2-150, height/2-50);
  PVector rtImgPos = new PVector(width/2+150, height/2-50);
  PVector ltTxtPos = new PVector(width/2-150,height/2-50);
  
  rect(ltImgPos.x, ltImgPos.y, 150, 200);
  rect(rtImgPos.x, rtImgPos.y, 150, 200);
  
  text("HI",ltTxtPos.x,ltTxtPos.y);
}
