import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;

VerletPhysics2D physics;

float springLength = 1;
float springStrength = 0.01;

Blanket blanket;
ArrayList<Lifter> lifters;
Lifter l1, l2;

Prey prey;
float ground;
FireSystem fs;

void setup() {

  size(640, 800);
  ground = height-50;
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
  //springLifterBlanket();
  PImage img = loadImage("texture.png");
  fs = new FireSystem(0, new Vec2D(width/2, ground), img);

  prey = new Prey(new Vec2D(width/2, height/2));
}

void draw() {


  background(#81c2b7);

  physics.update();

 // prey.display();

  if (!blanket.drop)
    blanket.moveToLifters(lifters.get(0), lifters.get(1));
  else
    blanket.display();

  if (mousePressed)
    blanket.drop();

  moveLifters();
  fs.update();

  if (blanket.extinguish(fs.origin)<10 && fs.extinguish==false)
    fs.extinguish = true;
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

void springLifterBlanket() {

  Connection  c1 = new Connection(lifters.get(0), blanket.particles[0][0], springLength, springStrength);
  Connection  c2 = new Connection(lifters.get(1), blanket.particles[blanket.numCols-1][0], springLength, springStrength);
  physics.addSpring(c1);
  physics.addSpring(c2);
}

