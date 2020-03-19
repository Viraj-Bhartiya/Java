import java.util.Iterator;

final int PARTICLE_START_FORCE = 100;
final int PARTILE_MAX_VEL = 20; ///7;//4;
final int PARTICLE_MAX_ACC = 10; // Max particle acceleration
final int SPAWN_COUNT = 2; // Number of particles to spawn at once
final float LIFESPAN_DECREMENT = 2.0;
final int START_SIZE = 50;//100;//175;
final int SHRINK_RATE = 1;//2;//5;
final int MAX_PARTICLES = 100;
final int SPAWN_DELAY = 50; //ms

boolean displayColour = true;
int time = millis();

ParticleSystem system = new ParticleSystem();
ColourGenerator colour = new ColourGenerator();

void setup()
{
  fullScreen();
  //size(deviceWidth,750);
  background(0);
  noCursor();
  frameRate(60);
}

void draw() 
{
  // Update our particle system each frame
  system.update();
}

void mouseDragged()
{
  if (millis() > time + SPAWN_DELAY) {
    system.addParticle(new PVector(mouseX, mouseY));
    time = millis();
  }
}

void keyPressed() 
{
  
  switch (key) {
    case 'r':
      background(0);
      break;
    default:  
      displayColour = !displayColour;  
  }
}

class ParticleSystem
{
  ArrayList<Particle> particles = new ArrayList<Particle>();
  int count = 0;
  
  ParticleSystem() { }
  
  void addParticle(PVector loc)
  {
    count++;
    
    if (particles.size() + SPAWN_COUNT < MAX_PARTICLES) {
      for (int i = 0; i < SPAWN_COUNT; i++) {
        particles.add(new Particle(loc));
      }
    }
  }
  
  void update()
  {
    // Use an iterator to loop through active particles
    Iterator<Particle> i = particles.iterator();
    
    while(i.hasNext()) {
      // Get next particle
      Particle p = i.next();
      
      // update position and lifespan
      p.update();
      
      // Remove particle if dead
      if (p.isDead()) {
        i.remove();
        count--;
      } else {
        p.display();
      }
    }
  }
}

class Particle
{
  PVector loc;
  PVector vel;
  PVector acc;
  
  int size = START_SIZE;
  float angle;

  //ColourGenerator colour = new ColourGenerator();
  
  Particle(PVector loc2) 
  {
    loc = new PVector(loc2.x, loc2.y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
  }
  
  void update()
  {
    // Move in random direction with random speed
    angle += random(0, TWO_PI);
    float magnitude = random(0, PARTICLE_START_FORCE); //3
    
    // Work out force 
    acc.x += cos(angle) * magnitude;
    acc.y += sin(angle) * magnitude;
    
    // limit result
    acc.limit(PARTICLE_MAX_ACC);
    
    // Add to current velocity
    vel.add(acc);
    vel.limit(PARTILE_MAX_VEL);
    
    // Appy result to current location
    loc.add(vel);
    
    // Wrap around screen
    if (loc.x > width)
      loc.x -= width;
     if (loc.x < 0)
       loc.x += width;
     if(loc.y > height)
       loc.y -= height;
     if(loc.y < 0)
       loc.y += height;
       
       size -= SHRINK_RATE;
  }
  
  void display() 
  {
     if (displayColour) {
       //colour = new ColourGenerator();
         colour.update();
        fill(colour.R, colour.G, colour.B);
     } else {
         fill(255);
     }
     ellipse(loc.x, loc.y, size, size);
  }
  
  boolean isDead()
  {
    if (size < 0) {
      return true;
    } else {
      return false;
    }
  }
}

class ColourGenerator
{
  final static float MIN_SPEED = 0.2;
  final static float MAX_SPEED = 0.7;
  float R, G, B;
  float Rspeed, Gspeed, Bspeed;
  
  ColourGenerator()
  {
    init();  
  }
  
  public void init()
  {
    // Starting colour
    R = random(255);
    G = random(255);
    B = random(255);
    
    // Starting transition speed
    Rspeed = (random(1) > 0.5 ? 1 : -1) * random(MIN_SPEED, MAX_SPEED);
    Gspeed = (random(1) > 0.5 ? 1 : -1) * random(MIN_SPEED, MAX_SPEED);
    Bspeed = (random(1) > 0.5 ? 1 : -1) * random(MIN_SPEED, MAX_SPEED);
  }
  
  public void update()
  {
    // Use transition to alter original colour (Keep within RGB bounds)
    Rspeed = ((R += Rspeed) > 255 || (R < 0)) ? -Rspeed : Rspeed;
    Gspeed = ((G += Gspeed) > 255 || (G < 0)) ? -Gspeed : Gspeed;
    Bspeed = ((B += Bspeed) > 255 || (B < 0)) ? -Bspeed : Bspeed;
  }
  
}
