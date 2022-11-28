static String version = "1.2";
ScoreCounter sc;
EnemyManager enemyManager;
ArrayList<Enemy> enemies = new ArrayList<>();
Gun gun;
MouseTrail mTrail;
Galaxy galaxy;
Terrain3D terrain;

void settings() {
  //size(800, 800, P3D);
  fullScreen(P3D);
}

void setup() {
  surface.setTitle("Ballerspiel - Fabian Muth [mt221092] - V" + version);
  surface.setResizable(true);
  frameRate(100);
  //noCursor();

  sc = new ScoreCounter(width-60, 10);
  gun = new Gun(20);
  enemyManager = new EnemyManager(sc, gun);
  mTrail = new MouseTrail();
  galaxy = new Galaxy(1, 1);
  terrain = new Terrain3D(20, 0.002);
}

void draw() {
  background(0);
  
  camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);
  
  galaxy.drawGalaxy();
  terrain.drawTerrain();
  mTrail.drawTrail();
  enemyManager.manageEnemies();
  sc.drawScore();
  gun.draw();
}

void mousePressed() {
  if (mouseButton == LEFT) {
    gun.mousePressed();
    enemyManager.mousePressed();
  }
}

void keyPressed() {
  gun.keyPressed();
}
