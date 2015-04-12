class Lifter extends VerletParticle2D {

  //Vec2D location;
  Vec2D velocity;
  Vec2D acceleration;
  float r;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed

    Lifter(float x1, float y1) {
    super(x1, y1); 
    acceleration = new Vec2D(0, 0);
    velocity = new Vec2D(0, -2);
    //    this.x = x1;
    //    this.y = y1;
    r = 6;
    maxspeed = 5;
    maxforce = 0.1;
  }

  // Method to update location
  void update() {
    // Update velocity
    velocity.addSelf(acceleration);
    // Limit speed
    velocity.limit(maxspeed);
    this.addSelf(velocity);
    // Reset acceleration to 0 each cycle
    acceleration.normalizeTo(0);
  }

  void applyForce(Vec2D force) {
    // We could add mass here if we want A = F / M
    acceleration.addSelf(force);
  }

  // A method that calculates a steering force towards a target
  // STEER = DESIRED MINUS VELOCITY
  void arrive(Vec2D target) {
    Vec2D desired = target.sub(this);  // A vector pointing from the location to the target

    float d = desired.magnitude();
    // Scale with arbitrary damping within 100 pixels
    if (d < 100) {
      float m = map(d, 0, 100, 0, maxspeed);
      desired.normalizeTo(m);
    } else {
      desired.normalizeTo(maxspeed);
    }



    // Steering = Desired minus velocity
    Vec2D steer = desired.sub(velocity);
    steer.limit(maxforce);  // Limit to maximum steering force

      applyForce(steer);
  }

  void display() {

    ellipse(this.x, this.y, 16, 16);
  }
  
  void moveLifter(Vec2D t ) {
  arrive(t);
  update();
}
}

