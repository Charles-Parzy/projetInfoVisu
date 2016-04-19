PImage img;
PImage result;

void settings() {
  size(800, 600);
}
void setup() {
  img = loadImage("board1.jpg");
  result = createImage(img.width, img.height, ALPHA);
  noLoop();
}
void draw() {
  background(color(0, 0, 0));
  //image(img, 0, 0);
  PImage result = sobel(img);
  image(result, 0, 0);
}
  