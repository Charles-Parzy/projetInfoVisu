class My2DBox {
  My2DPoint[] s;
  My2DBox(My2DPoint[] s) {
      this.s = s;
  }
  
  void render(){
    
    for(int i=0;i<4;i++){
      stroke(255,30,40);
      line(s[i%4].x,s[i%4].y,s[(i+1)%4].x,s[(i+1)%4].y);
    
    
      stroke(129,255,200);
      line(s[(i%4)+4].x,s[(i%4)+4].y,s[((i+1)%4)+4].x,s[((i+1)%4)+4].y);
    
      stroke(125,125,125);
      line(s[i].x,s[i].y,s[i+4].x,s[i+4].y);
    }

    
    
  }
}