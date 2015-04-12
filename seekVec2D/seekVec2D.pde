// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Two "vehicles" follow the mouse position

// Implements Craig Reynold's autonomous steering behaviors
// One vehicle "seeks"
// One vehicle "arrives"
// See: http://www.red3d.com/cwr/

/*
Dhruv
Seeking behavior implemented for Vec2D. 
See Vec2D documentation - http://toxiclibs.org/docs/core/toxi/geom/Vec2D.html
*/

Vehicle v;

import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;

void setup() {
  size(640, 360);
  v = new Vehicle(width/2, height/2);
}

void draw() {
  background(255);

  Vec2D mouse = new Vec2D(mouseX, mouseY);

  // Draw an ellipse at the mouse location
  fill(200);
  stroke(0);
  strokeWeight(2);
  ellipse(mouse.x, mouse.y, 48, 48);

  // Call the appropriate steering behaviors for our agents
  v.seek(mouse);
  v.update();
  v.display();
}

