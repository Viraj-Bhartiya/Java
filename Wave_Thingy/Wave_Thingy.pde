int numberOfWaves = 30; 
float theta; // the variable we use to control the speed of the animation
float amplitude; // the maximum 'height' of the wave

void setup() {
  fullScreen();
  noStroke();
}

void draw() {
  background(0);
  for (int i=0; i<numberOfWaves; i++) {
    drawWave(i);
  }
  // if (theta<=TWO_PI) saveFrame("image-###.gif"); I've used this to get the images for my animated GIF
  theta += 0.06; // increase or decrease this value to make the animation go faster or slower
}

void drawWave(int i) {
  randomSeed(123); // I've used randomSeed here to 'stabilize' the random color values, try commenting it out and see what happens
  for (int x=0; x<=width; x+=10) { // this will create an ellipse every 10 pixels, starting from the left border to the right border, change the value to see the difference
    amplitude = map(i, 0, numberOfWaves-1, 1, 100); // in order to have different heights for the different waves I've simply mapped them: the first wave is actually just a point (since the amplitude is 0), the last wave goes up and down 100 pixels, more on map() here: https://www.processing.org/reference/map_.html 
    float offSet = TWO_PI/width*x; // the offSet is used so that not all points of a wave go up and down at the same moment
    float y = height/2 + sin(theta+offSet)*amplitude; // this makes the ellipses of each wave go up and down (to a maximum limited by their respective amplitude value)
    //fill(random(255), random(255), random(255));
    fill(random(255)/numberOfWaves*i,random(255)/numberOfWaves*i,random(255)/numberOfWaves*i); // try using this instead of the previous fill to get shades of colors
    ellipse(x, y, 4, 4);
  }
}
