/* ----------------------------------------------------------------------------------------------------
 * Google Position History to GRAPHIC, 2017
 * Update: 08/07/17
 *
 * TODO : Check Month & Draw Lines
 *
 * V0.5
 * Written by Bastien DIDIER
 * ----------------------------------------------------------------------------------------------------
 */
import processing.pdf.*;

//------- JSON DATA ---------
JSONArray GooglePositionHistory;
//String position_history_file = "Albertine_Meunier_2016_janvier.json";
//String position_history_file = "pierre.json";
String position_history_file = "Valentina_Peri_2016.json";

String     timestampMs = "1489432985771";
String lastTimestampMs = "1489432985771";

boolean firstTime = true;
boolean ShapeIsBegin = false;
boolean ShapeIsFinish = false;

//------- CONFIG LANDSCAPE ---------
float y;
int margin = 30;
int landscape_count = 0;
int month_count = 0;

//------- LANDSCAPE DATA -----------
float x_landscape = margin;
float y_landscape = 0;
float last_y_landscape = 0;

void setup ()
{
  //size (400, 400);
  size(400, 400, PDF, "export.pdf");
  smooth();
  
  background(197,230,255);
  Position_to_landscape();
  
  exit();
}

void Position_to_landscape() {
  GooglePositionHistory = loadJSONArray(position_history_file);

  for (int i = GooglePositionHistory.size()-1; i > 0; i--) {

    //------- GET JSON DATA ---------
    JSONObject locations = GooglePositionHistory.getJSONObject(i);

    int accuracy = locations.getInt("accuracy");
    int latitude = locations.getInt("latitudeE7");
    int longitude = locations.getInt("longitudeE7");

    timestampMs = locations.getString("timestampMs");
    //timestampMs = str(locations.getInt("timestampMs"));
    
    //println(month);
    
    //------- PROCESS JSON DATA ---------
    if(firstTime == true){
      y = accuracy;
      firstTime = false;
    } 
    
    if(y < height-margin){
      
      //------- CHECK MONTH DATA -----------
      if(month == lastMonth && landscape_count < 12){
      
        //------- GENERATE LANDSCAPE FROM JSON DATA ---------
        if(ShapeIsBegin != true){
          fill (random(0, 200),random(150, 255),random(50, 200));
          noStroke();
    
          //println("Begin Shape");
          beginShape ();
          vertex (margin, height-margin);
          vertex (x_landscape, y_landscape);
          ShapeIsBegin = true;
            
        } else if(ShapeIsBegin == true && ShapeIsFinish == true){
            
          //println("End Shape");
            
          vertex (width-margin, y_landscape);
          vertex (width-margin, height-margin);
          endShape(CLOSE);
            
          ShapeIsBegin = false;
          ShapeIsFinish = false;
          landscape_count++;
          
        } else {
          //println("Create Vertex");
            
          y_landscape = map(longitude/100000, 100,240, 100, 300); //y - longitude/100000
            
          if(y_landscape != last_y_landscape && y_landscape > margin){
            vertex (x_landscape, y_landscape);
            last_y_landscape = y_landscape;
            
            //TODO DRAW LINE
            //noFill ();
            //strokeWeight(1);
            //stroke(0);
            //line (x_landscape, y_landscape, x_landscape, y_landscape+50);
            
            x_landscape += map(processTimestamp(timestampMs, lastTimestampMs)/1000, 0,10, 10, 20); //15/25
          }
          
          if(x_landscape > width-margin){
            ShapeIsFinish = true;
            x_landscape = margin;
          }
        }
        //lastMonth = month;
      } else {
        y += accuracy;
        lastMonth = month;
        month_count++;
        
        println("YO");
      }
    }
    //lastTimestampMs = timestampMs;
  }
  println("Month Count : "+month_count);
  println("FINISH !");
  drawMargin();
}