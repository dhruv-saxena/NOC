import teilchen.Physics;
import teilchen.util.CollisionManager;
import teilchen.behavior.Arrival;

class PerlinBehavior implements CreatureBehavior {
  
  Vector3f attractor = new Vector3f(250,250,0);
  
  PVector location = new PVector(CANVAS_WIDTH/2, CANVAS_WIDTH/2);;
  PVector velocity = new PVector(); 
  PVector acceleration = new PVector();;
  PVector noff = new PVector(random(1000), random(1000));

  
  boolean attract = false;
  boolean start = true;
  int count = 0;
  
  ArrayList<Colon> _colons = new ArrayList<Colon>(); 
  Arrival _leader;
  CollisionManager _collision;
  
  Physics _physics;
  
  public PerlinBehavior(Physics p, CollisionManager c) {
    _colons = new ArrayList<Colon>();
    _leader = new Arrival();
    _leader.position().set(random(width), random(height));
    _physics = p;
    _collision = c;
  }
  
  public void add(Creature c) {
    
    _physics.add(c);
    _collision.collision().add(c);
    
    Colon colon = new Colon(c);
    if(_colons.size() >= 1) {
      colon.a.setPositionRef(_colons.get(_colons.size()-1).creature.position());
    } else if(_colons.isEmpty()) {
      colon.a.setPositionRef(_leader.position());
    }
    _colons.add(colon);
  }
  
  public void event(int x, int y) {
    _leader.position().set(x, y);    
  }
 
  public void event(int c) {
    
  if(c=='e'){
      attract = !attract;
      
      if(attract == true){
        attractor.x = random(150,width-150);
        attractor.y = random(150,height-150);
        if(_colons.isEmpty()) return;
       for(int i = 0; i< _colons.size(); i++){
       _colons.get(i).a.setPositionRef(attractor);
       }
      }
              
      }
      
    
    
    /*
    if(c == 'q') {
      _leader.position().set(random(width), random(height));
    } else if (c == 'x') {
      for(int i = 0; i < _colons.size(); i++) {
        _colons.get(i).unlink();
      }
    } else if (c == 'o') {
      if(_colons.isEmpty()) return;
      _colons.get(0).link();
      _colons.get(0).a.setPositionRef(_leader.position());
      for(int i = 1; i < _colons.size(); i++) {
        _colons.get(i).link();
        _colons.get(i).a.setPositionRef(_colons.get(i - 1).creature.position());
      }
    }
    */
    
    
  }
  
  public void update(float dt) {
  
  if(start){
  start = false;    
  for(int i =0; i<20; i++){
  //Creature c = new StarCreature(mouseX+i*10, mouseY+i*10, 3,3,4,15);
   Creature c = new TwistedScourge99(mouseX+i*10, mouseY+i*10, 5,5);
  creatures.add(c);
  colony.add(c);

  }
  }
    acceleration.x = map(noise(noff.x), 0, 1, -1, 1);
    acceleration.y = map(noise(noff.y), 0, 1, -1, 1);
    acceleration.mult(1.0);
    
    noff.add(0.01, 0.01, 0);

    velocity.add(acceleration);
    velocity.limit(10);
    location.add(velocity);
    
    location.x = constrain(location.x, 150, CANVAS_WIDTH-150);
    location.y = constrain(location.y, 150, CANVAS_HEIGHT-150);
    _leader.position().set(location.x, location.y);
    
    if(attract){
    ellipse(attractor.x,attractor.y,random(10,20),random(10,20));
    }
    
    if(attract && (frameCount-count)%210==0){
      
        attract = !attract;
        if(_colons.isEmpty()) return;
        _colons.get(0).a.setPositionRef(_leader.position());
          for(int i = 1; i< _colons.size(); i++){
          _colons.get(i).a.setPositionRef(_colons.get(i - 1).creature.position());
          
          
          }
          
          
    }
   
    
}  
     
  class Colon {    
    Creature creature;
    Arrival a;    
    public Colon(Creature colon) {
      creature = colon;
      a = new Arrival();
      a.breakforce(creature.radius() * 5);
      a.breakradius(creature.radius() * 5);      
      creature.behaviors().add(a);      
    }   

    public void unlink() {
      creature.behaviors().remove(0);
    }
    
    public void link() {
      creature.behaviors().add(a);
    }
      
  }
  
}
