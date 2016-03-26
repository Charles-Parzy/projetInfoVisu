class My2DBox {
  My2DPoint[] s;
  My2DBox(My2DPoint[] s) {
    this.s = s;
  }
  void render() {
    for(int i=0; i < 4; i++) {
      line(s[i].x, s[i].y, s[(i+1)%4].x, s[(i+1)%4].y); // create square from s[0] to s[3]
      line(s[i+4].x, s[i+4].y, s[(i+1)%4+4].x, s[(i+1)%4+4].y); // create square from s[4] to s[7]
      line(s[i].x, s[i].y, s[(i+4)].x, s[(i+4)].y); // create lines between the two square to create a cub
    }
  }
}