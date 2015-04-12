/*Add and Remove behaviors on objects of VerletParticle2D
http://toxiclibs.org/docs/verletphysics/toxi/physics2d/VerletParticle2D.html#addBehavior(toxi.physics2d.behaviors.ParticleBehavior2D)
a - add gravity
r - remove gravity
*/

import toxi.geom.*;
import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;

ArrayList<Particle> particles;
Attractor attractor;

VerletPhysics2D physics;
GravityBehavior gravity = new GravityBehavior(new Vec2D(0, 0.1));
ConstantForceBehavior f = new ConstantForceBehavior(new Vec2D(0.1, 0));


void setup () {
  size (640, 360);
  physics = new VerletPhysics2D ();
  physics.setWorldBounds(new Rect(0,0,width,height));
  physics.setDrag (0.01);

  particles = new ArrayList<Particle>();
  for (int i = 0; i < 50; i++) {
    particles.add(new Particle(new Vec2D(random(width), random(height))));
  }

  attractor = new Attractor(new Vec2D(width/2, height/2));
}


void draw () {
  background (255);  
  physics.update ();

  attractor.display();
  for (Particle p : particles) {
    p.display();
  }

  if (mousePressed) {
    attractor.lock();
    attractor.set(mouseX, mouseY);
  } else {
    attractor.unlock();
  }
}

void keyPressed() {
  if (key=='a') {
    for (Particle p : particles) {
      //p.addBehavior(gravity);
      p.addBehavior(f);

    }
  } else if (key=='r') {
    for (Particle p : particles) {
      //p.removeBehavior(gravity);
      p.removeBehavior(f);
    }
  }
}


