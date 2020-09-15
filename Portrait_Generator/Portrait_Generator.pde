String[] imgNames = {"pro.jpg", "105.jpg", "107.jpg","parrot.jpg"};
PImage img;
int imgIndex = 0;


void nextImage() {
  background(255);
  loop();
  frameCount = 0;

  img = loadImage(imgNames[imgIndex]);
  img.loadPixels();
  
  imgIndex += 1;
  if (imgIndex >= imgNames.length) {
    imgIndex = 0;
  }
}


void paintStroke(float strokeLength, color strokeColor, int strokeThickness) {
  float stepLength = strokeLength/4.0;

  // Determines if the stroke is curved. A straight line is 0.
  float tangent1 = 0;
  float tangent2 = 0;

  float odds = random(1.0);

  if (odds < 0.7) {
    tangent1 = random(-strokeLength, strokeLength);
    tangent2 = random(-strokeLength, strokeLength);
  } 

  // Draw a big stroke
  noFill();
  stroke(strokeColor);
  strokeWeight(strokeThickness);
  curve(tangent1, -stepLength*2, 0, -stepLength, 0, stepLength, tangent2, stepLength*2);

  int z = 1;

  // Draw stroke's details
  for (int num = strokeThickness; num > 0; num --) {
    float offset = random(-50, 25);
    color newColor = color(red(strokeColor)+offset, green(strokeColor)+offset, blue(strokeColor)+offset, random(100, 255));

    stroke(newColor);
    strokeWeight((int)random(0, 3));
    curve(tangent1, -stepLength*2, z-strokeThickness/2, -stepLength*random(0.9, 1.1), z-strokeThickness/2, stepLength*random(0.9, 1.1), tangent2, stepLength*2);

    z += 1;
  }
}


void setup() {
  fullScreen();
  //size(950, 700);
  nextImage();
}


void draw() {
  //img.resize(width,height);

  translate(width/2, height/2);

  int index = 0;

  for (int y = 0; y < img.height; y+=1) {
    for (int x = 0; x < img.width; x+=1) {
      int odds = (int)random(20000);

      if (odds < 1) {
        color pixelColor = img.pixels[index];
        pixelColor = color(red(pixelColor), green(pixelColor), blue(pixelColor), 100);

        pushMatrix();
        translate(x-img.width/2, y-img.height/2);
        rotate(radians(random(-90, 90)));

        // Paint by layers from rough strokes to finer details
        if (frameCount < 20) {
          // Big rough strokes
          paintStroke(random(150, 220), pixelColor, (int)random(20, 40));
        } else if (frameCount < 50) {
          // Thick strokes
          paintStroke(random(75, 125), pixelColor, (int)random(8, 12));
        } else if (frameCount < 300) {
          // Small strokes
          paintStroke(random(30, 60), pixelColor, (int)random(1, 4));
        } else if (frameCount < 350) {
          // Big dots
          paintStroke(random(5, 20), pixelColor, (int)random(5, 15));
        } else if (frameCount < 600) {
          // Small dots
          paintStroke(random(1, 10), pixelColor, (int)random(1, 7));
        }
        else{
          paintStroke(random(1, 5), pixelColor, (int)random(1, 5));
        }

        popMatrix();
      }

      index += 1;
    }
  }

  if (frameCount > 600) {
    noLoop();
  }
}


void mousePressed() {
  nextImage();
}
