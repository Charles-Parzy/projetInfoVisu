void settings() {
  size(200, 200, P2D);
}
void setup() {
  background(255, 200, 100);
}

void draw() {
  noFill(); //a Processing built-in function to avoid filling the shape
  beginShape();
  for (int i=0; i<20; i++) {
    int y = i%2;
    vertex(i*10, 50+y*10);
  }
  endShape();
}