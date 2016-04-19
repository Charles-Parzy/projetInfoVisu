PImage img;
PImage resultBinary;
PImage resultInverted;
HScrollbar thresholdBar;

void settings() {
  size(800, 600);
}
void setup() {
  img = loadImage("board1.jpg");
  resultBinary = createImage(width, height, RGB);
  resultInverted = createImage(width, height, RGB);
  thresholdBar = new HScrollbar(10, height-20, width-20, 20);
}
void draw() {
  background(color(0, 0, 0));
  filterBinary();
  //Choose which image to draw 
  image(resultBinary, 0, 0);
  //image(resultInverted, 0, 0);
  thresholdBar.display();
  thresholdBar.update();
}

void filterBinary() {
  resultBinary.loadPixels();
  resultInverted.loadPixels();
  color c1 = color(255, 255, 255);
  color c2 = color(0, 0, 0);
  float fixedTreshold = 128 * thresholdBar.getPos();
  for (int i = 0; i < img.width * img.height; i++) {
    if (brightness(img.pixels[i]) > fixedTreshold) {      
      resultBinary.pixels[i] = c1;
      resultInverted.pixels[i] = c2;
    } else {
      resultBinary.pixels[i] = c2;
      resultInverted.pixels[i] = c1;
    }
  }
  resultBinary.updatePixels();
  resultInverted.updatePixels();
}