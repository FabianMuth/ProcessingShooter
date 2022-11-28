class MouseTrail {
  ArrayList<Float> x = new ArrayList<Float>();
  ArrayList<Float> y = new ArrayList<Float>();
  ArrayList<Float> age = new ArrayList<Float>();
  int n = 10, mweight = 5;

  void drawTrail() {
    stroke(255, 0, 0, 50);
    fill(255, 0, 0);
    x.add((float)mouseX);
    y.add((float)mouseY);
    age.add((float)0);
    for (int i = 0; i < x.size()-1; i++) {
      stroke(255, 0, 0, map(n-age.get(i), 0, n, 0, 255));
      strokeWeight(map(n-age.get(i), 0, n, 1, mweight));
      line(x.get(i), y.get(i), x.get(i+1), y.get(i+1));

      

      age.set(i, age.get(i)+1);
      if (age.get(i) > n) {
        age.remove(i);
        x.remove(i);
        y.remove(i);
      }
    }
    ellipse(mouseX, mouseY, 5, 5);
  }
}
