void drawMargin (){
  noStroke();
  fill (bgColor);
  rect (0, 0, width, margin);
  rect (0, height, width, -margin);
  rect (0, 0, margin, height);
  rect (width, 0, -margin, height);
}