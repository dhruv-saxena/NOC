class Cluster {

  int numParticles;
  ArrayList<Connection> connections;
  ArrayList<Particle> particles;
  float springLength;
  float springStrength; 
  Vec2D center = new Vec2D(width/2,height/2);

  Cluster(int num, float len, float strength) {
    numParticles = num;
    springLength = len;
    springStrength = strength;
    particles = new ArrayList<Particle>();
    connections = new ArrayList<Connection>();
  }

  void createParticles() {
    for (int i=0; i<numParticles; i++) {
      Particle p1 = new Particle(center.add(Vec2D.randomVector()));
      particles.add(p1);
      physics.addParticle(p1);
    }
  }

  void createSprings() {

    for (int i=0; i< particles.size ()-1; i++) {
      for (int j=i+1; j< particles.size (); j++) {

        Particle p1 = particles.get(i);
        Particle p2 = particles.get(j);

        Connection c = new Connection(p1, p2, springLength, springStrength);
        connections.add(c);
        physics.addSpring(c);
      }
    }
  }

  void display() {
    for (Particle p : particles) {
      p.display();
    }

    for (Connection c : connections) {
      c.display();
    }
  }
}



