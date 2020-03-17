float x = width /2, y = height/2, xspeed = 10, yspeed = 10 ;

void setup() {
  fullScreen();
}

void draw () {
  direction();
  speed();
  background(0);
  fill(255);
  ellipse(x, y, 100, 100);
}

void direction() {
  if (x > width || x < 0 ) xspeed = xspeed *-1;
  if (y > height || y < 0 ) yspeed = yspeed *-1;
}

void speed() {
  x = x + xspeed;
  y = y + yspeed;
}
