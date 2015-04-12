import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;

VerletPhysics2D physics;

float springLength = 1;
float springStrength = 0.01;

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

  if (!blanket.drop)
    blanket.moveToLifters(lifters.get(0), lifters.get(1));
  blanket.display();

  everything();

  /*
  if (mousePressed)
   blanket.drop();
   
   moveLifters();
   */

  fs.update();
  if (blanket.extinguish(fs.origin)<10 && fs.extinguish==false)
    fs.extinguish = true;
    
    displayLifters();
}

void moveLifters() {
  Vec2D mouse = new Vec2D(mouseX, mouseY);
  for (int i =0; i< lifters.size (); i++) {
    Lifter l = lifters.get(i);
    l.arrive(mouse.addSelf((float)i*200, 0));
    l.update();
    l.display();
  }
}

void moveLifter(Lifter l, Vec2D t ) {

  l.arrive(t);
  l.update();
  l.display();
}

void moveLiftersToFire() {
  Vec2D t1 = new Vec2D(fs.origin.x-100, dropHeight);
  Vec2D t2 = new Vec2D(fs.origin.x+100, dropHeight);

  moveLifter(l1, t1);
  moveLifter(l2, t2);
}

void moveLiftersToBlanket() {
  Vec2D t1 = new Vec2D(0, 0);
  Vec2D t2 = new Vec2D(0, 0);

  t1.set(blanket.particles[0][0]);
  t2.set(blanket.particles[0][blanket.numCols-1]);

  moveLifter(l1, t1);
  moveLifter(l2, t2);
}

void displayLifters() {
  for (Lifter l : lifters) {
    l.display();
  }
}

float blanketFromLifters(){  
float d1 = blanket.particles[0][0].distanceTo(l1);
float d2 = blanket.particles[0][blanket.numCols-1].distanceTo(l2);

float d = max(d1,d2);
return d;
}

 

void everything() {
  if (!blanket.onFloor()) {
    if (blanket.atopFire(fs.origin)) {
      blanket.drop();
    } else
      moveLiftersToFire();
  } 
  
  else {
    if(blanket.drop==true){
   moveLiftersToBlanket();
    }
   if (blanketFromLifters()<10){
   blanket.drop = false;
   moveLiftersToFire();
   }
   }
   
}

