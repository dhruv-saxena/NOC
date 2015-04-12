import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;

VerletPhysics2D physics;
Cluster cluster;

void setup() {
  size(800, 800);
  physics = new VerletPhysics2D();
  physics.setWorldBounds(new Rect(0, 0, width, height));
  //physics.addBehavior(new GravityBehavior(new Vec2D(0,0.5)));
  cluster = new Cluster(8, 100, 0.01);
  cluster.createParticles();
  cluster.createSprings();
}

void draw() {
  background(255);
  physics.update();
  cluster.display();
}

void keyPressed() {
  if (key == 'n') {
    physics.clear();
    cluster = new Cluster(int(random(2, 20)), random(10, width/2), 0.001);
    cluster.createParticles();
    cluster.createSprings();
  }
}

