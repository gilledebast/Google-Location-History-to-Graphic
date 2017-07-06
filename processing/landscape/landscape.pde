import processing.pdf.*;

//------- JSON DATA ---------
JSONArray GooglePositionHistory;
String position_history_file = "pierre.json";

String     timestampMs = "1489432985771";
String lastTimestampMs = "1489432985771";

int nb_month = 1000;
int nb_days = 2000;
int[][] landscape_data = new int[nb_month][nb_days];
int[][] latitude_data = new int[nb_month][nb_days];
int[][] accuracy_data = new int[nb_month][nb_days];
float[][] timestampMs_data = new float[nb_month][nb_days];

//------- CONFIG LANDSCAPE ---------
float y = 80;
color bgColor = 255;
int margin = 30;

boolean doReDraw = true;

int i = 0;
int j = 0;

void setup ()
{
  size (400, 400);
  //size (400, 400, PDF, "final2.pdf");
  smooth();
  
  generate_landscape();
  //exit();
}

void draw (){
  if (doReDraw == true){
    generate_landscape();
    doReDraw = false;
  }
}

void generate_landscape(){
  
  //Delete old landscape when doReDraw
  background(255);
  
  Position_to_landscape();
  
  // Y of the landscape base on >>>
  y = accuracy_data[9][0];
  
  while (y < height){
    
    drawFilles();
    drawLines();
    
    y+= accuracy_data[9][i+1];
  }
  
  drawMargin();
}

void Position_to_landscape(){
  GooglePositionHistory = loadJSONArray(position_history_file);
  
  for (int i = GooglePositionHistory.size()-1; i > 0; i--) {
    
    //------- GET JSON DATA ---------
    JSONObject locations = GooglePositionHistory.getJSONObject(i);
    
    int accuracy = locations.getInt("accuracy");
    
    int latitude = locations.getInt("latitudeE7");
    int longitude = locations.getInt("longitudeE7");
    
    timestampMs = locations.getString("timestampMs");
    
    landscape_data[month][i] = longitude;
    latitude_data[month][i] = latitude;
    accuracy_data[month][i] = accuracy;
    timestampMs_data[month][i] = processTimestamp(timestampMs,lastTimestampMs);
    
    //lastTimestampMs = timestampMs;
  }
}

void mousePressed ()
{
  //exit();
  doReDraw = true; 
  j = 0;
}

void drawFilles ()
{
  fill (bgColor);
  noStroke();
  
  float x_filles = margin;
  float y_filles = 0;
  
  beginShape ();
  vertex (margin, height-margin);
  
  while (x_filles < width-margin ){
    
    y_filles = y - landscape_data[9][j]/300000*2;
    
    vertex (x_filles, y_filles);
    j++;
    
    x_filles += map(timestampMs_data[9][j]/3000, 0 , 20, 15, 25);
  }

  vertex (width-margin, y_filles);

  i++;
  
  vertex (width-margin, height-margin);
  endShape();
}

void drawLines (){
  
  noFill ();

  float y_lines;
  float x_lines = -margin*2;
  
  while (x_lines < width + margin*2)
  {
    y_lines = y - landscape_data[9][j]/300000*2;
    strokeWeight (accuracy_data[9][j]/50);
    stroke (accuracy_data[9][j]/50);

    line (x_lines, y_lines+3, x_lines + y_lines , y_lines+3+height);

    x_lines += map(timestampMs_data[9][j]/3000, 0 , 20, 5, 15);
  }
}


void drawMargin ()
{
  noStroke();
  fill (bgColor);
  rect (0, 0, width, margin);
  rect (0, height, width, -margin);
  rect (0, 0, margin, height);
  rect (width, 0, -margin, height);
}