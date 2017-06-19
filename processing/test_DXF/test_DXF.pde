/* ----------------------------------------------------------------------------------------------------
 * Google Position History to GRAPHIC, 2017
 * Update: 15/06/17
 *
 * V0.1
 * Written by Bastien DIDIER
 *
 * ----------------------------------------------------------------------------------------------------
 */

import processing.dxf.*; // Import the DXF library

import processing.pdf.*;

boolean record;
//PShape path;

boolean createPath = true;

ArrayList polygons;

int nbPath = 100;
PShape[] path = new PShape[nbPath]; 

void setup(){
  background(255);
  
  //size(500,500,P3D);
   size(400, 400, PDF, "julien_test.pdf");
   
  smooth();
  
  frameRate(1);
  
  //for(int id = 0; id < nbPath; id++){
    //create_shape(id,int(random(1,10)),int(random(1,3)),int(random(0,255)));
  //}
 
  
  //create_shape(0,10,1,0);
  //create_shape(1,10,1,0);
  //create_shape(2,10,1,0);
  
}

void draw() {
  if (record) {
    beginRaw(DXF, "julien.dxf");
  }
  
  //shape(path[0], random(0,100), random(0,height));
  
  // Do all your drawing here
  //if (createPath){
    for(int id = 0; id < nbPath; id++){
      create_shape(id,int(random(1,10)),int(random(1,3)),int(random(0,255)));
      shape(path[id], random(0,100), random(0,height));
    }
    
    exit();
    
    //createPath = false;
  //}
  
  if (record) {
    endRaw();
    record = false;
    //exit();
  }
}

void keyPressed() {
  // Use a key press so that it doesn't make a million files
  if (key == 's') {
    record = true;
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