import java.util.Random;

// globals
color bg = color(17, 40, 71);
float dt = 0.1;
int flysizemean = 15;
int flysizedev = 5;
float flyaccelmean = 0.3;
float flyacceldev = 0.1;
Random generator;
float v_max = 8.0;

// creatures!
int numFlies = 6;
int numBunnies = 6;
int numCreatures = numFlies + numBunnies; 
Creature[] creatures = new Creature[numCreatures];

void setup() {
  size(640,480);
  background(bg);
  generator = new Random();
  
  // I am lord of the flies!
  for (int i = 0; i < numFlies; i++) {
    creatures[i] = new Fly(i * 1000); 
  }
  
  // ... and bunnies!
  for (int i = 0; i < numBunnies; i++) {
    int fullIndex = i + numFlies;
    creatures[fullIndex] = new Bunny(fullIndex * 1000); 
  }
}

void draw() {
 background(bg);
 
 // loop eventually
 for (Creature c : creatures) {
   c.update();
   c.display();  
 }
}

class Creature {
  int t; // the seed
  
  PVector l;
  PVector v;
  PVector a;
  
  Creature(int seed) {
     t = seed;
  }
  
  void update() {
    // method stub--override
  } 
  
  void display() {
    // method stub--override
  }
}

class Bunny extends Creature {
  int bunnysize;
  float mybounce;
  
  
  Bunny(int seed) {
     super(seed);
     l = new PVector(random(0, width), height - 10);
     bunnysize = 30;
     v = new PVector(0, 0);
     a = new PVector(0, 0);
     mybounce = random(-0.1, -0.05);
  } 
  
  void update() {
    if (l.y + bunnysize >= height) {    
      v.y = -v.y;
      a = new PVector(0, mybounce);
    } else {
      a.add(new PVector(0, 0.05)); // gravity
    }
    v.add(a);
    l.add(v);
    t += dt;
  }
  
  void display() {
    stroke(20);
    fill(255, 0, 0);
    ellipse(l.x, l.y, bunnysize, bunnysize);
  }
}

class Fly extends Creature {
  float theta; // 0 <= theta <= 2*pi
  int flysize;
  float flyaccel;
  
  Fly(int seed) {
    super(seed);
    l = new PVector(random(width), random(height));
    v = new PVector(0, 0);
    theta = random(0, 6.28);
    
    float mynum = (float) generator.nextGaussian();
    float mynuminv = 1 - mynum;
    flysize = (int) (mynum * flysizedev + flysizemean);
    flyaccel = (mynuminv * flyacceldev + flyaccelmean);
  }

  void update() {
    // instead of having the angle here based on smooth (Perlin) noise,
    // we're having the noise dictate the /change/ of angle. This results
    // in a 'changier' angle, giving us loops, like a fly flying!  
    float rand = noise(t);
    float dtheta = map(rand, 0, 1, -0.7, 0.7);
    theta = (theta + dtheta) % 6.28;
    
    a = new PVector(cos(theta), sin(theta));
    a.normalize();
    a.mult(flyaccel);
    
    v.add(a);
    v.limit(v_max);
    l.add(v);
    
    check_bounds();
    
    t += dt;
  }
  
  void check_bounds() {
    if (l.x > width) {
       l.x = 0; 
    } else if (l.x < 0) {
      l.x = width;
    }
    
    if (l.y > height) {
       l.y = 0; 
    } else if (l.y < 0) {
      l.y = height;
    }
  }

  void display() {
    stroke(20);
    fill(175);
    ellipse(l.x, l.y, flysize, flysize);
  }  
}
