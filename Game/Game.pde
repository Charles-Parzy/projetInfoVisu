enum GameState {
  GAME, 
    PLACEMENT;
}
//Global variables
GameState currentState = GameState.GAME;

//Data Visualization
PGraphics dataBackground;
PGraphics topView;
PGraphics scoreboard;
PGraphics barChart;
HScrollbar hs;

float depthCamera = 2000;

//Needed object for the game
Plate plate;
Balle balle;
Mover mover;
Cylinder cylinder;

void settings() {
  size(700, 700, P3D);
}
void setup() {
  dataBackground = createGraphics(width, height/5, P2D);
  topView = createGraphics(height/5 - 20, height/5 - 20, P2D);
  scoreboard = createGraphics(height/5 - 40, height/5 - 20, P2D);
  barChart = createGraphics(width - topView.width - scoreboard.width - 50, height/5 - 40, P2D); 
  hs = new HScrollbar(topView.width + scoreboard.width + 40, height-25, 300, 15);
  plate = new Plate(800, 20, 800);
  balle = new Balle(40);
  mover = new Mover(plate, balle);
}

void draw() {
  directionalLight(50, 100, 125, 0, -1, 0);
  ambientLight(102, 102, 102);
  background(200);
  if (currentState.equals(GameState.GAME)) {
    pushMatrix();
    camera(width/2, height/2, depthCamera, 250, 250, 0, 0, 1, 0);
    plate.display();  
    mover.update();
    mover.checkEdges();
    mover.checkCylinderCollision();
    mover.display();
    popMatrix();
  } else {
    pushMatrix();
    camera(0, 0, depthCamera, 0, 0, 0, 0, 1, 0);
    plate.display();
    mover.display();
    popMatrix();
  }
  noLights();
  drawData();
  hs.update();
  hs.display();
}
void mouseWheel(MouseEvent event) {
  plate.mouseWheel(event);
}
void mouseDragged() {
  plate.mouseDragged();
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == SHIFT) {
      currentState = GameState.PLACEMENT;
    }
  }
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == SHIFT) {
      currentState = GameState.GAME;
    }
  }
}

void mouseClicked() {
  if (currentState.equals(GameState.PLACEMENT)) {
    plate.addCylinder();
  }
}