class Gun {
  private int magSize, bulletCount, reloadTime;
  private int gunStartX, gunStartY, gunLength;
  private float reloadStart = 0;
  private boolean reloading = false;

  public Gun() {
    magSize = 10;
    bulletCount = magSize;
    reloadTime = 2000;

    gunStartX = width/2;
    gunStartY = height+40;
    gunLength =  150;
  }

  public Gun(int magSize) {
    this();
    this.magSize = magSize;
    bulletCount = magSize;
  }

  void draw() {
    if (reloading) {
      reload();
      printToScreen("Reloading...");
    }
    if (getBulletCount() <= 0 && !reloading) printToScreen("No bullets left, press R to reload");
    drawGun();
    drawGunUI();
  }

  void drawGun() {
    float dx = mouseX - gunStartX;
    float dy = mouseY - gunStartY;
    float angle = atan2(dy, dx);

    // calculate the end point
    float newX = gunStartX + cos(angle) * gunLength;
    float newY = gunStartY + sin(angle) * gunLength;

    //muzzleFlash
    fill(#F0FF0F);
    stroke(#FF0000);
    strokeWeight(2);
    if (mousePressed && mouseButton == LEFT && bulletCount >= 1) circle(newX, newY, 30);

    //gun
    stroke(#40525F);
    strokeWeight(50);
    strokeCap(SQUARE);
    line(gunStartX, gunStartY, newX, newY);
  }

  void drawGunUI() {
    noStroke();
    if (bulletCount >= round(magSize * 0.3)) {
      fill(color(255));
    } else {
      fill(#FF0000);
    }
    rect(width-60, height-20, map(bulletCount, magSize, 0, 50, 2), 10);
  }

  void printToScreen(String text) {
    textAlign(CENTER);
    textSize(25);
    fill(0);
    text(text, width/2, height-height/6);
    fill(255);
    text(text, width/2-1, height-height/6-1);
  }

  void mousePressed() {
    if (mouseButton == LEFT) {
      if (bulletCount >= 1) {
        println("shot");
        bulletCount--;
      } else {
        println("No bullets left, press R to reload");
      }
    }
  }

  void keyPressed() {
    if (keyPressed && key == 'r') {
      reloadStart = millis();
      reloading = true;
      println("Reloading...");
    }
  }

  void reload() {
    if (reloadStart + reloadTime <= millis()) {
      bulletCount = magSize;
      reloading = false;
      println("Reloaded!");
    }
  }

  int getBulletCount() {
    return this.bulletCount;
  }
}
