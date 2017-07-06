import processing.pdf.*;

//------- JSON DATA ---------
JSONArray GooglePositionHistory;
String position_history_file = "pierre.json";

String     timestampMs = "1489432985771";
String lastTimestampMs = "1489432985771";

int nb_month = 120000;
int nb_days = 2000;
int[][] landscape_data = new int[nb_month][nb_days];
//int[][] latitude_data = new int[nb_month][nb_days];
int[][] accuracy_data = new int[nb_month][nb_days];
float[][] timestampMs_data = new float[nb_month][nb_days];

//------- CONFIG LANDSCAPE ---------
float y = 80;
float amplitude = random (50, 80);
float steps = 3;
float timeSteps = 0.01;
float versatz = 10;
float sw = random (0.5, 2);
float strokeAlpha;
color bgColor = 255;
int margin = 30;

boolean doReDraw = true;

int i = 0;
int j = 0;

void setup ()
{
  size (400, 400);
  //size (400, 400, PDF, "test6.pdf");
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
  
  //Delete old landscape when deReDraw
  background(255);
  
  Position_to_landscape();
  
  // Y of the landscape base on >>>
  //y = random (80, 150);
  y = random (80, 150);
  
  while (y < height){
    
    setRandomValues ();
    
    drawFilles();
    //drawLines();
    
    y+= accuracy_data[9][i+1]; //confidence moyen
  }
  //drawMargin();
  fill(255);
  rect (0, 0, width, margin);
  
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
    
    //println(day);
    
    landscape_data[month][i] = longitude;
    //latitude_data[month][i] = latitude;
    accuracy_data[month][i] = accuracy;
    timestampMs_data[month][i] = processTimestamp(timestampMs,lastTimestampMs);
    
    //lastTimestampMs = timestampMs;
  }
}

void setRandomValues ()
{
  noiseSeed ((int) random (100000));

  sw = random (0.5, 2);

  steps = random (sw*2, 6);
  amplitude = random (40, 250);

  timeSteps = random (0.01, 0.05);

  versatz = random (-200, 200);

  strokeAlpha = random (50, 200);
}

void mousePressed ()
{
  //exit();
  doReDraw = true; 
  j = 0;
}

int time ()
{
  return (year () + month() + day() +hour() + minute () + second ()+frameCount);
}

void drawFilles ()
{
  //fill (bgColor);
  fill (random (50, 200));
  noStroke();

  //float noiseValue;
  //float time = 0.0;
  
  float x = margin;
  
  beginShape ();

  vertex (margin, height-margin);
  
  while (x < width-margin+1 ){
    //noiseValue = y - noise (time)*amplitude;
    
    vertex (x, y - landscape_data[9][j]/300000*2);    
    //vertex (x, noiseValue);
    j++;
    println(landscape_data[9][int(x)]/100000);
    //x+= timestampMs_data[9][int(x)]/3000;
    //x+= landscape_data[9][int(x)]/10000000;
    
    x+= 15;
    
    //time += float(processTimestamp(timestampMs,lastTimestampMs));

  }

  vertex (width-margin, y - landscape_data[9][j]/300000*2);

  i++;
  
  vertex (width-margin, height-margin);
  endShape();
}

/*void drawLines ()
{
  noFill ();
  strokeWeight (sw);


  float noiseValue;
  float x = -abs (versatz);
  float time = 0.0;

  while (x < width + abs (versatz))
  {
    noiseValue = y - noise (time)*amplitude;
    strokeWeight (random (sw*0.5, sw*1.2));
    stroke (random (strokeAlpha*0.8, strokeAlpha));

    line (x, noiseValue+3, x + random (versatz*0.9, versatz), noiseValue+3+height);

    x+= steps;
    time += timeSteps;
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
}*/