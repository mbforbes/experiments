// globals
color bg = color(17, 40, 71);
int flysize = 20;
float flyaccel = 0.5;
float t = 0;
float dt = 0.01;

Fly[] flies = new Fly[1];

void setup() {
  size(640,480);
  background(bg);
  
  // I am lord of the flies!
  for (int i = 0; i < flies.length; i++) {
    flies[i] = new Fly(); 
  }
}

void draw() {
 background(bg);
 
 // loop eventually
 for (Fly f : flies) {
   f.update();
   f.display();  
 }
 t += dt;
}

class Fly {
  
  float theta; // 0 <= theta <= 2*pi
  PVector l;
  PVector v;
  PVector a;
  int v_max;
  
  Fly() {
    l = new PVector(random(width), random(height));
    v = new PVector(0, 0);
    v_max = 3;
  }

  void update() {
    theta = map(noise(t), 0, 1, 0, 6.28);
    a = new PVector(cos(theta), sin(theta));
    a.normalize();
    a.mult(flyaccel);
    
    v.add(a);
    v.limit(v_max);
    l.add(v);
    
    check_bounds();
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

