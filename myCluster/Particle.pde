class Particle extends VerletParticle2D{
  
  Particle(Vec2D pos){
  super(pos);
  }
  
  void display(){
    ellipse(x,y,16,16);
  }
  
}
