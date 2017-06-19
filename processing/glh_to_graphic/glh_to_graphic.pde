/* ----------------------------------------------------------------------------------------------------
 * Google Position History to GRAPHIC, 2017
 * Update: 15/06/17
 *
 * V0.1
 * Written by Bastien DIDIER
 *
 * ----------------------------------------------------------------------------------------------------
 */

//import processing.dxf.*; // Import the DXF library
//boolean record;

import processing.pdf.*;

JSONArray GooglePositionHistory;
String position_history_file = "pierre.json";

int tempo = 300;

String     timestampMs = "1489432985771";
String lastTimestampMs = "1489432985771";

//TODO a modifier
int note_min = 30;
int note_max = 70; //127

int latlong_min = 555555555;
int latlong_max = 444444444;

float latlong_to_midi;
float last_latlong_to_midi;

/*int day = 0;
int last_day = 1;*/

int process;
int last_process;
int last_latlong;
int count = 1;

ArrayList polygons;

int nbPath = 318730; //GooglePositionHistory.size()-1;
PShape[] path = new PShape[nbPath]; 

void setup() {
  //size(500, 500, P3D);
  size(400, 400, PDF, "julien_test_glh.pdf");
  
  background(255);
  
  smooth();
  
  //for(int id = 0; id < nbPath; id++){
    //create_shape(id,int(random(1,10)),int(random(1,3)),int(random(0,255)));
  //}
  
  //TODO Init GUI
  Position_to_graphic();
}

void loop(){
  //TODO Update GUI when .json is loaded 
  exit();
}

void Position_to_graphic(){
  GooglePositionHistory = loadJSONArray(position_history_file);

  //for (int i = 0; i < GooglePositionHistory.size(); i++) {
  for (int i = GooglePositionHistory.size()-1; i > 0; i--) {
    
    JSONObject locations = GooglePositionHistory.getJSONObject(i); 

    timestampMs = locations.getString("timestampMs");
    
    int latitude = locations.getInt("latitudeE7");
    int longitude = locations.getInt("longitudeE7");
    
    int accuracy = locations.getInt("accuracy");
    
    /*********************************/

    int latlong = latitude - longitude;
    
    if(latlong < 0){
      latlong = -latlong;
    }
    
    /*********************************/
    
    //TODO le rendre dynamique à l'échelle d'une journée
    if(latlong_min > latlong){
      latlong_min = latlong;
    }
    if(latlong_max < latlong){
      latlong_max = latlong;
    }
    
    latlong_to_midi = map(latlong, latlong_min, latlong_max, note_min, note_max);

    /*********************************/
     
    if(processTimestamp(timestampMs, lastTimestampMs) > 50){ // ICI ca supprime les petites notes < en dessous de 10ms
      
      process = processTimestamp(timestampMs, lastTimestampMs);
      
      if(process != last_process){
        
        if(int(latlong_to_midi) != last_latlong){
        
          /*******************/
          //DO SOMETHING
          /*******************/
          
          create_shape(i,accuracy,last_latlong/30,0);
          shape(path[i], accuracy, process);
          
          //width
          
          count++;
          
        } else {
          count = 1;
        }
      }
      
      last_process = process;
      last_latlong = int(latlong_to_midi);
    }
    
    //println(accuracy + ", " + timestampMs + " , " + latitude + ", " + longitude);

    /*********************************/
    
    lastTimestampMs = timestampMs;
  }
}

void create_shape(int id, int amplitude, int frequence, int c){
  
  stroke(c);
  noFill();
  
  path[id] = createShape();
  path[id].beginShape();
    
  float x = 0;
  // Calculate the path as a sine wave
  for (float a = 0; a < TWO_PI*4; a += 0.1) {
    path[id].vertex(x,sin(a)*amplitude);
    x+= frequence;
  }
  // Don't "CLOSE" a shape if you want it to be a path
  path[id].endShape();

}