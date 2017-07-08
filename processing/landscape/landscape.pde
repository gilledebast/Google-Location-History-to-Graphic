import processing.pdf.*;

//------- JSON DATA ---------
JSONArray GooglePositionHistory;
String position_history_file = "Albertine_Meunier_2016_janvier.json";
//String position_history_file = "pierre.json";

String     timestampMs = "1489432985771";
String lastTimestampMs = "1489432985771";

int nb_month = 20;
int nb_days = 158000;
int[][] landscape_data = new int[nb_month][nb_days];
//int[][] latitude_data = new int[nb_month][nb_days];
int[][] accuracy_data = new int[nb_month][nb_days];
float[][] timestampMs_data = new float[nb_month][nb_days];

int static_month = 12; //9 pierre
boolean firstTime = true;
boolean ShapeIsBegin = false;

//------- CONFIG LANDSCAPE ---------
float y = 80;
color bgColor = 255;
int margin = 30;

boolean doReDraw = true;

int i = 0;
int j = 0;

//------- LANDSCAPE DATA ---------

float x_filles = margin;
float y_filles = 0;

void setup ()
{
  size (400, 400);
  //size (400, 400, PDF, "final2.pdf");
  smooth();
  
  background(bgColor);
  Position_to_landscape();
  
  //exit();
}

void Position_to_landscape() {
  //background(255);
  GooglePositionHistory = loadJSONArray(position_history_file);

  for (int i = GooglePositionHistory.size()-1; i > 0; i--) {

    //------- GET JSON DATA ---------
    JSONObject locations = GooglePositionHistory.getJSONObject(i);

    int accuracy = locations.getInt("accuracy");

    int latitude = locations.getInt("latitudeE7");
    int longitude = locations.getInt("longitudeE7");

    timestampMs = locations.getString("timestampMs");
    //timestampMs = str(locations.getInt("timestampMs"));

    //------- PROCESS JSON DATA ---------
    if(firstTime == true){
      y = accuracy;
      firstTime = false;
    } else {
      if(y < height){
        
        if(month == lastMonth){
          
          //------- GENERATE LANDSCAPE FROM JSON DATA ---------
          fill (random(150, 200),random(150, 200),random(150, 200));
          noStroke();
          
          if(ShapeIsBegin != true){
            beginShape ();
            vertex (margin, height-margin);
            ShapeIsBegin = true;
          } else {
            
            y_filles = map(y - timestampMs_data[static_month][j]/3000, -200, 300, -1000, 2000);
            vertex (x_filles, y_filles);
            j++;
            x_filles += map(timestampMs_data[static_month][j]/3000, 0, 20, 15, 25);
          
          }
          
        
          
        
          /*while (x_filles < width-margin ) {

          
          }*/

          vertex (width-margin, y_filles);

          i++;
        
          vertex (width-margin, height-margin);
          endShape();
  
          //drawFilles(int(random(150, 200))); //bgColor
          //drawLines();
          
          lastMonth = month;
          
        } else {
          y+= accuracy; //map ???
          lastMonth = month;
        }
      }
    }
    
    landscape_data[month][i] = longitude;
    //latitude_data[month][i] = latitude;
    accuracy_data[month][i] = accuracy;
    timestampMs_data[month][i] = processTimestamp(timestampMs, lastTimestampMs);

    //println(month);

    //lastTimestampMs = timestampMs;
  }
  println("FINISH !");
  drawMargin();
}

void drawFilles (color bg){
  fill (random(0, 200),random(0, 200),random(0, 200));
  noStroke();

  //float x_filles = margin;
  //float y_filles = 0;

  beginShape ();
  vertex (margin, height-margin);

  while (x_filles < width-margin ) {

    //try{y_filles = map(y - landscape_data[static_month][j]/300000*2, -200,200, -1000, 2000);}catch(Exception e){}
    try {
      y_filles = map(y - timestampMs_data[static_month][j]/3000, -200, 300, -1000, 2000);
    }
    catch(Exception e) {
    }

    vertex (x_filles, y_filles);
    j++;

    try {
      x_filles += map(timestampMs_data[static_month][j]/3000, 0, 20, 15, 25);
    }
    catch(Exception e) {
    }
  }

  vertex (width-margin, y_filles);

  i++;

  vertex (width-margin, height-margin);
  endShape();
}

/*void drawLines () {

  noFill ();

  float y_lines;
  float x_lines = -margin*2;

  while (x_lines < width + margin*2)
  {
    //y_lines = y - landscape_data[static_month][j]/300000*2;
    y_lines = map(y - landscape_data[static_month][j]/300000*2, -200, 200, -1000, 2000);
    //y_lines = map(y - timestampMs_data[static_month][j]/3000, -200,300, -1000, 2000);

    strokeWeight (accuracy_data[static_month][j]/50);
    stroke (accuracy_data[static_month][j]/50);

    line (x_lines, y_lines+3, x_lines + y_lines, y_lines+3+height);

    x_lines += map(timestampMs_data[static_month][j]/3000, 0, 20, 5, 15);
  }
}*/