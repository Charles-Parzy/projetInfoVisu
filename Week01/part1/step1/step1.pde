float x = 0.0;
void settings() {
size(400, 300, P2D);
}
void setup() {
frameRate(30);
}
void draw() {
background(255, 200, 100);
ellipse(x, height/2, 40, 40);
x += 2;
if (x > width + 40) {
x = -40.0;
}
}