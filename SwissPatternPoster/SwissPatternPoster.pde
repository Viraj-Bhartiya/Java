// Global variable declaration

float flag = 0;                  // Variable for rotation of squares

float R = 190;                 // Initial color variables
float G = 10;
float B = 190;

void setup() {
  size(800, 800);
  smooth();                      // Used for anti aliasing the image render of your artwork.
  noLoop();
}

void draw() {
  swisspattern();
}

void swisspattern() {
  background(255);
  for (int i = 50; i <= width-50; i+= 50) {
    for (int j = 50; j <= height-50; j+= 50) {
      pushMatrix();              // Saves the current setting of cor-ordinate system onto a stack
      translate(i, j);            // Moves the origin to a different point in each iteration.
      rectMode(CENTER);
      R -= 1;                   // Incrementing-Decrementing R,G,B values in each look iteration to develop the gradient in the artwork
      G += 1;                   // pattern
      B += 1;
      fill(R, G, B);
      noStroke();
      rotate(degrees(flag*36));  // Rotate about center of the square element
      flag = flag +1;           // Incrementing flag allows to rotate by steps, 36,72,108 etc.
      rect(0, 0, 20, 20);           // Each rectangle is being plotted in the center mode about this new origin in each iteration
      popMatrix();                // Pushes the current setting of the co-ordinate system out of the stack
    }
  }
}
