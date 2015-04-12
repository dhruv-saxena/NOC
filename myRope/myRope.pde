import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;

VerletPhysics2D physics;

Rope rope;

void setup(){
  size(640,320);
  physics = new VerletPhysics2D();
  physics.setWorldBounds(new Rect(0,0,width,height));
  physics.addBehavior(new GravityBehavior(new Vec2D(0,0.5)));
  rope = new Rope(new Vec2D(width/2,50), 10);
}

void draw(){
  background(255);
  physics.update();
  rope.display();
  rope.update();
  
}



