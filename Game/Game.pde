enum GameState {
  GAME, 
    PLACEMENT;
}
GameState currentState = GameState.GAME;

float depthCamera = 2000;

final int scaleConstant = 10;

//Surface for data visualisation 
PGraphics visualisationSurface;
PGraphics topView;
PGraphics scoreBoard;
PGraphics barChart;
//scrollbar
HScrollbar hs;

//Needed object for the game
Plate plate;
Balle balle;
Mover mover;
Cylinder cylinder;


void settings() {
  size(700, 700, P3D);
}
void setup() {
  noStroke();
  plate = new Plate(1000, 20, 1000);
  balle = new Balle(50);
  mover = new Mover(plate, balle);
  visualisationSurface = createGraphics(width, height/6, P2D);
  topView = createGraphics(int(plate.boxWidth/scaleConstant), int(plate.boxHeight/scaleConstant), P2D);
  scoreBoard = createGraphics(100 ,int(plate.boxHeight/scaleConstant), P2D);
  barChart = createGraphics(430, int(plate.boxHeight/scaleConstant)-20, P2D);
  hs = new HScrollbar(50, 90, 300, 20);
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
  noLights(); //Permet de colorier la surface d'une couleur différente de la balle.
  drawSurface();
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