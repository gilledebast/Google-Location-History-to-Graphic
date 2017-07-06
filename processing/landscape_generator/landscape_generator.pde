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

String     timestampMs = "1489432985771";
String lastTimestampMs = "1489432985771";

int nb_month = 12;
int nb_days = 2000;
int[][] landscape_data = new int[nb_month][nb_days];

//------- CONFIG LANDSCAPE ---------
int margin = 30;

void setup(){
  size(500,500); //, PDF, "landscape.pdf");
  smooth();
  
  Position_to_landscape();
  landcape();
  
  //automaticaly save .pdf
  //exit();
}

void draw(){

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
    //processTimestamp(timestampMs,lastTimestampMs);
    
    landscape_data[month][i] = longitude;
         
  }
}

void landcape(){
  
  beginShape();
    vertex(width-margin, height-margin);
    vertex(margin, height-margin);
    //for(int i=0;i<=width-(margin*2);i++){
    for(int i=0;i<nb_days;i++){
        
      if(i == 0){
        vertex(margin, height-margin - landscape_data[1][1]);
      } else if (i == nb_days-1){
        vertex(width-margin, height-margin - landscape_data[1][30]);
      } else {
        
        //Add point
        //vertex(timestamp, accuracy);
        vertex(margin+i, height-margin - landscape_data[0][i]/100000);
      }
      
    }
  endShape(CLOSE);
}