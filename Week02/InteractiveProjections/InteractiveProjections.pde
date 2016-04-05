void settings() {
  size(1000, 1000, P2D);
}
void setup () {
}

int value = 100;
float radiousX=0;
float radiousY=0;
void draw() {
 
  background(255, 204, 0);
  My3DPoint eye = new My3DPoint(0, 0, -5000);
  My3DPoint origin = new My3DPoint(0, 0, 0);
  My3DBox input3DBox = new My3DBox(origin, value, value, value);
  //rotated around x
  float[][] transform1 = rotateXMatrix(radiousX);
  input3DBox = transformBox(input3DBox, transform1);
  
  
    //rotated around y
  float[][] transform4 = rotateYMatrix(radiousY);
  input3DBox = transformBox(input3DBox, transform4);
  
  //rotated and translated
  float[][] transform2 = translationMatrix(200, 200, 0);
  input3DBox = transformBox(input3DBox, transform2);
  
  //rotated, translated, and scaled
  float[][] transform3 = scaleMatrix(2, 2, 2);
  input3DBox = transformBox(input3DBox, transform3);
  projectBox(eye, input3DBox).render();


}

//evenement
void mouseDragged() 
{
  
  if ((pmouseY-mouseY)>0) {
    value += 5;
  }else if((pmouseY-mouseY)<0){
    value-=5;
  }
}

void keyPressed(){
  println(keyCode);
  if(key ==CODED){
     //<>//
    if(key == UP || keyCode==38){
      radiousX+=0.1;
      
    }else if(key == DOWN || keyCode==40){
      radiousX-=0.1;
      
    }else if(key == LEFT || keyCode==37){
       radiousY+=0.1; 
    }
    else if(key == RIGHT || keyCode==39){
        radiousY-=0.1;
    }
  }
  
}


My2DPoint projectPoint(My3DPoint eye, My3DPoint p) {
  float inverse=(-eye.z/(p.z-eye.z));
  return new My2DPoint((p.x-eye.x)*inverse, (p.y-eye.y)* inverse);
}

My2DBox projectBox (My3DPoint eye, My3DBox box) {
  My2DPoint[] p= new My2DPoint[box.p.length];

  for (int i=0; i<box.p.length; i++) {
    p[i]=projectPoint(eye, box.p[i]);
  }

  return new My2DBox(p);
}

float[] homogeneous3DPoint (My3DPoint p) {
  float[] result = {p.x, p.y, p.z, 1};
  return result;
}

// MATRIX TRANSFORMATION
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
    {0, 0, 0, 1}}
    );
}

float[][] rotateZMatrix(float angle) {
  return(new float[][] {{cos(angle), sin(angle), 0, 0}, 
    {-sin(angle), cos(angle), 0, 0}, 
    {0, 0, 1, 0}, 
    {0, 0, 0, 1}}
    );
}
float[][] scaleMatrix(float x, float y, float z) {
  return(new float[][]{{x, 0, 0, 0}, 
    {0, y, 0, 0}, 
    {0, 0, z, 0}, 
    {0, 0, 0, 1}});
}
float[][] translationMatrix(float x, float y, float z) {
  return(new float[][]{{1, 0, 0, x}, 
    {0, 1, 0, y}, 
    {0, 0, 1, z}, 
    {0, 0, 0, 1}});
}  


// Matrix

float[] matrixProduct(float[][] a, float[] b) {
  float[] res = new float[b.length];
  for (int i=0; i<a.length; i++) {
    int sum=0;
    for (int j=0; j<b.length; j++) {
      sum+=a[i][j]*b[j];
    }
    res[i]=sum;
  }

  return res;
}


My3DBox transformBox(My3DBox box, float[][] tranformMatrix) {
  My3DPoint p[] = new My3DPoint[box.p.length];

  for (int i=0; i<p.length; i++) {
    float[] temp = matrixProduct(tranformMatrix,homogeneous3DPoint(box.p[i]));
    p[i]=euclidian3DPoint(temp);
  }
  
  return new My3DBox(p);
}

My3DPoint euclidian3DPoint (float[] a) {
  My3DPoint result = new My3DPoint(a[0]/a[3], a[1]/a[3], a[2]/a[3]);
  return result;
}