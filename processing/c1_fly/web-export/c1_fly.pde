// globals
color bg = color(17, 40, 71);
float dt = 0.1;
int flysizemean = 15;
int flysizedev = 5;
int flyaccelmean = 0.8;
int flyacceldev = 0.5;

Fly[] flies = new Fly[10];

void setup() {
  size(640,480);
  background(bg);
  Random generator = new Random();
  
  // I am lord of the flies!
  for (int i = 0; i < flies.length; i++) {
    flies[i] = new Fly(i * 1000); 
  }
}

void draw() {
 background(bg);
 
 // loop eventually
 for (Fly f : flies) {
   f.update();
   f.display();  
 }
}

class Fly {
  
  float theta; // 0 <= theta <= 2*pi
  PVector l;
  PVector v;
  PVector a;
  int v_max;
  float t;
  int flysize;
  float flyaccel;
  
  Fly(int seed) {
    l = new PVector(random(width), random(height));
    v = new PVector(0, 0);
    theta = random(0, 6.28);

    v_max = 3;
    t = seed;
    
    float mynum = generator.nextGaussian();
    flysize = mynum * flysizedev + flysizedmean;
    flyaccel = mynum * flyacceldev + flyaccelmean;
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

