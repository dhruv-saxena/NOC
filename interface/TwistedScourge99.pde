class TwistedScourge99 extends Creature {
  
  int px;
  int py;
  
  public TwistedScourge99(int x, int y, int r, int h ) {
    super(x, y, r);
    ellipseMode(RADIUS);
    px = r;
    py = h;
  }  
  
  public void draw_shape(){
   
    
     fill(255,0,0,30); 
     ellipse(0,0,px,py);
     rect(0,0,6,6);
     point(2,0);
     line(6,6,8,random(10));
     line(-4,-4,-14,-1);
     line(-4,-4,-1,-14);
     ellipse(-14,-1,1,1);
     ellipse(-1,-14,1,1);

    // line(-6,-6 , -2,-16);
   //fill(0);
     // line(-6,-6 , -40,-16);

     
    
    // ellipse(0,0, px, py); 
   // triangle(4.00,0.0,-2.0,3.0,-1.0,-3.0);
   //triangle(12.00,2.0,-2.0,3.0,-1.0,-5.0);
    // line(-12,-2, -16,-6);  
    // line(-12,-2, -8,-4);
    
   
    
   // line(8,8,12,12);
    
   // rect(5, 5, 12, 12); 
   // ellipse(10,10,1,1);
   // ellipse(13,13,1,1);
  //  line(5,-12,18,12);
    //line(0, 0, radius(), 0);
  }
  
 
  public boolean inside(int mx, int my) {    
    if(dist(mx, my, position().x, position().y) < radius()) return true;
    return false;
  }
  
};
