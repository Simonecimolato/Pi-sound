import processing.sound.*;

PImage anotherPi;
SinOsc oscillator;
final float vol = 0.5;
final int speed = 90;    //how many milliseconds between 2 sounds
boolean Piano = false;   //change this to hear "piano notes"
int digits = 0;
String[] constant;
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
  textSize(height/29);  //putting this in draw() will cause a delay during the first draw loop
  constant = loadStrings("pi 1M.txt");       //you can do this with any txt that is containig numbers.
  surface.setResizable(true);
  if (speed != 0) {
    for (int k = 0; k < constant.length; k++) {        
        for (int w = 0; w < constant[k].length(); w++) {
          digits++;
        }
    }
    println("It will take ~" + digits/(1000/speed) + " seconds (~" + digits/(1000/speed)/60 + " hrs) to play " + digits + " digits.");
  }
  anotherPi = loadImage("Pi_image.png");    //files must be in the data folder
  oscillator = new SinOsc(this);
  oscillator.play();
  oscillator.amp(vol);
  digits = 0;
}

void draw() {
  if (millis() - lastTime > speed) {
    if (i < constant.length) {
        char[] charsArray = new char[constant[i].length()];
        
        if (j < constant[i].length()) {
          charsArray[j] = constant[i].charAt(j);
  
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
          info();
          
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

void keyPressed() {
  Piano = !Piano;
}

void info(){
  background(0);
  //apparently doing *0.5 is faster than dividing by 2
  image(anotherPi, width*0.5 - 75 , height*0.5 - 180, 50, 50);
  text("song!", width*0.5 - 15, height*0.5 - 150);
  text("Current digit: " + current, width*0.5 - 100, height*0.5 - 50);
  if (Piano == true) {
    text("Frequency: " + freqNote + "hz", width*0.5 - 100, height*0.5);  
    text("Piano mode", 10, 25);
  }
  else {
    text("Frequency: " + freq + "hz", width*0.5 - 100, height*0.5);
    text("Normal mode", 10, 25);
  }
  text("Digits played: " + digits, width*0.5 - 100, height*0.5 + 50);
  text("Mouse: play/pause", width - 230, height - 10);
  text("Keyboard: switch mode", 10, height - 10);
  //funWithRects();
}

void funWithRects() {
  noStroke();
  translate(width*0.5, height*0.5 + 200);
  rotate(PI);
  rect(-26, -26, 50, current*10);    //just for fun
}
