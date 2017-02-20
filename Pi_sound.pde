import processing.sound.*;

SinOsc sine;
int digits = 0;
String[] PiInput;
int current;
int freq;
final float vol = 0.5;
int i;
int j; 
int lastTime;
final int speed = 100;

void setup() {
  size(720, 720);
  textSize(25);
  println("Time required: ~" + 1000000/(1000/speed) + " seconds, (~" + 1000000/(1000/speed)/60 + " hrs)");
  PiInput = loadStrings("../Pi_squares/data/pi 1M.txt");   //you can do this with any txt that is containig numbers.
  sine = new SinOsc(this);
  sine.play();
  sine.amp(vol);
}

void draw() {
  if (millis() - lastTime > speed) {
    if (i < PiInput.length) {
        char[] charsArray = new char[PiInput[i].length()];
        
        if (j < PiInput[i].length()) {
          charsArray[j] = PiInput[i].charAt(j);
  
          //from char to int
          current = int(charsArray[j]);        
          current -= 48;
  
          //println(current);
          freq = int(map(current, 0, 9, 200, 900));
          sine.freq(freq);        //some digits last for more time.
  
          background(100);
          text("Pi song!", width/2 - 50, height/2 - 150);
          text("Current digit: " + current, width/2 - 100, height/2 - 50);
          text("Frequency: " + freq + "hz", width/2 - 100, height/2);
          text("Digits played: " + digits, width/2 - 100, height/2 + 50);
          text("Click to play/pause", width/2 + 100, height/2 + 350); 

          
          //noStroke();
          //ellipse(width/2, height/2 + 200, current*10, current*10);    //just for fun
          
          digits++;
          j++;
        }
        else {
          j = 0;
          //println("Digits played: " + digits);
          i++;
        }
    }
    lastTime = millis();
  }
}

void mousePressed() {
  if (looping)   {
    sine.amp(0);
    noLoop();
  }
  else {           
    sine.amp(vol);
    loop();
  }
}