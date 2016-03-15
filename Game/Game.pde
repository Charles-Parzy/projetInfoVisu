float depthCamera = 2000;

//Needed object for the game
Plate plate;
Balle balle;
Mover mover;

void settings() {
  size(700, 700, P3D);
}
void setup() {
  noStroke();
  plate = new Plate(1000, 20, 1000);
  balle = new Balle(48);
  mover = new Mover(plate,balle);
}
void draw() {
  camera(width/2, height/2, depthCamera, 250, 250, 0, 0, 1, 0);
  directionalLight(50, 100, 125, 0, -1, 0);
  ambientLight(102, 102, 102);
  background(200);
  plate.display();
  mover.update();
  mover.checkEdges();
  mover.display();
}
void mouseWheel(MouseEvent event) {
  plate.mouseWheel(event);
}
void mouseDragged() {
  plate.mouseDragged();
}