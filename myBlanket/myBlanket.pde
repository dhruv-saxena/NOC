import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;

VerletPhysics2D physics;

Blanket blanket;

void setup(){

  size(640,800);
  
  physics = new VerletPhysics2D();
  physics.addBehavior(new GravityBehavior(new Vec2D(0,0.1)));
  physics.setWorldBounds(new Rect(0,0,width,height));
  blanket = new Blanket(new PVector(50,50),20,20,10.0,0.1);
  blanket.create();
}

void draw(){
  background(255);
  
  physics.update();
  blanket.display();
  
}
