ArrayList<Firework> fireworks;

PVector gravity = new PVector(0, 0.2);

void setup() {
  fullScreen(P3D);//To Render it in 3D

  fireworks = new ArrayList<Firework>();
  colorMode(HSB);
  background(0);
}

void draw() {
  
  if(key == ' ') exit();
  
  noCursor();

  if (random(1) < 0.2) {
    fireworks.add(new Firework());
  }

  background(0);
  translate(width/2, height, -1000);
  rotateY(frameCount*0.003);

  // Floor
  stroke(0);
  strokeWeight(1);
  fill(0);
  beginShape();
  vertex(-width, height/2, -width);
  vertex(width, height/2, -width);
  vertex(width, height/2, width);
  vertex(-width, height/2, width);
  endShape(CLOSE);


  for (int i = fireworks.size()-1; i >= 0; i--) {
    Firework f = fireworks.get(i);
    f.run();
    if (f.done()) {
      fireworks.remove(i);
    }
  }
}
