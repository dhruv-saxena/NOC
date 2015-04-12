import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;

VerletPhysics2D physics;

void setup() {
  size(640, 360);
  // Initialize the physics world
  physics=new VerletPhysics2D();
  physics.setWorldBounds(new Rect(0, 0, width, height));
}

void draw() {
  background(255);
  // Update physics
  physics.update();
  
  
}
