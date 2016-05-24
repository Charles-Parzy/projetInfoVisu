import java.util.List;

import processing.core.PVector;
import papaya.*;

class TwoDThreeD {
  
  // default focal length, well suited for most webcams
   float f = 700;
  
  // intrisic camera matrix
   float [][] K = {{f,0,0},
                   {0,f,0},
                   {0,0,1}};
  
  // Real physical coordinates of the Lego board in mm
   float boardSize = 380.f; // large Duplo board
  // float boardSize = 255.f; // smaller Lego board
  
  // the 3D coordinates of the physical board corners, clockwise
   float [][] physicalCorners = {{-128,-128,0,1},
                                 {128 ,-128,0,1},
                                 {128 , 128,0,1},
                                 {-128, 128,0,1}};
  
  public TwoDThreeD(int width, int height) {
    
    // set the offset to the center of the webcam image
    K[0][2] = 0.5f * width;
    K[1][2] = 0.5f * height;
      
  }

   PVector get3DRotations(List<PVector> points2D) {
    
    // 1- Solve the extrinsic matrix from the projected 2D points
    double[][] E = solveExtrinsicMatrix(points2D);
    
    
        // 2 - Re-build a proper 3x3 rotation matrix from the camera's 
    //     extrinsic matrix E
        float[] firstColumn = {(float)E[0][0],
                     (float)E[1][0],
                     (float)E[2][0]};
        firstColumn = Mat.multiply(firstColumn, 1/Mat.norm2(firstColumn)); // normalize
        
        float[] secondColumn={(float)E[0][1],
                    (float)E[1][1],
                    (float)E[2][1]};
        secondColumn = Mat.multiply(secondColumn, 1/Mat.norm2(secondColumn)); // normalize
        
        float[] thirdColumn = Mat.cross(firstColumn, secondColumn);
        
        float[][] rotationMatrix = {
            {firstColumn[0], secondColumn[0], thirdColumn[0]},
                {firstColumn[1], secondColumn[1], thirdColumn[1]},
                {firstColumn[2], secondColumn[2], thirdColumn[2]}
               };
        
        // 3 - Computes and returns Euler angles (rx, ry, rz) from this matrix
        return rotationFromMatrix(rotationMatrix);
  
  }
    
    
   double[][] solveExtrinsicMatrix(List<PVector> points2D) {
  
    // p ~= K · [R|t] · P
    // with P the (3D) corners of the physical board, p the (2D) 
    // projected points onto the webcam image, K the intrinsic 
    // matrix and R and t the rotation and translation we want to 
    // compute.
    //
    // => We want to solve: (K^(-1) · p) X ([R|t] · P) = 0
    
    float [][] invK=Mat.inverse(K);

    float[][] projectedCorners = new float[4][3];
    
    for(int i=0;i<4;i++){
        // TODO:
        // store in projectedCorners the result of (K^(-1) · p), for each 
        // corner p found in the webcam image.
        // You can use Mat.multiply to multiply a matrix with a vector.
        float[][] points = {{points2D.get(i).x},
                            {points2D.get(i).y},  
                            {1}};
        float[][] mult = Mat.multiply(invK, points);
        projectedCorners[i][0] = mult[0][0];
        projectedCorners[i][1] = mult[1][0];
        projectedCorners[i][2] = mult[2][0];
    }
    
    // 'A' contains the cross-product (K^(-1) · p) X P
      float[][] A= new float[12][9];
      
      for(int i=0;i<4;i++){
        A[i*3][0]=0;
        A[i*3][1]=0;
        A[i*3][2]=0;
        
        // note that we take physicalCorners[0,1,*3*]: we drop the Z
        // coordinate and use the 2D homogenous coordinates of the physical
        // corners
        A[i*3][3]=-projectedCorners[i][2] * physicalCorners[i][0];
        A[i*3][4]=-projectedCorners[i][2] * physicalCorners[i][1];
        A[i*3][5]=-projectedCorners[i][2] * physicalCorners[i][3];

        A[i*3][6]= projectedCorners[i][1] * physicalCorners[i][0];
        A[i*3][7]= projectedCorners[i][1] * physicalCorners[i][1];
        A[i*3][8]= projectedCorners[i][1] * physicalCorners[i][3];

        A[i*3+1][0]= projectedCorners[i][2] * physicalCorners[i][0];
        A[i*3+1][1]= projectedCorners[i][2] * physicalCorners[i][1];
        A[i*3+1][2]= projectedCorners[i][2] * physicalCorners[i][3];
        
        A[i*3+1][3]=0;
        A[i*3+1][4]=0;
        A[i*3+1][5]=0;
        
        A[i*3+1][6]=-projectedCorners[i][0] * physicalCorners[i][0];
        A[i*3+1][7]=-projectedCorners[i][0] * physicalCorners[i][1];
        A[i*3+1][8]=-projectedCorners[i][0] * physicalCorners[i][3];

        A[i*3+2][0]=-projectedCorners[i][1] * physicalCorners[i][0];
        A[i*3+2][1]=-projectedCorners[i][1] * physicalCorners[i][1];
        A[i*3+2][2]=-projectedCorners[i][1] * physicalCorners[i][3];
        
        A[i*3+2][3]= projectedCorners[i][0] * physicalCorners[i][0];
        A[i*3+2][4]= projectedCorners[i][0] * physicalCorners[i][1];
        A[i*3+2][5]= projectedCorners[i][0] * physicalCorners[i][3];
        
        A[i*3+2][6]=0;
        A[i*3+2][7]=0;
        A[i*3+2][8]=0;
      }

      SVD svd=new SVD(A);
      
      double[][] V = svd.getV();
      
      double[][] E = new double[3][3];
      
      //E is the last column of V
      for(int i=0;i<9;i++){
        E[i/3][i%3] = V[i][V.length-1] / V[8][V.length-1];
      }
      
      return E;

  }
    
   PVector rotationFromMatrix(float[][]  mat) {

    // Assuming rotation order is around x,y,z
    PVector rot = new PVector();
    
    if(mat[1][0] > 0.998) { // singularity at north pole
      rot.z = 0;
      float delta = (float) Math.atan2(mat[0][1],mat[0][2]);
      rot.y = -(float) Math.PI/2;
      rot.x = -rot.z + delta;
      return rot;
    }

    if(mat[1][0] < -0.998) { // singularity at south pole
      rot.z = 0;
      float delta = (float) Math.atan2(mat[0][1],mat[0][2]);
      rot.y = (float) Math.PI/2;
      rot.x = rot.z + delta;
      return rot;
    }

    rot.y =-(float)Math.asin(mat[2][0]);
    rot.x = (float)Math.atan2(mat[2][1]/Math.cos(rot.y), mat[2][2]/Math.cos(rot.y));
    rot.z = (float)Math.atan2(mat[1][0]/Math.cos(rot.y), mat[0][0]/Math.cos(rot.y));

    return rot;
  }
}