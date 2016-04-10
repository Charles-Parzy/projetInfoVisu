ArrayList<Float> listScores = new ArrayList<Float>();
int scaleFactor = 1;
float blockSize = 5;


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
  listScores.add(mover.lastScore);
  barChart.beginDraw();
  barChart.background(238, 235, 201);
  barChart.fill(0, 0, 255);
  barChart.noStroke();
  if (listScores.size() > 0) {
    while (listScores.get(listScores.size() - 1)*1.3 / scaleFactor > barChart.height) {
      scaleFactor *= 2;
    }
  }
  for(int i = 0; i < listScores.size(); i ++) {
    for(int j = 0; j < listScores.get(i)/(blockSize*scaleFactor); j++) {
      barChart.rect(blockSize * i * hs.getPos() * 1.5, barChart.height - (blockSize+blockSize/4) * (j+1), blockSize * hs.getPos(), blockSize);
    }
  }
  barChart.endDraw();
}