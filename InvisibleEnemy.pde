class InvisibleEnemy extends Enemy {
  PVector location;
  PVector velocity;
  int currentSize, maxSize, growthRate;
  float maxSpeed;
  boolean growing = false;

  float xoff = 0.0;
  float yoff = 4.0;

  public InvisibleEnemy(ScoreCounter sc) {
    super(sc);
    reset();
  }

  void drawEnemy() {
    fill(255, 0, 255, map(currentSize, maxSize, 0+maxSize*0.25, 255, 0));
    noStroke();

    if (growing) {
      if (currentSize < maxSize) currentSize+=growthRate;
      else growing = false;
    } else if (!growing) {
      if (currentSize > 1) currentSize-=growthRate;
      else growing = true;
    }
    move();
    circle(location.x, location.y, currentSize);
  }

  void move() {
    xoff = xoff + random(0.001, 0.015);
    yoff = yoff + random(0.001, 0.015);
    location.x = noise(xoff) * width;
    location.y = noise(yoff) * height;
  }

  boolean click() {
    if (inHitbox()) {
      alive = false;
      return true;
    }
    return false;
  }

  boolean inHitbox() {
    if (dist(location.x, location.y, mouseX, mouseY) <= currentSize/2) return true;
    else return false;
  }

  void death() {
    sc.addScore(score);
    reset();
  }

  void reset() {
    super.reset();
    this.maxSize = (int) random(50, 200);
    this.currentSize = maxSize;
    this.growthRate = (int) map(maxSize, 50, 200, 1, 3);
    this.score = 4000;
    this.maxSpeed = 1;
    location = new PVector(random(currentSize, width-currentSize), random(currentSize, height-currentSize));
    velocity = new PVector(random(-4, 4), random(-4, 4));
  }
}
