import processing.sound.*;

SinOsc oscillator;
final float vol = 0.5;
final int speed = 100;
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
  println("Time required: ~" + 1000000/(1000/speed) + " seconds (~" + 1000000/(1000/speed)/60 + " hrs)");
  PiInput = loadStrings("../Pi_squares/data/pi 1M.txt");       //you can do this with any txt that is containig numbers.
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
          
          /*piano notes
            piano();
            piano = comment the following 2 lines and uncomment the previous line + change the variable to display in the show() function
            */
          
          freq = int(map(current, 0, 9, 200, 900));
          oscillator.freq(freq);                  //some digits last for more time.
          
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

void show(){
  background(128);
          text("Pi song!", width/2 - 50, height/2 - 150);
          text("Current digit: " + current, width/2 - 100, height/2 - 50);
          text("Frequency: " + freq + "hz", width/2 - 100, height/2);
          text("Digits played: " + digits, width/2 - 100, height/2 + 50);
          text("Click to play/pause", width/2 + 100, height/2 + 350);
          //noStroke();
          //ellipse(width/2, height/2 + 200, current*10, current*10);    //just for fun
}

