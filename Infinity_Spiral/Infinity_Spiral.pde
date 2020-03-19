final int MAX_PARTICLES = 100;
final int SIZE_SCALE = 4;
final float GRAVITY = 0.6;

ArrayList<Particle> particles = new ArrayList<Particle>();
int time;

void setup() 
{
  fullScreen(P3D);
  noCursor();
  for (int x = 0; x < MAX_PARTICLES; x++) {
    particles.add(new Particle());
  }
  background(0);
  noStroke();
  time = millis();
}

void draw() 
{
  Particle p1, p2;
  
  fill(0, 50);
  rect(0, 0, width, height);
  fill(0);
  
  int count = 0;
  
  // Foreach particle
  for (int i = 0; i < particles.size(); i++) {
    p1 = particles.get(i);
    
    // Apply force of other particles
    for (int j = 0; j < particles.size(); j++) {
      p2 = particles.get(j);
      if (!p1.consumed && !p2.consumed) {
        
        // Collision detection
        float d = PVector.dist(p1.pos, p2.pos);
        if (d > 0 && d < p1.mass * SIZE_SCALE) { // Collision
          if (p1.mass < p2.mass) {
            // Bail out of applying force of other particles
            break;
          } 
        }
        
        // Apply force
        if (i != j) {
          PVector force = p2.attract(p1);
          p1.applyForce(force);
        }
        
        p1.move();
        p1.display();
      }
    }
  }
  
  // Supposed to be used to explode particles
  // Instead does something weird to the mass 
  // so kept it
  if (millis() > time + 2000) {
    float mass = 0;
    Particle biggestParticle = new Particle();
    for (Particle part : particles) {
      if (!part.consumed) {
        if (part.mass > mass) {
          mass = part.mass;
          biggestParticle = part;
        }
      }
    }
  }
}

class Particle
{
  final static float BOUNCE = -0.5;//-1;
  final static float MAX_SPEED = 0.1;
  Boolean consumed = false;
  float mass = random(0.1, 2.0);
  PVector velocity = new PVector(random(-MAX_SPEED, MAX_SPEED), random(-MAX_SPEED, MAX_SPEED));
  PVector acceleration = new PVector(0, 0);
  PVector pos;
  ColourGenerator colour = new ColourGenerator();
  
  Particle()
  {
    // Start at random location
    pos = new PVector (random(width), random(height));
  }
  
  public void move()
  {
    velocity.add(acceleration); // Apply acceleration
    pos.add(velocity); // Apply our speed vector
    acceleration.mult(0);
    
    // Boundary check
    if (pos.x < 0) {
      pos.x = 0;
      velocity.x *= BOUNCE;
    } else if (pos.x > width) {
      pos.x = width;
      velocity.x *= BOUNCE;
    }
    if (pos.y < 0) {
      pos.y = 0;
      velocity.y *= BOUNCE;
    } else if (pos.y > height) {
      pos.y = height;
      velocity.y *= BOUNCE;
    }
  }

  PVector attract(Particle p) 
  {
    PVector force = PVector.sub(pos, p.pos);             // Calculate direction of force
    float distance = force.mag();                                 // Distance between objects
    distance = constrain(distance, 5.0, 25.0);                             // Limiting the distance to eliminate "extreme" results for very close or very far objects
    force.normalize();                                            // Normalize vector (distance doesn't matter here, we just want this vector for direction

    float strength = (GRAVITY * this.mass * p.mass) / (distance * distance); // Calculate gravitional force magnitude
    force.mult(strength);                                         // Get force vector --> magnitude * direction
    return force;
  }
  
  public void applyForce(PVector force) 
  {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }
  
  public void display()
  {
    colour.update();
    noFill();
    //fill(constrain((abs(velocity.x) * 200) +(abs(velocity.y) * 200) , 0, 255),0, 20);
    fill(colour.R, colour.G, colour.B);
    
    ellipse(pos.x, pos.y, mass * 4, mass * 4);
  }
}

class ColourGenerator
{
  final static float MIN_SPEED = 0.2;//7;
  final static float MAX_SPEED = 0.7;//1.5;
  float R, G, B;
  float Rspeed, Gspeed, Bspeed;
  
  ColourGenerator()
  {
    init();
  }
  
  public void init()
  {
    // Random starting colour
    R = random(255);
    G = random(255);
    B = random(255);
    
    // Random transition
    Rspeed = (random(1) > 0.5 ? 1 : -1) * random(MIN_SPEED, MAX_SPEED);
    Gspeed = (random(1) > 0.5 ? 1 : -1) * random(MIN_SPEED, MAX_SPEED);
    Bspeed = (random(1) > 0.5 ? 1 : -1) * random(MIN_SPEED, MAX_SPEED); 
  }
  
  public void update()
  {
    // Random transition (keep within RGB colour range)
    Rspeed = ((R += Rspeed) > 255 || (R < 0)) ? -Rspeed : Rspeed;
    Gspeed = ((G += Gspeed) > 255 || (G < 0)) ? -Gspeed : Gspeed;
    Bspeed = ((B += Bspeed) > 255 || (B < 0)) ? -Bspeed : Bspeed;
  }
}
