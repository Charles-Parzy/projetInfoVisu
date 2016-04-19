PImage img;
PImage result;
HScrollbar upperThresholdBar;
HScrollbar lowerThresholdBar;

void settings() {
  size(800, 600);
}
void setup() {
  lowerThresholdBar = new HScrollbar(10, height-20, width-20, 20);
  upperThresholdBar = new HScrollbar(10, height-50, width-20, 20);
  result = createImage(width, height, RGB);
  img = loadImage("board1.jpg");
}
void draw() {
  background(color(0, 0, 0));
  filterBinary();
  //image(img, 0, 0); //Choose which image to draw 
  image(result, 0, 0);
  lowerThresholdBar.display();
  lowerThresholdBar.update();
  upperThresholdBar.display();
  upperThresholdBar.update();
}

void filterBinary() {
  result.loadPixels();
  color black = color(0, 0, 0);
  float upperThreshold = 128 * upperThresholdBar.getPos();
  float lowerThreshold = 64 * lowerThresholdBar.getPos();
  for (int i = 0; i < img.width * img.height; i++) {
    if (hue(img.pixels[i]) < upperThreshold && hue(img.pixels[i]) > lowerThreshold) {      
      result.pixels[i] = img.pixels[i];
    }else{
      result.pixels[i] = black;
    }
  }
  result.updatePixels();
}