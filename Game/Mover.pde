class Mover {
  final float normalForce = 1;
  final float mu = 0.1;
  final float frictionMagnitude = normalForce * mu;
  final float gravityConstant = 1;
  PVector location;
  PVector velocity;
  PVector gravity;
  PVector friction;
  Plate plate;
  Balle balle;
  
  Mover(Plate plate, Balle balle) {
    location = new PVector(0, -plate.boxThickness/2 - balle.radius, 0);
    velocity = new PVector(0, 0, 0);
    gravity = new PVector(gravityConstant, 0, gravityConstant);
    friction = new PVector(0,0,0);
    this.plate = plate;
    this.balle = balle;
  }
  void update() {
    friction = velocity.copy();
    friction.mult(-1);
    friction.normalize();
    friction.mult(frictionMagnitude);
    gravity.x = sin(plate.angleZ) * gravityConstant;
    gravity.z = -sin(plate.angleX) * gravityConstant;
    velocity.add(gravity);
    velocity.add(friction);
    location.add(velocity);
  }
  void display() {
    pushMatrix();
    translate(location.x,location.y,location.z);
    balle.drawBalle();
    popMatrix();
  }
  void checkEdges() {
    if (location.x >= plate.boxWidth/2 || location.x <= - plate.boxWidth/2) { //<>//
      if(location.x > plate.boxWidth/2) {
         location.x = plate.boxWidth/2; 
      }
      if(location.x < - plate.boxWidth/2) {
         location.x = - plate.boxWidth/2; 
      }
      velocity.x *= -0.7;
    } 
    
    if (location.z >= plate.boxHeight/2 || location.z <= -plate.boxHeight/2) {
     if(location.z > plate.boxHeight/2) {
        location.z = plate.boxHeight/2; 
     }
     if(location.z < -plate.boxHeight/2) {
        location.z = -plate.boxHeight/2; 
     }
      velocity.z *= -0.7;
    }
  }
}