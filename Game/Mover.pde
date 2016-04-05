PVector location;
float ELASTICITYCONSTANT = 0.7;

class Mover {
  final float normalForce = 1;
  final float mu = 0.2;
  final float frictionMagnitude = normalForce * mu;
  final float gravityConstant = 1;
  PVector velocity;
  PVector gravity;
  PVector friction;
  Plate plate;
  Balle balle;

  Mover(Plate plate, Balle balle) {
    location = new PVector(0, -plate.boxThickness/2 - balle.radius, 0);
    velocity = new PVector(0, 0, 0);
    gravity = new PVector(gravityConstant, 0, gravityConstant);
    friction = new PVector(0, 0, 0);
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
    if (currentState.equals(GameState.GAME)) {
      translate(location.x, location.y, location.z);
      balle.drawBalle();
    } else {
      fill(0, 255, 0);
      ellipse(location.x, location.z, balle.radius+40, balle.radius+40); // pourquoi utiliser ellipse.
    }
  }
  void checkEdges() {
    if (location.x >= plate.boxWidth/2 || location.x <= - plate.boxWidth/2) {
      if (location.x > plate.boxWidth/2) {
        location.x = plate.boxWidth/2;
      }
      if (location.x < - plate.boxWidth/2) {
        location.x = - plate.boxWidth/2;
      }
      velocity.x *= -ELASTICITYCONSTANT;
    } 

    if (location.z >= plate.boxHeight/2 || location.z <= -plate.boxHeight/2) {
      if (location.z > plate.boxHeight/2) {
        location.z = plate.boxHeight/2;
      }
      if (location.z < -plate.boxHeight/2) {
        location.z = -plate.boxHeight/2;
      }
      velocity.z *= -ELASTICITYCONSTANT;
    }
  }

  void checkCylinderCollision() {
    for (PVector c : plate.cylinders) {
      PVector distance = new PVector(c.x - location.x, c.y - location.z);

      if (distance.mag() < balle.radius + cylinderBaseSize/2) { 
        PVector tempVelocity = new PVector(velocity.x, velocity.z);
        location.sub(velocity.x, 0, velocity.z);    
        PVector n = new PVector(location.x - c.x, location.z - c.y).normalize();
        n = n.mult(2*PVector.dot(tempVelocity, n));
        PVector V2 = PVector.sub(tempVelocity, n);
        velocity = new PVector(V2.x, velocity.y, V2.y);
        location.add(velocity.mult(ELASTICITYCONSTANT));
      }
    }
  }
}