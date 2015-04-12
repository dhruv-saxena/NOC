import toxi.geom.*;
import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;

FireSystem fs;

void setup() {
  size(640, 360);
  PImage img = loadImage("texture.png");
  fs = new FireSystem(0, new Vec2D(width/2, height-75), img);
}

void draw() {
  background(0);
  fs.update();
  
}

void keyPressed(){
fs.kill = true;
}



