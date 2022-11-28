import java.util.List; //<>//

class EnemyManager {
  private int enemyCount = 2;
  private ArrayList<Enemy> enemies = new ArrayList<>();
  private ArrayList<Enemy> activeEnemies = new ArrayList<>();
  private ScoreCounter sc;
  private Gun gun;

  public EnemyManager(ScoreCounter sc, Gun gun) {
    enemies.add(new Enemy(sc));
    enemies.add(new SneakyEnemy(sc));
    enemies.add(new InvisibleEnemy(sc));
    this.sc = sc;
    this.gun = gun;
  }

  void manageEnemies() {
    if (activeEnemies.size() < enemyCount) spawnRandom();
    drawEnemies();
  }

  void drawEnemies() {
    for (Enemy e : activeEnemies) {
      e.drawEnemy();
    }
  }

  void mousePressed() {
    if (mouseButton == LEFT) {
      for (int i = 0; i <= activeEnemies.size()-1; i++) {
        Enemy e = activeEnemies.get(i);
        if (e.click() && gun.getBulletCount() != 0) {
          //println("In Hitbox: " + e.inHitbox());
          e.death();
          //println("active: " + activeEnemies);
          //println("pass: " + enemies+"\n");
          enemies.add(e);
          //println("pass: " + enemies);
          //println("active: " + activeEnemies);

          activeEnemies.remove(i);
          //println("active: " + activeEnemies);
        }
      }
    }
  }

  void spawnRandom() {
    println("spawn new");
    //println("pass: " + enemies);
    //println("active: " + activeEnemies);
    int rand = (int) random(enemies.size());
    activeEnemies.add(enemies.get(rand));
    enemies.remove(rand);
  }
}
