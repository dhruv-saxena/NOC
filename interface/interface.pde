/*
This code was used by Dviid to take all the viruses and create a virus world.
CreatureBehavior is the interface created here, and it was implemented by everybody's virus.
Our virus behvior is called PerlinBehavior. 
An interface was created because he wanted to ensure that everyone was using these 4 functions.
So everyone wrote these 4 functions in their own way, and he was sure that everyone would have these 4 functions.
So he would not get an error when he cycled through those 4 functions.
*/


import teilchen.Physics;
import teilchen.util.CollisionManager;
import ciid2015.exquisitdatacorpse.*;
import oscP5.*;
import netP5.*;


final int CANVAS_WIDTH = 750;
final int CANVAS_HEIGHT = 750;

NetworkClient mClient; 
float mBackgroundColor;
Physics physics;
PImage petriDish;

CollisionManager collision;

CreatureBehavior colony;
Oscillator osc = new Oscillator(2, 4, 0.01);
ArrayList<Creature> creatures = new ArrayList<Creature>();

void setup() {  
  size(CANVAS_WIDTH, CANVAS_HEIGHT);
  background(23, 68, 250);
  frameRate(30);
  
  physics = new Physics();
  
  collision = new CollisionManager();
  collision.minimumDistance(25);
  
  colony = new PerlinBehavior(physics, collision);  
  
      mClient = new NetworkClient(this, "edc.local", "client");
petriDish = loadImage("petriDish.png");
  
}

void draw() {
  
  collision.createCollisionResolvers();
  collision.loop(1.0 / frameRate);

  physics.step(1.0 / frameRate);
 
  background(23, 68, 250);
  stroke(255);
  noFill();
  
  for(int i = 0; i < creatures.size(); i++) {
    Creature c = creatures.get(i);
    c.display();
    c.scale_to(osc.update());
  }
  
  collision.removeCollisionResolver();
  colony.update(1);
  
  imageMode(CORNER);
  image(petriDish,0,0);

}

void mousePressed() {
  /*
  for(int i =0; i<20; i++){
  
  Creature c = new TriangleCreature(mouseX+i*10, mouseY+i*10, 10);
  
  creatures.add(c);
  
  colony.add(c);
  }  
  */
  
}

 void keyPressed() {
  
  // Inform the colony of the KEY pressed
  colony.event('e');
  
}


/*
void receive(String name, String tag, float x)

{    
   if(x==101)
  colony.event('e');
  
}

*/

