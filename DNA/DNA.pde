int xCount = 360;
float xSpacing = 3.6;
int zCount = 20;
int zSpacing = 5;
boolean smoothCurve = false;


void setup() {
  fullScreen( P3D);
  noCursor();
  
  smooth();
  textSize(20);
  strokeWeight(3);
  
  mouseX = width/2;
  mouseY = height/2;
}


void mousePressed() {
  smoothCurve = !smoothCurve;
}


void draw() {
  background(0);
  
  // Setup camera's transform.
  pushMatrix();
  translate(width/2+50, height/2, 200);
  rotateX(radians(-45));
  rotateY(radians(25));
  
  for (int z = 0; z < zCount; z++) {
    for (int x = 0; x < xCount; x++) {
      pushMatrix();
      float twistMult = map(mouseX, 0, width, 1, 3.6);
      rotateX(-(frameCount*0.025+x*0.05)*twistMult);
      
      pushMatrix();
      float waveMult = map(mouseY, height, 0, 0, 25);
      float wave = -sin((frameCount+x)*0.1)*waveMult;
      
      if (smoothCurve) {
        float spread = 1;
      } else {
        float spread = sin(frameCount*0.02+x);
      }
    
      translate((x*xSpacing-(xCount*xSpacing*0.5))+wave, 0, (z*zSpacing-(zCount*zSpacing*0.5)));
      
      // Hardcoded a color scheme.
      if (x % 5 == 0) {
        stroke(143,145, 166);
      } else if (x % 4 == 0) {
        stroke(241, 253, 174);
      } else if (x % 3 == 0) {
        stroke(37, 142, 244);
      } else if (x % 2 == 0) { 
        stroke(39,181, 199);
      } else {
        stroke(117, 224, 241);
      }
      
      point(0, 0, 0);
      
      popMatrix();
      popMatrix();
    }
  }
  
  popMatrix();
  
  // Display controls.
  fill(255);
  noStroke();
  
  text("Twist", 50, 50);
  rect(120, 55, map(mouseX, 0, width, 0, 100), 5);
  
  text("Wave", 50, 80);
  rect(120, 85, map(mouseY, height, 0, 0, 100), 5);
  
  text("Smooth", 50, 110);
  if (smoothCurve) {
    fill(0, 255, 0);
    text("ON", 130, 110);
  } else {
    fill(255, 0, 0);
    text("OFF", 130, 110);
  }
}
