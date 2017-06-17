//import java.util.Date;
import java.text.SimpleDateFormat;

int processTimestamp(String timestampMs, String lastTimestampMs){
  
  int last = convert_UTC_to_INT(lastTimestampMs);
  int first = convert_UTC_to_INT(timestampMs);
  
  int delay_btw_timestamp = (first - last)/1000;
  
  if(delay_btw_timestamp < 0){
   delay_btw_timestamp = -delay_btw_timestamp;
  }

  //println(delay_btw_timestamp/tempo);
  return delay_btw_timestamp/tempo;
}

int convert_UTC_to_INT(String timestampMs){
  String timestamp = timestamp_to_UTC(timestampMs);
  String[] m = match(timestamp, "^(\\d{4})(\\d{2})(\\d{2}):(\\d{2}):(\\d{2}):(\\d{2})\\.(\\d{3})$");
    
  int year = int(m[1]);
  int month = int(m[2]);
  int day = int(m[3]);
    
  int hours = int(m[4]);
  int minutes = int(m[5]);
  int seconds = int(m[6]);
  int millisecs = int(m[7]);
   
  int currentmillis = hours*minutes*seconds*1000+millisecs;
  
  String date = "Nous somme le "+day+"/"+month+"/"+year+" il est "+hours+"h"+minutes+" et "+seconds+"s";
  println(date);
  
  return currentmillis;
}

String timestamp_to_UTC(String timestampMs) {
  long timestamp = Long.parseLong(timestampMs);
  try {
    String date = new SimpleDateFormat("yyyyMMdd:HH:mm:ss.SSS").format(timestamp); 
    return date;
  }
  catch (Exception e) {
    return "Unknow Date Format";
  } 
}