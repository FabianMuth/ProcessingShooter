class Enemy implements Cloneable {
  int xPos, yPos, xSize, ySize;
  int score;
  boolean alive;
  ScoreCounter sc;
  PImage image;

  public Enemy(ScoreCounter sc, int xPos, int yPos, int xSize, int ySize, int score) {
    this.sc = sc;
    this.xPos = xPos;
    this.yPos = yPos;
    this.xSize = xSize;
    this.ySize = ySize;
    this.score = score;
  }

  public Enemy(ScoreCounter sc) {
    this.sc = sc;
    reset();
  }

  void drawEnemy() {
    fill(255);
    noStroke();
    rect(xPos, yPos, xSize, ySize);
    move();
  }

  void move() {
    PVector rect = new PVector(xPos+xSize/2, yPos+ySize/2);
    PVector mouse = new PVector(mouseX, mouseY);
    if (rect.dist(mouse) <= 100) {
      xPos += 3;
    } else {
      xPos += 1;
    }
    if (xPos >= width) xPos = -xSize;
  }

  boolean click() {
    if (inHitbox()) {
      alive = false;
      return true;
    }
    return false;
  }

  boolean inHitbox() {
    //println("distance: " + (PVector.dist(new PVector(xPos, yPos), new PVector(mouseX,mouseY))));
    if (mouseX > xPos && mouseX < xPos+xSize && mouseY > yPos && mouseY < yPos+ySize) {
      return true;
    } else {
      return false;
    }
  }

  void death() {
    sc.addScore(score);
    reset();
  }

  void reset() {
    println("resetting");
    this.xPos = (int) random(xSize, width-xSize);
    this.yPos = (int) random(ySize, width-ySize);
    this.xSize = (int) random(20, 200);
    this.ySize = (int) random(20, 200);
    this.score = 100;
  }
}
