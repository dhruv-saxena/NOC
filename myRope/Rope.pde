class Rope {

  float len = 10;
  float springLen = 10;
  float strength = 0.2;

  ArrayList<Particle> particles;

  Rope(Vec2D loc, int numOfParticles) {
    particles = new ArrayList<Particle>();

    for (int i=0; i< numOfParticles; i++) {
      Particle p = new Particle(loc.addSelf(0.0f, len));
      particles.add(p);
    }
    particles.get(0).lock();

    for (int i=0; i< particles.size ()-1; i++) {
      Particle p1 = particles.get(i);
      Particle p2 = particles.get(i+1);
      
      VerletSpring2D spring = new VerletSpring2D(p1,p2,springLen,strength);
      physics.addSpring(spring);
      
    }
  }

  void display() {
    for (int i=0; i< particles.size ()-1; i++) {
      Particle p1 = particles.get(i);
      Particle p2 = particles.get(i+1);
      line(p1.x, p1.y, p2.x, p2.y);
    }
    Particle p = particles.get(particles.size()-1); 
    ellipse(p.x, p.y, 16, 16);
  }

  void update() {
    Particle p = particles.get(particles.size()-1);
    if (mousePressed) {
      p.lock();
      p.x = mouseX;
      p.y = mouseY;
      p.unlock();
    }
  }
}

