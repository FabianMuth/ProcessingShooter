class SneakyEnemy extends Enemy {
  PVector location;
  PVector velocity;
  int size;
  float maxSpeed;

  public SneakyEnemy(ScoreCounter sc, int xPos, int yPos, int size, int score, float maxSpeed) {
    super(sc);
    location = new PVector(xPos, yPos);
    velocity = new PVector(random(-4, 4), random(-4, 4));
    this.size = size;
    this.xSize = size;
    this.ySize = size;
    this.score = score;
    this.maxSpeed = maxSpeed;
  }

  public SneakyEnemy(ScoreCounter sc) {
    super(sc);
    reset();
  }

  void drawEnemy() {
    move();
    fill(255);
    noStroke();
    ellipse(location.x, location.y, xSize, ySize);
    //println(location.x + ", " + location.y);
  }

  void move() {
    PVector mouseLocation = new PVector(mouseX, mouseY);
    PVector repulsionForce = PVector.sub(location, mouseLocation);

    float distanceFromMouse = repulsionForce.mag();

    if (distanceFromMouse < 200+size*2) {
      repulsionForce.normalize();
      repulsionForce.mult(map(distanceFromMouse, 0, 200+size*2, 2, 0));
      velocity.add(repulsionForce);
    }

    if (distanceFromMouse > 200+size*5) {
      repulsionForce.normalize();
      repulsionForce.mult(map(distanceFromMouse, width-size*2, 200+size*2, 2, 0));
      repulsionForce.mult(-1);
      velocity.add(repulsionForce);
    }

    if (location.x > width) location.x = 0;
    if (location.y > height) location.y = 0;
    if (location.x < 0) location.x = width;
    if (location.y < 0) location.y = height;

    velocity.limit(maxSpeed);
    //println(velocity);
    location.add(velocity);
  }

  boolean click() {
    if (inHitbox()) {
      alive = false;
      return true;
    }
    return false;
  }

  boolean inHitbox() {
    if (dist(location.x, location.y, mouseX, mouseY) <= size/2) return true;
    else return false;
  }

  void death() {
    sc.addScore(score);
    reset();
  }

  void reset() {
    super.reset();
    this.size = (int) random(20, 200);
    this.xSize = size;
    this.ySize = size;
    this.score = 2000;
    this.maxSpeed = 2;
    location = new PVector(random(size, width-size), random(size, height-size));
    velocity = new PVector(random(-4, 4), random(-4, 4));
  }
}
