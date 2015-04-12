class Prey extends VerletParticle2D {

  float r;

  Prey (Vec2D loc) {
    super (loc);
    r = 24;
    physics.addParticle(this);
    physics.addBehavior(new AttractionBehavior(this, width, 0.00));
  }

  void display () {
    fill(220);
    ellipse (x, y, r*2, r*2);
    fill(255);
  }
}
