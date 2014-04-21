// settings
color pink = color(250, 20, 120);
color brown = color(30, 30, 30);
float base_x = 512.0;
float base_y = 184.0;
int plat_y = 568;

// the world
float f_g = 0.1;
float f_fr = 0.98;

// ball vars
int d = 50;
int r = d / 2;
PVector p = new PVector(base_x, base_y);
PVector v = new PVector(4.0, 0.0);
PVector a = new PVector(0.0, 0.0);

void setup() {
 size(1024, 768); 
}

void draw() {
  // draw background
  background(255, 255, 255);
  
  a.mult(0);
  
  PVector gravity = new PVector(0, f_g);
  a.add(gravity);
  
  v.add(a);
  
    
  // friction
  v.mult(f_fr);
  
  
  p.add(v);
  
  collide_floor();
  right_wall();
  left_wall();
  
  draw_ball();
  
  draw_platform();
}






























void collide_floor() {
  if (p.y + r > plat_y) {
    p.y = plat_y - r;
    v.y = -v.y; 
  }  
}

void left_wall() {
  if (p.x - r < 0) {
    p.x = r;
    v.x = -v.x;  
  }
}

void right_wall() {
  if (p.x + r > width) {
    p.x = width - r;
    v.x = -v.x;
  }
}

void draw_platform() {
  stroke(0);
  fill(brown);
  rect(0, plat_y, width, 5);
}

void draw_ball() {
  stroke(0);
  fill(pink);
  ellipse(p.x, p.y, d, d);
}
