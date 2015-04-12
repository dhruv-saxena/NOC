class Blanket {

  PVector location;
  int numRows;
  int numCols;
  float gridSize;
  float springLength;
  float springStrength;
  boolean drop = false;

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
    //    particles[numRows/2-1][0].lock();
    //    particles[numRows/2-1][numCols-1].lock();

    //    particles[0][0].lock();
    //    particles[0][numCols-1].lock();
  }

  void drop() {

    drop = !drop;
    //particles[0][0].unlock();
    //particles[0][numCols-1].unlock();
    /*
      for(int i = 5; i<numCols-5;i++){
     particles[numRows/2-1][i].lock();
     }
     */
    /*
      int j = 3;
     for(int i= numRows/2; i<numRows/2+6;i++){
     
     particles[i][numCols/2+j].lock();
     particles[i][numCols/2-j].lock();
     j++;
     }
     
     */
  }

  void move(int x, int y) {
    pushMatrix();
    translate(x, y);
    display();
    popMatrix();
  }

  void moveToLifters(Vec2D v1, Vec2D v2) {
    particles[0][0].set(v1);
    particles[0][numCols-1].set(v2);
    display();
  }


  void display() {

    // displa the solid blanket
    for (int i=0; i<numRows-1; i++) {
      for (int j=0; j<numCols-1; j++) {
        beginShape();
        stroke(255);
        vertex(particles[i][j].x, particles[i][j].y);
        vertex(particles[i][j+1].x, particles[i][j+1].y);
        vertex(particles[i+1][j+1].x, particles[i+1][j+1].y);
        vertex(particles[i+1][j].x, particles[i+1][j].y);
        endShape(CLOSE);
      }
    }


    //Display all springs
    for (Connection c : connections) {
      c.display();
    }
  }

// Function which returns the min distance from a Vec2D fire
  float extinguish(Vec2D fire) {
    float min = 10000.0;
    for (int i=0; i<numRows; i++) {
      for (int j=0; j<numCols; j++) {
        float d = particles[i][j].distanceTo(fire);
        if (d<min)
          min = d;
      }
    }
    return min;
  }
}

