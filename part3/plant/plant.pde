void settings() {
  ;size(400, 800, P2D);
}
void setup() {
  background(255, 200, 100);
  noLoop();
}
void draw() {
  plant(15, 0.4, 0.8);
}
void leaf() {
  beginShape();
  vertex(100.0, -70.0);
  bezierVertex(90.0, -60.0, 40.0, -100.0, 0.0, 0.0);
  bezierVertex(0.0, 0.0, 100.0, 40.0, 100.0, -70.0);
  endShape();
}
void plant(int numLeaves, float minLeafScale, float maxLeafScale) {
  stroke(255); //donne la couleur blanche aux bordures
  line(width/2, 0, width/2, height); // the plant's stem
  noStroke(); //enlève les bordures
  int gap = height/numLeaves; // vertical spacing between leaves
  float angle = 0;
  for (int i=0; i<numLeaves; i++) {
    int x = width/2;
    int y = gap*i + (int)random(gap);
    float scale = random(minLeafScale, maxLeafScale);
    pushMatrix(); //Les matrices sont des matrices de transformation
    translate(x, y);
    rotate(angle);
    scale(scale); //modifie les dimensions des feuilles (certaines sont plus petites que d'autres)
    leaf();
    popMatrix();
    angle += PI; // alternate the side for each leaf
  }
}