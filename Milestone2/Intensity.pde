void intensityFilter(PImage img) {
  tempImage.loadPixels();
  color black = color(0, 0, 0);
  color white = color(255,255,255);
  float upperBrightness = 232;
  float lowerBrightness = 30; 
  for (int i = 0; i < img.width * img.height; i++) {
    if (brightness(img.pixels[i]) < upperBrightness && brightness(img.pixels[i]) > lowerBrightness) {      
      tempImage.pixels[i] = white;
    }else{
      tempImage.pixels[i] = black;
    }
  }
  tempImage.updatePixels();
}