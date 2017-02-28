import processing.sound.*;

PImage anotherPi;
SinOsc oscillator;
final float vol = 0.5;
final int speed = 90;    //how many milliseconds between 2 sounds
boolean Piano = false;   //change this to hear "piano notes"
int digits = 0;
String[] PiInput;
int current;
int lastTime;
int i;
int j;
int freq;
float freqNote;

void piano(){
  float note = int(map(current, 0, 9, 48, 58));  //it is from 48 to 58 because if current is 1 the frequency will be 440hz
  freqNote = pow(2, (note - 49)/12) * 440;
  oscillator.freq(freqNote); 
}

void setup() {
  size(720, 720);
  textSize(25);
  if (speed != 0) println("Time required: ~" + 1000000/(1000/speed) + " seconds (~" + 1000000/(1000/speed)/60 + " hrs)");
  PiInput = loadStrings("pi 1M.txt");       //you can do this with any txt that is containig numbers.
  anotherPi = loadImage("Pi_image.png");    //files must be in the data folder
  oscillator = new SinOsc(this);
  oscillator.play();
  oscillator.amp(vol);
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
          
          ///piano notes
          if (Piano == true) piano();
          else{
            freq = int(map(current, 0, 9, 200, 900));
            oscillator.freq(freq);     //some digits last for more time.  
        }
          //infos 
          show();
          
          digits++;
          j++;
        }
        else {
          j = 0;
          i++;
        }
    }
    lastTime = millis();
  }
}


void mousePressed() {
  if (looping)   {
    oscillator.amp(0);
    noLoop();
  }
  else {           
    oscillator.amp(vol);
    loop();
  }
}
void keyPressed() {mousePressed();}

void show(){
  background(0);
  //apparently doing *0.5 is faster than dividing by 2
  image(anotherPi, width*0.5 - 75 , height*0.5 - 180, 50, 50);
  text("song!", width*0.5 - 15, height*0.5 - 150);
  text("Current digit: " + current, width*0.5 - 100, height*0.5 - 50);
  if (Piano == true) text("Frequency: " + freqNote + "hz", width*0.5 - 100, height*0.5);
  else {text("Frequency: " + freq + "hz", width*0.5 - 100, height*0.5);}
  text("Digits played: " + digits, width*0.5 - 100, height*0.5 + 50);
  text("Click to play/pause", width*0.5 + 100, height*0.5 + 350);
  //funWithRects();
}

void funWithRects() {
  noStroke();
  translate(width*0.5, height*0.5 + 200);
  rotate(PI);
  rect(-26, -26, 50, current*10);    //just for fun
}
