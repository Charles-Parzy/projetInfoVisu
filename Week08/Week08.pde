PImage img;
PImage resultHue;
PImage result;
PImage houghImg;

void settings() {
  size(800, 600);
}
void setup() {
  img = loadImage("board1.jpg");
  resultHue = createImage(img.width, img.height, RGB);
  result = createImage(img.width, img.height, ALPHA);
}
void draw() {
  background(color(0, 0, 0));
  filterHue(img);
  image(img, 0, 0);
  sobel(resultHue);
  hough(result);  
}
  