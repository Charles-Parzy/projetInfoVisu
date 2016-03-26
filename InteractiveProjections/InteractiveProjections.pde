float scaleValue = 2f;
float xRotationValue = PI/8;
float yRotationValue = 0;
void settings() {
  size (700, 700, P2D);
}
void setup() {
  frameRate(30);
}
void draw() {
  background(255, 255, 255);
  stroke(255,0,0);
  My3DPoint eye = new My3DPoint(0, 0, -5000);
  My3DPoint origin = new My3DPoint(0, 0, 0);
  My3DBox input3DBox = new My3DBox(origin, 100, 150, 200);
  //rotated around x and y
  float[][] transform1 = rotateXMatrix(xRotationValue);
  float[][] transform4 = rotateYMatrix(yRotationValue);
  input3DBox = transformBox(input3DBox, transform1);
  input3DBox = transformBox(input3DBox, transform4);
  //rotated and translated
  float[][] transform2 = translationMatrix(100, 100, 0);
  input3DBox = transformBox(input3DBox, transform2);
  //rotated, translated, and scaled
  float[][] transform3 = scaleMatrix(scaleValue, scaleValue, scaleValue);
  input3DBox = transformBox(input3DBox, transform3);
  projectBox(eye, input3DBox).render();
  keyPressed();
}

void mouseDragged() {
  if(pmouseY-mouseY < 0){
    scaleValue -= 0.1;
  }else{
    scaleValue += 0.1;
  }
}

void keyPressed(){
  if(keyPressed) {
  if (key == CODED) {
    if (keyCode == UP){
        xRotationValue += 0.1;
    } else if (keyCode == DOWN) {
        xRotationValue -= 0.1;
    } else if (keyCode == RIGHT) {
        yRotationValue += 0.1;
    } else if (keyCode == LEFT) {
        yRotationValue -= 0.1;
    }
  }
  }
}

My2DPoint projectPoint(My3DPoint eye, My3DPoint p) {
  return new My2DPoint((p.x - eye.x)*((-eye.z)/(p.z-eye.z)), (p.y - eye.y)*((-eye.z)/(p.z-eye.z)));
}

My2DBox projectBox (My3DPoint eye, My3DBox box) {
  My2DPoint[] projections = new My2DPoint[box.p.length];
  for (int i=0; i < box.p.length; i++) {
    projections[i] = projectPoint(eye, box.p[i]);
  }
  return new My2DBox(projections);
}


float[] homogeneous3DPoint (My3DPoint p) {
  float[] result = {p.x, p.y, p.z, 1};
  return result;
}

float[][]  rotateXMatrix(float angle) {
  return(new float[][] {{1, 0, 0, 0}, 
    {0, cos(angle), sin(angle), 0}, 
    {0, -sin(angle), cos(angle), 0}, 
    {0, 0, 0, 1}});
}
float[][] rotateYMatrix(float angle) {
  return(new float[][] {{cos(angle), 0, -sin(angle), 0}, 
    {0, 1, 0, 0}, 
    {sin(angle), 0, cos(angle), 0}, 
    {0, 0, 0, 1}});
}
float[][] rotateZMatrix(float angle) { 
  return(new float[][] {{cos(angle), sin(angle), 0, 0}, 
    {-sin(angle), cos(angle), 0, 0}, 
    {0, 0, 1, 0}, 
    {0, 0, 0, 1}});
}
float[][] scaleMatrix(float x, float y, float z) {
  return(new float[][] {{x, 0, 0, 0}, 
    {0, y, 0, 0}, 
    {0, 0, z, 0}, 
    {0, 0, 0, 1}});
}
float[][] translationMatrix(float x, float y, float z) {
  return(new float[][] {{1, 0, 0, x}, 
    {0, 1, 0, y}, 
    {0, 0, 1, z}, 
    {0, 0, 0, 1}});
}

float[] matrixProduct(float[][] a, float[] b) {
  float[] result = new float[a.length];
  for (int i=0; i < a.length; i++) {
    for (int j=0; j < a.length; j++) {
      result[i] += a[i][j]*b[j];
    }
  }
  return result;
}

My3DBox transformBox(My3DBox box, float[][] transformMatrix) {
  My3DPoint[] points = new My3DPoint[box.p.length];
  float[] multMatrix = new float[transformMatrix.length];
  for (int i=0; i < points.length; i++) {
    float[] p = homogeneous3DPoint(box.p[i]);
    multMatrix = matrixProduct(transformMatrix, p);
    points[i] = euclidian3DPoint(multMatrix);
  }
  return new My3DBox(points);
}

My3DPoint euclidian3DPoint (float[] a) {
  My3DPoint result = new My3DPoint(a[0]/a[3], a[1]/a[3], a[2]/a[3]);
  return result;
}