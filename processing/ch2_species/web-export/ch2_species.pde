import java.util.concurrent.ConcurrentLinkedQueue; 


// global constants
// ---------
// this does nothing! hahaha... processing just isn't getting the events
// in the first place. wow.
int numClicks = 0;
ConcurrentLinkedQueue<java.awt.event.MouseEvent> clicks;

// background
int SCREEN_HEIGHT = 480;
int SCREEN_WIDTH = 640;
color BG = color(186, 254, 255);

// ground
int GROUND_HEIGHT = 100;
int GROUND_WIDTH = 400;
int GROUND_THICKNESS = 5;
int GROUND_LEVEL = SCREEN_HEIGHT - GROUND_HEIGHT;
color GROUND_COLOR = color(0, 200, 10);
color DIRT_COLOR = color(150, 109, 32);

// water
color WATER_COLOR = color(102, 137, 242);
int WATER_SINKAGE = 30;
int WATER_LEVEL = GROUND_LEVEL + WATER_SINKAGE;
float WATER_DRAG = 0.07;

// physics
float GRAVITY_FORCE_MAGNITUDE = 0.3;
PVector GRAVITY_FORCE = new PVector(0, GRAVITY_FORCE_MAGNITUDE);
float FRICTION = 0.08;
float BOUNCE_DAMPENING = 0.9;
float MOTION_CUTOFF = 0.05;

// creature-specific constants are in their respsective classes

// globals
// -------
Creature[] creatures;
int numBouncers = 1;
int numCreatures = numBouncers;
void setup() {
  // for exporing only...
  size(640, 480);
  //size(SCREEN_WIDTH, SCREEN_HEIGHT);
  clicks = new ConcurrentLinkedQueue<java.awt.event.MouseEvent>();
  creatures = new Creature[numCreatures];
  for (int i = 0; i < numBouncers; i++) {
   creatures[i] = new Bouncer(); 
  }
}

void draw() {
  draw_background();
  
   for (Creature c : creatures) {
     c.update();
     c.display();  
 }
}

void draw_background() {
   background(BG);
   
   // ground
   stroke(0);
   fill(GROUND_COLOR);
   rect(0, GROUND_LEVEL, GROUND_WIDTH, GROUND_THICKNESS);
   // dirt
   fill(DIRT_COLOR);
   rect(0,
        GROUND_LEVEL + GROUND_THICKNESS,
        GROUND_WIDTH,
        GROUND_HEIGHT - GROUND_THICKNESS);
   
   // water
   stroke(WATER_COLOR);
   fill(WATER_COLOR);
   rect(GROUND_WIDTH + 1, // pixel border
        GROUND_LEVEL + WATER_SINKAGE,
        width - GROUND_WIDTH - 1, // pixel border
        GROUND_HEIGHT - WATER_SINKAGE);
}

  // test: will this work?
  void mouseClicked(java.awt.event.MouseEvent event) {
    // can only bounce on the ground!
    if (isOnGround(creatures[0])) {
      clicks.add(event);
    }
  }

class Bouncer extends Creature {
 // important note: all bouncer coordinates are done using 
 // ellipseMode(CORNER). In other words, coordinates are calculated assuming
 // the position of the bouncer is its upper-left corner, with its body 
 // stretching down 'height' and right 'width'.
 
  color BOUNCER_COLOR = color(138, 93, 156);
  int BOUNCER_HEIGHT = 30;
  int BOUNCER_WIDTH = 30;
  float BOUNCER_POWER = 40;
  PVector target; // for motion. null when no command.
  
  Bouncer() {
    super();
    target = null;
    myheight = BOUNCER_HEIGHT;
    mywidth = BOUNCER_WIDTH;
    p = new PVector(random(0, GROUND_WIDTH - BOUNCER_WIDTH),
                    GROUND_LEVEL - BOUNCER_HEIGHT - 30);
    m = 4;
  } 
  
  void update() {
    // process clicks from the concurrent data structure
    while (!clicks.isEmpty()) {
       java.awt.event.MouseEvent e = clicks.remove();
       target = new PVector(e.getX(), e.getY());
    }
    
    // forces
    // ------
    // experiment: motion as acceleration, applied first
    clickMotion();
    
    // water resistance
    if (isUnderwater(this)) {
      float speed = v.mag();
      float dragMag = WATER_DRAG * speed * speed;
      PVector drag = v.get();
      drag.mult(-1);
      drag.normalize();
      drag.mult(dragMag);
      applyForce(drag);
    }
    
    // friction
    PVector friction = v.get();
    friction.mult(-1);
    friction.normalize();
    friction.mult(FRICTION);
    applyForce(friction);
    
    // gravity
    if (!isOnGround(this)) {
      applyForce(GRAVITY_FORCE);
    }

    // integrate to velocity
    v.add(a);
    
    // integrate to position
    p.add(v);
    
    // deal with boundaries
    boundaries(this);
    
    // clear acceleration each time
    a.mult(0.0);
  }
  
  void clickMotion() {
    if (target != null) {
      int dx = (int) (target.x - p.x);
      int dy = (int) (target.y - p.y);
      PVector motion = new PVector(dx, dy);
      motion.normalize(); // make into unit vector
      motion.mult(BOUNCER_POWER);
      applyForce(motion);
      target = null;
    } 
  }
  
  void display() {
    stroke(0);
    fill(BOUNCER_COLOR);
    ellipseMode(CORNER);
    ellipse(p.x, p.y, BOUNCER_HEIGHT, BOUNCER_WIDTH);
  }
}

void boundaries(Creature c) {
 // x-direction: bounce
 if (c.p.x < 0) {
   if (c.v.x < 0) { // this is almost assuredly true
     c.v.x = - (c.v.x * BOUNCE_DAMPENING);
   }
   c.p.x = 0;
 } else if (c.p.x + c.mywidth > width) {
   if (c.v.x > 0) { // this is almost assuredly true
     c.v.x = - (c.v.x * BOUNCE_DAMPENING);
   }
   c.p.x = width - c.mywidth;
 }
 
  // x-direction: dirt wall. note that there is math overlap here! need
  // a more general approach.
 if (c.p.y > GROUND_LEVEL && c.p.x < GROUND_WIDTH
         && c.p.x + 20 > GROUND_WIDTH) // doing a margin check...
 {
   c.v.x = - (c.v.x * BOUNCE_DAMPENING);
   c.p.x = GROUND_WIDTH;
 }

 // y-direction: stop or nothing
 if (isOnGround(c)) {
   if (c.v.y > 0) { // almost assuredly true
     c.v.y = - (c.v.y * BOUNCE_DAMPENING);
   }
   if (isUnderwater(c)) {
     c.p.y = height - c.myheight;
   } else {
     c.p.y = GROUND_LEVEL - c.myheight;
   }  
 }
}

// function for all creatures
boolean isOnGround(Creature c) {
  return (c.p.x < GROUND_WIDTH && c.p.y + c.myheight >= GROUND_LEVEL) ||
         (c.p.y + c.myheight >= height);
}

boolean isUnderwater(Creature c) {
   return (c.p.x > GROUND_WIDTH && c.p.y >= WATER_LEVEL);
}

class Creature {
  int myheight;
  int mywidth;
  
  PVector p;
  PVector v;
  PVector a;
  int m;
  
  Creature() {
    p = new PVector(0,0);
    v = new PVector(0.0,0.0);
    a = new PVector(0.0,0.0);
    m = 1;
  }
  
  void applyForce(PVector force) {
    PVector f = PVector.div(force, m); 
    a.add(f);
  }
  
  void update() {
    // method stub--override
  } 
  
  void display() {
    // method stub--override
  }
}

