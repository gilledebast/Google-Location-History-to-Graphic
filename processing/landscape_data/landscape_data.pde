/* ----------------------------------------------------------------------------------------------------
 * Google Position History to GRAPHIC, 2017
 * Update: 15/06/17
 *
 * V0.1
 * Written by Bastien DIDIER
 *
 * ----------------------------------------------------------------------------------------------------
 */
 
import processing.pdf.*;

//------- JSON DATA ---------
JSONArray GooglePositionHistory;
String position_history_file = "pierre.json";



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

void setup ()
{
  //size (400, 400);
  size (400, 400, PDF, "test6.pdf");
  smooth();
  
  /*
  y = random (80, 150);

    while (y < height+70)
    {
      setRandomValues ();
      drawFilles();
      drawLines();

      y+= random (5, 70);
    }

    drawMargin();
    */
    
    Position_to_graphic();
    
    //automaticaly save .pdf
    exit();
}

void draw ()
{
  /*if (doReDraw == true)
  {
    background (bgColor);

    y = random (80, 150);

    while (y < height+70)
    {
      setRandomValues ();
      drawFilles();
      drawLines();

      y+= random (5, 70);
    }

    drawMargin();

    doReDraw = false;
  }*/
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
}

int time ()
{
  return (year () + month() + day() +hour() + minute () + second ()+frameCount);
}

void drawFilles ()
{
  fill (bgColor);
  noStroke();

  float noiseValue;
  float x = -abs (versatz);
  float time = 0.0;

  beginShape ();

  vertex (-10, height+1);
  while (x < width )
  {
    noiseValue = y - noise (time)*amplitude;
    vertex (x, noiseValue);

    x+= steps;
    time += timeSteps;
  }
  vertex (width+10, height+1);
  endShape();
}

void drawLines ()
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
}




void Position_to_graphic(){
  GooglePositionHistory = loadJSONArray(position_history_file);
  
  for (int i = GooglePositionHistory.size()-1; i > 0; i--) {
    
    //------- GET JSON DATA ---------
    JSONObject locations = GooglePositionHistory.getJSONObject(i);
    JSONObject activitys = locations.getJSONObject("activitys");
    
    //for(int j = 0; j < activitys.length(); j++){
      
      //activities
      
      //int timestampMS = activitys.getInt("timestampMs");
      //JSONObject activitys = activitys.getJSONObject("activitys");
      
      //println(timestampMS);
    //}
  }
}