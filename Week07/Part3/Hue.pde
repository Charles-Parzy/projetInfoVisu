void filterHue(PImage img) {
  resultHue.loadPixels();
  color black = color(0, 0, 0);
  color white = color(255,255,255);
  float upperThreshold = 139;
  float lowerThreshold = 108; //LES BORNES POUR ISOLER LA COULEUR VERTE
  for (int i = 0; i < img.width * img.height; i++) {
    if (hue(img.pixels[i]) < upperThreshold && hue(img.pixels[i]) > lowerThreshold) {      
      resultHue.pixels[i] = white;
    }else{
      resultHue.pixels[i] = black;
    }
  }
  resultHue.updatePixels();
}