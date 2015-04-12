class Fire extends VerletParticle2D {
  Vec2D loc = new Vec2D(0,0);
  Vec2D vel;
  Vec2D acc;
  float lifespan;
  PImage img;

  Fire(Vec2D l, PImage img_) {
    super(l);
    acc = new Vec2D(0, 0);
    float vx = randomGaussian()*0.3;
    float vy = randomGaussian()*0.3 - 1.0;
    vel = new Vec2D(vx, vy);
    loc.set(l);
    lifespan = 100.0;
    img = img_;
  }

  void run() {
    update();
    render();
  }

  void applyForce(Vec2D f) {
    acc.addSelf(f);
  } 

  void update() {
    vel.addSelf(acc);
    loc.addSelf(vel);
    lifespan -= 2.5;
    acc.normalizeTo(0); // clear Acceleration
  }

  void render() {
    imageMode(CENTER);
    tint(255, lifespan);
    image(img, loc.x, loc.y);
    // Drawing a circle instead
    // fill(255,lifespan);
    // noStroke();
    // ellipse(loc.x,loc.y,img.width,img.height);
  }

  boolean isDead() {
    if (lifespan <= 0.0) {
      return true;
    } else {
      return false;
    }
  }
}



