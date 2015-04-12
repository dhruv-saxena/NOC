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

  }

  void drop() {
    drop = true;
  }



  void moveToLifters(Vec2D v1, Vec2D v2) {
    particles[0][0].set(v1);
    particles[0][numCols-1].set(v2);
  }


  void display() {

    // display the solid blanket
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
  boolean extinguish(Vec2D fire) {
    float min = 10000.0;
    for (int i=0; i<numRows; i++) {
      for (int j=0; j<numCols; j++) {
        float d = particles[i][j].distanceTo(fire);
        if (d<min)
          min = d;
      }
    }
    if(min<10)
    return true;
    else
    return false;
  }

  boolean onFloor() {
    boolean state = false;
    for (int i=0; i<numRows; i++) {
      for (int j=0; j<numCols; j++) {
        float d = abs(ground - particles[i][j].y);
        if (d<1)
          state = true;
        else
          state = false;
      }
    }
    return state;
  }

  boolean atopFire(Vec2D fire) {
    boolean state = false;
    outerloop:
    for (int i=0; i<numRows; i++) {
      for (int j=3; j<numCols-3; j++) {
        float d = abs(fire.x - particles[i][j].x);
        if (d<1){
          state = true;
          break outerloop;
        }
      }
    }
    return state;
  }
}

