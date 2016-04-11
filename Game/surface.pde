float totalScore = 0;
ArrayList<Float> scores = new ArrayList();
int rectangleValue = 10;
int abscisse = 10;
int rectangleSize = 8;
float oldScore = 0;
ArrayList<Integer> rectangles = new ArrayList();

void drawSurface() {
  visualisationSurface.beginDraw();
  visualisationSurface.background(200, 173, 127);
  drawTopView();
  drawScoreBoard();
  drawBarChart();
  visualisationSurface.endDraw();
  image(visualisationSurface, 0, 5/6. * height);
  image(topView, 10, 5/6. * height + 10);
  image(scoreBoard, 20 + topView.width, 5/6. * height + 10);
  image(barChart, topView.width + scoreBoard.width + 45, 5/6. * height + 10);
}

void drawTopView() {
  topView.beginDraw();
  topView.background(86, 115, 154);
  topView.noStroke();
  topView.fill(254, 27, 0);
  topView.ellipse((location.x + plate.boxWidth/2)/scaleConstant, (location.z + plate.boxHeight/2)/scaleConstant, balle.radius/scaleConstant, balle.radius/scaleConstant);
  for (PVector c : plate.cylinders) {
    pushMatrix(); 
    topView.noStroke();
    topView.fill(173, 79, 9);
    topView.ellipse((c.x + plate.boxWidth/2)/scaleConstant, (c.y + plate.boxHeight/2)/scaleConstant, 2*cylinderBaseSize/scaleConstant, 2*cylinderBaseSize/scaleConstant);
    popMatrix();
  }
  topView.endDraw();
}

void drawScoreBoard() {
  scoreBoard.beginDraw();
  scoreBoard.background(200, 173, 127);

  scoreBoard.stroke(255);
  scoreBoard.strokeWeight(4);
  scoreBoard.noFill();
  scoreBoard.rect(0, 0, scoreBoard.width, scoreBoard.height);

  scoreBoard.textSize(12);

  scoreBoard.text("Velocity:", 7, scoreBoard.height/2 - 1);
  scoreBoard.text(mover.velocity.mag(), 7, scoreBoard.height/2 + 11);

  scoreBoard.text("Total Score:", 7, 15);
  scoreBoard.text(totalScore, 7, 27);

  scoreBoard.text("Last Score:", 7, scoreBoard.height - 20);
  scoreBoard.text(scores.get(scores.size() - 1), 7, scoreBoard.height - 8);

  scoreBoard.fill(10);

  scoreBoard.endDraw();
}

void drawBarChart() {
  barChart.beginDraw();
  barChart.background(220, 216, 210);
  if (oldScore != totalScore) {
    if(totalScore > 0) {
    rectangles.add(int(totalScore/rectangleValue));
    } else {
    rectangles.add(0);  
    }   
    oldScore = totalScore;
  }
  
  for (int i = 0; i < rectangles.size(); i++) { //peut beuguer si totalScore/rectangleValue == 0
      for(int j = 0; j < rectangles.get(i); j++) {
      barChart.rect(i * rectangleSize, barChart.height - j*7, rectangleSize, rectangleSize);
      barChart.stroke(255);
      barChart.fill(16, 52, 166);
      }
    }

  barChart.endDraw();
}