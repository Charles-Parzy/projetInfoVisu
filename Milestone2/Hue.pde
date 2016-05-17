void filterHue(PImage img) {
  tempImage.loadPixels();
  color black = color(0, 0, 0);
  color white = color(255,255,255);
  float upperHue = 138;
  float lowerHue = 75; //LES BORNES POUR ISOLER LA COULEUR VERTE
  float upperBrightness = 232;
  float lowerBrightness = 30;
  float upperSaturation = 256;
  float lowerSaturation = 85;  
  for (int i = 0; i < img.width * img.height; i++) {
    if (hue(img.pixels[i]) < upperHue && hue(img.pixels[i]) > lowerHue
        && brightness(img.pixels[i]) < upperBrightness && brightness(img.pixels[i]) > lowerBrightness
        && saturation(img.pixels[i]) < upperSaturation && saturation(img.pixels[i]) > lowerSaturation) {      
      tempImage.pixels[i] = white;
    }else{
      tempImage.pixels[i] = black;
    }
  }
  tempImage.updatePixels();
}