float depth = 2000;
float angleX = 0;
float angleZ = 0;
float speedAngle = 0.1;

void settings() {
  size(500, 500, P3D);
}
  
void setup() {
  noStroke();
}

void mouseDragged() {
  if(pmouseY - mouseY > 0) {
    if(angleX < PI/3) { 
      angleX += speedAngle;
    } else {
      angleX = PI/3;
    }
  } else if(pmouseY - mouseY < 0){
    if(angleX > -PI/3) {
      angleX -= speedAngle;
    } else {
      angleX = -PI/3;
    }
  } 
  if(pmouseX - mouseX < 0) {
    if(angleZ < PI/3) {
    angleZ += speedAngle;
    } else {
      angleZ = PI/3;
    }
  } else if(pmouseX - mouseX > 0){
    if(angleZ > -PI/3) {
     angleZ -= speedAngle; 
    } else {
     angleZ = -PI/3; 
    }
  }
}

void mouseWheel(MouseEvent event) {
  float temp;
  float minSpeed = 0.02;
  float maxSpeed = 0.4;
  float increment = 0.02;
  if(event.getAmount() > 0) {
    temp = speedAngle + increment;
    if(temp < maxSpeed) {
     speedAngle = temp;
    } else {
     speedAngle = maxSpeed; 
    }
  } else {
     temp = speedAngle - increment;
     if(temp > minSpeed) {
       speedAngle = temp;
     } else {
       speedAngle = minSpeed; 
     }
  }
}

void draw() {
  camera(width/2, height/2, depth, 250, 250, 0, 0, 1, 0);
  directionalLight(50, 100, 125, 0, -1, 0);
  ambientLight(102, 102, 102);
  background(200);
  pushMatrix();
  translate(width/2, height/2, 0); //On centre la plaque
  rotateX(angleX);
  rotateZ(angleZ);
  box(500, 50, 500);
  popMatrix();
}