PImage convolute(PImage img) {
  float[][] kernel = {{ 0, 0, 0 }, 
                      { 0, 2, 0 }, 
                      { 0, 0, 0 }};

  return transformAlgo(img, kernel, 1.f);
}

PImage gaussianBlur(PImage img) {
  float[][] kernel = {{ 9, 12, 9 }, 
                      { 12, 15, 12 }, 
                      { 9, 12, 9 }};

  return transformAlgo(img, kernel, 100);
}

PImage transformAlgo(PImage img, float[][] kernel, float weight) {
  result.loadPixels();

  for (int y=0; y<img.height; y++) {
    for (int x=0; x<img.width; x++) {

      float convolution = 0;
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          //Check the one-pixel wide border around the image
          if (!(x+i-1 < 0 || x+i-1 > img.width-1 || y+j-1 < 0 || y+j-1 > img.height-1)) {
            convolution += brightness(img.pixels[(y+j-1) * img.width + x+i-1]) * kernel[i][j];
          }
        }
      }
      result.pixels[y * img.width + x] = color(convolution/weight);
    }
  }
  result.updatePixels();
  return result;
}