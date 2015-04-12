class Particle extends VerletParticle2D{
  
  Particle(Vec2D loc){
  super(loc);
  physics.addParticle(this);
  }
  
}
