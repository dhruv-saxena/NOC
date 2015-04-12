import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;

VerletPhysics2D physics;

Blanket blanket;
ArrayList<Lifter> lifters;
Lifter l1, l2;

float ground;
FireSystem fs;
float dropHeight;

void setup() {

  size(1024, 728);
  ground = height-50;
  dropHeight = random(50, ground-200);

  physics = new VerletPhysics2D();
  physics.addBehavior(new GravityBehavior(new Vec2D(0, 0.1)));
  physics.setWorldBounds(new Rect(0, 0, width, ground));
  physics.setDrag(0.01);
  blanket = new Blanket(new PVector(50, 50), 20, 20, 10.0, 0.1);
  blanket.create();
  l1 = new Lifter((float)mouseX-50, (float) mouseY);
  l2 = new Lifter((float)mouseX+50, (float) mouseY);
  lifters = new ArrayList<Lifter>();
  lifters.add(l1);
  lifters.add(l2);
  PImage img = loadImage("texture.png");
  fs = new FireSystem(0, new Vec2D(width/2, ground), img);
}

void draw() {
  background(#81c2b7);
  physics.update();

  everything();

  fs.update();
  if (blanket.extinguish(fs.origin))
    fs.extinguish = true;

  blanket.display();
  displayLifters();
}



void moveLiftersToFire() {
  Vec2D t1 = new Vec2D(fs.origin.x-100, dropHeight);
  Vec2D t2 = new Vec2D(fs.origin.x+100, dropHeight);

  l1.moveLifter(t1);
  l2.moveLifter(t2);
}

void moveLiftersToBlanket() {
  Vec2D t1 = new Vec2D(0, 0);
  Vec2D t2 = new Vec2D(0, 0);

  t1.set(blanket.particles[0][0]);
  t2.set(blanket.particles[0][blanket.numCols-1]);

  l1.moveLifter(t1);
  l2.moveLifter(t2);
}

void displayLifters() {
  for (Lifter l : lifters) {
    l.display();
  }
}

float blanketFromLifters() {  
  float d1 = blanket.particles[0][0].distanceTo(l1);
  float d2 = blanket.particles[0][blanket.numCols-1].distanceTo(l2);

  float d = max(d1, d2);
  return d;
}



void everything() {

  if (!blanket.drop)
    blanket.moveToLifters(lifters.get(0), lifters.get(1));



  if (!blanket.onFloor()) { // Blanket in air
    if (blanket.atopFire(fs.origin)) { //Blanket on top of fire, so drop it
      blanket.drop();
    } else //Blanket somewhere else, so take it to fire
    moveLiftersToFire();
  } else { //Blanket on ground
    if (blanket.drop==true) {  // in drop state, i.e not being lifted yet
      moveLiftersToBlanket();  // go towards blanket
    }
    if (blanketFromLifters()<10) { // almost reached
      blanket.drop = false; // get out of drop state, and lift
      moveLiftersToFire(); //take the blanket to fire again
    }
  }
}

