ArrayList<Float> listScores = new ArrayList<Float>();

void drawData() {
  dataBackground.beginDraw();
  dataBackground.background(245, 222, 179);
  drawTopView();
  drawScore();
  drawBarChart();
  dataBackground.endDraw();
  image(dataBackground, 0, 4*height/5);
  image(topView, 10, 4*height/5 + 10); 
  image(scoreboard, topView.width + 20, 4*height/5 + 10);
  image(barChart, topView.width+scoreboard.width + 40, 4*height/5 + 10);
}

void drawTopView() {
  topView.beginDraw();
  topView.noStroke();
  topView.background(100, 149, 237);
  topView.translate(topView.width/2, topView.height/2); //Set 0,0 in center of topView

  float scaleWidth = (topView.width/plate.boxWidth);
  float scaleHeight = (topView.height/plate.boxHeight);

  //Dessine la balle
  topView.fill(255, 0, 0);
  topView.ellipse(location.x*scaleWidth, location.z*scaleHeight, 2*balle.radius*scaleWidth, 2*balle.radius*scaleHeight);

  //Dessine les cylindres
  topView.fill(245, 222, 179);
  for (PVector c : plate.cylinders) {
    topView.ellipse(c.x*scaleWidth, c.y*scaleWidth, 2*cylinderBaseSize*scaleWidth, 2*cylinderBaseSize*scaleHeight);
  }
  topView.endDraw();
}

void drawScore() {
  scoreboard.beginDraw();
  scoreboard.background(245, 222, 179);

  //Dessine le rectangle blanc
  scoreboard.stroke(255, 255, 255);
  scoreboard.strokeWeight(5);
  scoreboard.noFill();
  scoreboard.rect(0, 0, scoreboard.width, scoreboard.height);

  //Dessine le text
  scoreboard.fill(0);
  scoreboard.text("Total Score:", scoreboard.width/10, scoreboard.height/8);
  scoreboard.text(Float.toString(mover.currentScore), scoreboard.width/10, 2*scoreboard.height/8);
  scoreboard.text("Velocity:", scoreboard.width/10, 4*scoreboard.height/9);
  scoreboard.text(Float.toString(mover.velocity.mag()), scoreboard.width/10, 5*scoreboard.height/9);
  scoreboard.text("Last Score:", scoreboard.width/10, 7*scoreboard.height/9);
  scoreboard.text(Float.toString(mover.lastScore), scoreboard.width/10, 8*scoreboard.height/9);
  scoreboard.endDraw();
}

void drawBarChart() {
  
  //C'est juste un essaie mais sa marche pas, il faudrait corrigé !
  float blockWidth = 10*hs.getPos();
  float blockHeight = 10;
    
  listScores.add(mover.lastScore);

  barChart.beginDraw();
  barChart.noStroke();
  barChart.background(238, 235, 201);
  barChart.translate(10, 0);
  barChart.fill(255, 0, 0);
  for (float score : listScores) {
    int h = round(score*barChart.height/1000);
    int nbBlock = round(h/blockHeight);

    for (int i = 0; i < nbBlock; i++) {
      //Le seul truc qui est 100%, j'ai testé et sa les dessine au bon endroit
      barChart.rect(0, barChart.height - ((blockHeight + blockHeight/4)*i), blockWidth, blockHeight);
    }
    //sa fait buger je sais pas pourquoi !
    barChart.translate(blockWidth + blockWidth/4, 0);
  }
  barChart.endDraw();
}