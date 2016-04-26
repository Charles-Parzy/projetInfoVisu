import processing.video.*;
Capture cam;

PImage img;
PImage resultHue;
PImage result;
PImage houghImg;

void settings() {
  size(640, 480);
}
void setup() {
  resultHue = createImage(width, height, RGB);
  result = createImage(width, height, ALPHA);
  String[] cameras = Capture.list();
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(i + cameras[i]);
    }
    cam = new Capture(this, 640 , 480 , 30);
    cam.start();
  }
}
void draw() {
  if (cam.available() == true) {
    cam.read();
  }
  img = cam.get();
  filterHue(img);
  image(img, 0, 0);
  sobel(resultHue);
  hough(result);
}