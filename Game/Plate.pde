class Plate {
  float boxWidth;
  float boxThickness;
  float boxHeight;
  float angleY = 0;
  float angleX = 0;
  float angleZ = 0;
  float speedAngle = 0.1;

  Plate(float x, float y, float z ) {
    boxWidth = x;
    boxThickness = y;
    boxHeight = z;
  }

  void display() { 
    translate(width/2, height/2, 0);
    rotateX(angleX);
    rotateZ(angleZ);
    fill(240,109,109);
    box(boxWidth, boxThickness, boxHeight);
  }
  
  void mouseDragged() {
    if (pmouseY - mouseY > 0) {
      if (angleX < PI/3) { 
        angleX += speedAngle;
      } else {
        angleX = PI/3;
      }
    } else if (pmouseY - mouseY < 0) {
      if (angleX > -PI/3) {
        angleX -= speedAngle;
      } else {
        angleX = -PI/3;
      }
    } 
    if (pmouseX - mouseX < 0) {
      if (angleZ < PI/3) {
        angleZ += speedAngle;
      } else {
        angleZ = PI/3;
      }
    } else if (pmouseX - mouseX > 0) {
      if (angleZ > -PI/3) {
        angleZ -= speedAngle;
      } else {
        angleZ = -PI/3;
      }
    }
  }

  void mouseWheel(MouseEvent event) {
    float e = event.getCount();  
    float maxSpeed = 0.4;
    float minSpeed = 0.02;
    float speedChange = 0.02;
    if (e > 0) {
      speedAngle += speedChange;
      if (speedAngle > maxSpeed) {
        speedAngle = maxSpeed;
      }
    } else if (e < 0) {
      speedAngle -= speedChange;
      if (speedAngle < minSpeed) {
        speedAngle = minSpeed;
      }
    }
  }
}