class FireSystem {

  boolean kill = false;
  ArrayList<Fire> fireParticles;    // An arraylist for all the particles
  Vec2D origin = new Vec2D(0, 0);        // An origin point for where particles are birthed
  PImage img;

  FireSystem(int num, Vec2D v, PImage img_) {
    fireParticles = new ArrayList<Fire>();              // Initialize the arraylist
    origin.set(v);                        // Store the origin point
    img = img_;
    for (int i = 0; i < num; i++) {
      fireParticles.add(new Fire(origin, img));    // Add "num" amount of particles to the arraylist
    }
  }

  void run() {
    for (int i = fireParticles.size ()-1; i >= 0; i--) {
      Fire f = fireParticles.get(i);
      f.run();
      if (f.isDead()) {
        fireParticles.remove(i);
      }
    }
  }

  void applyForce(Vec2D dir) {
    // Enhanced loop!!!
    for (Fire f : fireParticles) {
      f.applyForce(dir);
    }
  }  

  void addParticle() {
    fireParticles.add(new Fire(origin, img));
  }

  void update() {
    Vec2D wind = new Vec2D(0, -0.1);
    fs.applyForce(wind);
    fs.run();
    if (!kill) {
      for (int i = 0; i < 2; i++) {
        fs.addParticle();
      }
    } else if (fireParticles.size()==0)
      kill = false;
  }
}

