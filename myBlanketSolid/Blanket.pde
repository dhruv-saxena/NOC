class Blanket {

  PVector location;
  int numRows;
  int numCols;
  float gridSize;
  float springLength;
  float springStrength;

  Particle[][] particles;
  ArrayList<Connection> connections;

  Blanket(PVector loc, int rows, int cols, float grid, float strength) {
    location = loc;
    numRows = rows;    
    numCols = cols;
    gridSize = grid;
    springLength = gridSize;
    springStrength = strength;
    particles = new Particle[numRows][numCols];
    connections = new ArrayList<Connection>();
  }

  void create() {

    //Add particles to array
    for (int i=0; i<numRows; i++) {
      for (int j=0; j<numCols; j++) {
        Particle p = new Particle(location.x + j*gridSize, location.y + i*gridSize);
        particles[i][j] = p;
        physics.addParticle(p);
      }
    }

    //Add horizontal springs
    for (int i=0; i<numRows; i++) {
      for (int j=0; j<numCols-1; j++) {
        Particle p1 = particles[i][j];
        Particle p2 = particles[i][j+1];

        Connection  c = new Connection(p1, p2, springLength, springStrength);
        physics.addSpring(c);
        connections.add(c);
      }
    }

    //Add vertical springs
    for (int j=0; j<numCols; j++) {
      for (int i=0; i<numRows-1; i++) {
        Particle p1 = particles[i][j];
        Particle p2 = particles[i+1][j];

        Connection  c = new Connection(p1, p2, springLength, springStrength);
        physics.addSpring(c);
        connections.add(c);
      }
    }

    //Decide the Hinges
    particles[numRows/2-1][0].lock();
    particles[numRows/2-1][numCols-1].lock();
  }

  void display() {

    for (int i=0; i<numRows-1; i++) {
      for (int j=0; j<numCols-1; j++) {
        fill(0);
        beginShape();
        vertex(particles[i][j].x, particles[i][j].y);
        vertex(particles[i][j+1].x, particles[i][j+1].y);
        vertex(particles[i+1][j+1].x, particles[i+1][j+1].y);
        vertex(particles[i+1][j].x, particles[i+1][j].y);
        endShape(CLOSE);
      }
    }
    
    /*
    //Display all springs
     for (Connection c : connections) {
     c.display();
     }
     */
  }
}


