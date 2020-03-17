/*
   Viraj Bhartiya
   Code Freak
   Snowflake
   
*/
float dist = sqrt(sq(mouseY - height/2) + sq(mouseX - width/2));
Particle current;
ArrayList<Particle> snowflake;

void setup() {
  fullScreen();
  current = new Particle(width/2, 0);
  snowflake = new ArrayList<Particle>();
}

void draw() {
  translate(width/2, height/2);
  rotate(PI/6);
  background(0);

  int count = 100;
  while (!current.finished() && !current.intersects(snowflake)) {
    current.update();
    count++;
  }

  if (count == 0) {
    noLoop();
    println("snowflake completed");
  }

  snowflake.add(current);
  current = new Particle(width/2, 0);

  for (int i = 0; i < 6; i++) {
    rotate(PI/3);
    current.show();
    for (Particle p : snowflake) {
      p.show();
    }

    pushMatrix();
    scale(1, -1);
    current.show();
    for (Particle p : snowflake) {
      p.show();
    }
    popMatrix();
  }
}
