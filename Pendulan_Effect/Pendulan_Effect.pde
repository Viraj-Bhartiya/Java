float[] frequencies;      // Holds the frequencies of each pendulum
PVector[] positions;      // Holds the position of the balls that simulate the pendulum bobs
float amplitude;          // How far left and right the balls move
float freqMult = 0.001;   // This frequency multiplier makes the system complete a whole period in 1000 frames.
int totalPen;             // The total number of pendulums/balls


boolean total20 = true;      // Are there 20 balls? If false, there are 40.
boolean prevTotal20 = true;  // Is the value of total20 on the previous frame 20? This is for switching between 20 and 40 pendulums.
float xPos, yPos;            // x- and y-positions of the pendulums

float xCenter;              // For alignig the systems of pendulums in the x-direction
float boxHeight;            // The y-height of the invisible box that the balls exist in; for display purposes.

float two_pi = 6.283185307;

// Drawing options
boolean draw1 = true;
boolean draw2 = true;
boolean draw3 = true;
boolean drawBalls = true;
boolean alignSin = true;

// TIME
float timeValue=0;
float timeSpeed=1.5; //pendulam Speed 

boolean debugOn = false;

// BUTTONS
int clickCount = 0; // so a button is activated only once per click
Button ballButton, numBallsButton, line1Button, line2Button, line3Button, labelButton;
Button pauseButton, speedButton;



void setup() {
  fullScreen();
  frameRate(30);
  amplitude = width/8;
  setupPendulum();
  setupButtons();
}


void draw() {
  background(0);

  // Buttons...
  displayButtons();
  displayButtonLabels();
  displayPhaseCircle();


  if (debugOn) {
    debug();
  }


  calculatePositions();

  if (labelButton.state) {
    drawGuides();
    drawLabels();
  }

  if (line3Button.state) {
    drawLine(3, color(230, 180, 70));
  }
  if (line2Button.state) {
    drawLine(2, color(230, 115, 70));
  }
  if (line1Button.state) {
    drawLine(1, color(230, 70, 65));
  }


  setBobColor();



  if (ballButton.state) {
    // This loop draws the 'bobs'. 
    for (int i = 0; i<totalPen; i++) {
      ellipse(positions[i].x, positions[i].y, 15, 15); //pendulam bob
    }
  }


  totalPenChange();

  incrementTime();

  /*
  if(frameCount % 2 == 0){
   saveFrame("save2color/####.png");
   }*/
}// end draw






class Button {
  int x, y, w, h;
  String label, shortcut;
  String onText, offText;
  color onColorFore, offColorFore;
  color onColorBack, offColorBack;
  boolean state;
  float labelWidth;

  Button(int x_, int y_, int w_, int h_, String label_, String shortcut_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    label = label_;
    shortcut = shortcut_;
    state = true;
    textSize(16);
    labelWidth = textWidth(label);

    onColorFore = color(255, 200);
    onColorBack = color(255, 100);

    offColorFore = color(0, 230);
    offColorBack = color(100, 180);

    onText = "on";
    offText = "off";
  }


  void update() {
    if (clickCount == 0) {
      if (over()) {
        if (mousePressed==true) {
          state =! state;
          clickCount++;
        }
      }
    }
    display();
  }


  void display() {

    textAlign(CENTER, CENTER);
    textSize(16);



    if (state==true) {
      noStroke();
      fill(onColorBack);
      rect(x, y, w, h);
      fill(onColorFore);
      text(onText, x+w/2, y+h/2);
    } else {
      noStroke();
      fill(offColorBack);
      rect(x, y, w, h);
      fill(offColorFore);
      text(offText, x+w/2, y+h/2);
    }

    textAlign(LEFT, CENTER);


    if (state) {
      fill(255, 160);
    } else {
      fill(255, 80);
    }
    text(label, x+w+6, y + h/2);


    textAlign(CENTER, CENTER);
    text(shortcut, x-28, y + h/2);
  }


  boolean over() {
    if (mouseX >= x -33 && mouseX <= x + w + 6 + labelWidth && mouseY >= y && mouseY <= y + h)
    {
      return true;
    } else {
      return false;
    }
  }
}
void setBobColor() {
  // stroke(10);
  noStroke();
  fill(255, 255);
  strokeWeight(1);
}

// This function draws lines that connect the pendulums
void drawLine(int n, color c) {
  strokeWeight(1.7); //joining lines weight
  stroke(c);
  for (int i=0; i<totalPen-n; i++) {
    line(positions[i].x, positions[i].y, positions[i+n].x, positions[i+n].y);
  }
}


// This function allows time to progress at a slow or fast rate, or pause
void incrementTime() {
  if (pauseButton.state==false) {
    if (speedButton.state==false) {
      timeValue += timeSpeed;
    } else {
      timeValue += timeSpeed*2;
    }
  }
}


// This function sets up the frequency and position arrays for the pendulums
void setupPendulum() {

  xCenter = 6*width/10 + 85;
  boxHeight = height-25;

  if (total20) {
    totalPen = 20;
    freqMult = 0.001;
  } else {
    totalPen = 40;
    freqMult = 0.0005;
  }

  frequencies = new float[totalPen];
  positions = new PVector[totalPen];

  for (int i = 0; i< totalPen; i++) {
    frequencies[i] = (i+1) * freqMult;
  }
}

// Has the state of the "Number of pendulums" button changed? If so, run the setupPendulum() function
void totalPenChange() {
  total20 = numBallsButton.state;
  if (total20 == prevTotal20) {
    setupPendulum();
  }
  prevTotal20 = total20;
}

// Draw the horizontal lines underneath each of the pendulums
void drawGuides() {
  strokeWeight(1);
  stroke(255, 30);
  for (int i = 0; i<totalPen; i++) {
    line(xCenter-amplitude, positions[i].y, xCenter+amplitude, positions[i].y);
  }
}

// Draw the text labels above and two the right of the pendulums
void drawLabels() {
  textSize(12);
  fill(255, 70);
  for (int i = 0; i<totalPen; i++) {
    textAlign(CENTER, CENTER);
    text(i+1, xCenter+amplitude + 27, positions[i].y);
  }

  int yOffset;

  if (total20) {
    yOffset = 20;
  } else {
    yOffset = 15;
  }
  text("freq.", xCenter+amplitude + 27, yOffset);
  text("pendulum", xCenter, yOffset);
}

// setup the buttons used to control the simulation.
void setupButtons() {
  int x = 110;
  int y = 210;
  int w = 40;
  int h = 30;
  int yGap = 32;
  int drawGap = 0;


  ballButton = new Button(x, y+yGap*0+drawGap, w, h, "pendulums", "0");
  numBallsButton = new Button(x, y+yGap*4+8, w, h, "number of pendulums", "N");
  numBallsButton.onText = "20";
  numBallsButton.offText = "40";
  line1Button = new Button(x, y+yGap*1+drawGap, w, h, "line 1", "1");
  line2Button = new Button(x, y+yGap*2+drawGap, w, h, "line 2", "2");
  line3Button = new Button(x, y+yGap*3+drawGap, w, h, "line 3", "3");
  labelButton = new Button(x, y+yGap*5+drawGap + 8, w, h, "labels", "L");
  // labelButton.state = false;
  pauseButton = new Button(x, y+yGap*6 + 70, w, h, "pause", "P");
  pauseButton.state = false;
  speedButton = new Button(x, y+yGap*7 + 70, w, h, "speed", "S");
  speedButton.onText = "fast";
  speedButton.offText = "slow";
  speedButton.state = false;
}

// Draw the labels that annotate the buttons
void displayButtonLabels() {
  // x and y should match x and y in setupButtons();
  int x = 110;
  int y = 210;

  textSize(16);
  fill(255, 255);
  textAlign(LEFT, TOP);
  text("Drawing options", x, y-30);

  text("Triming options", x, y+232);



  textAlign(CENTER, TOP);
  textSize(12);
  textLeading(11); 
  fill(255, 100);
  text("short\ncut", x-30, y-32);

  stroke(255, 70);
  strokeWeight(1);
  line(x, y-9, x+220, y-9 );
  line(x, y+253, x+130, y+253);
}



void displayButtons() {
  ballButton.update();
  numBallsButton.update();
  line1Button.update();
  line2Button.update();
  line3Button.update();
  labelButton.update();
  pauseButton.update();
  speedButton.update();
}


// This circle simply displays the phase of the system. When the indictor line makes a complete revolution, the pendulum-system repeats itself.
void displayPhaseCircle() {
  float x = 163;
  float y = 640;
  float d = 60;
  float angle = timeValue*freqMult*two_pi - two_pi/4;

  textSize(16);
  textAlign(LEFT, CENTER);
  fill(255, 255);
  text("Phase", 110, y - d/2 -35);
  // text("phase", x, y-12);

  stroke(255, 70);
  strokeWeight(1);
  line(110, y - d/2 - 24, 110+105, y - d/2 - 24);


  strokeWeight(1);
  stroke(255, 100);
  fill(255, 30);
  ellipseMode(CENTER);
  ellipse(x, y, d, d);

  // Tick marks
  strokeWeight(1);
  stroke(255, 100);
  float tick = 0.8;
  line(x, y-tick*d/2, x, y-d/2); // zero or two-pi (top of circle);
  line(x + tick*d/2, y, x+d/2, y); // pi/2
  line(x, y+tick*d/2, x, y+d/2);  // pi
  line(x- tick*d/2, y, x-d/2, y);  // 3pi/2

  textSize(12);
  fill(255, 150);
  textAlign(CENTER, CENTER);
  text("0", x+1, y -d/2 -10);
  // text("π/2", x+d/2 + 15, y-2);
  text("π", x, y + d/2 + 8);
  //text("3π/2", x-d/2-17, y-2);


  // 3pi/2 on two lines so it looks nicer
  text("3π", x-d/2-14, y-8);
  text("2", x-d/2-14, y+6);
  stroke(255, 100);
  strokeWeight(1);
  line(x-d/2-22, y, x-d/2-6, y);

  // pi/2 on two lines so it looks nicer
  text("π", x+d/2+12, y-8);
  text("2", x+d/2+12, y+6);
  stroke(255, 100);
  strokeWeight(1);
  line(x+d/2+18, y, x+d/2+6, y);

  // Indicating line...the vertical spacing will depend on how the font is rendered...can be iffy. 
  strokeWeight(2);
  stroke(255, 200);
  line(x, y, x+(d/2)*cos(angle), y+(d/2)*sin(angle));
}

void debug() {
  fill(255);
  textSize(12);
  textAlign(LEFT);
  text("FPS: "+nf(frameRate, 2, 1), 12, 15);
  text("frame number: "+frameCount, 12, 27);
  text("time value: "+nfc(timeValue, 1), 12, 39);
  text("Hit 'D' to hide.", 12, 51);
}

void calculatePositions() {
  // This loop calculates the position of all the 'bobs' (or "balls" or "pendulums") for this current frame
  for (int i = 0; i< totalPen; i++) {
    yPos = (i+1) * ((float)boxHeight/(totalPen+1)) + 25; 
    if (alignSin==true) {
      xPos = xCenter + amplitude * sin(frequencies[i]*timeValue*two_pi);
    } else {
      xPos = xCenter + amplitude * cos(frequencies[i]*timeValue*two_pi);
    }
    positions[i] = new PVector(xPos, yPos);
  }
}

void keyPressed() {
  if (key=='1') {
    line1Button.state =! line1Button.state;
  }

  if (key =='2') {
    line2Button.state =! line2Button.state;
  }
  if (key =='3') {
    line3Button.state =! line3Button.state;
  }
  if (key =='`'|| key=='0') {
    ballButton.state =! ballButton.state;
  }  
  if (key ==' ' || key == 'p' || key == 'P') {
    //paused =! paused;
    pauseButton.state =! pauseButton.state;
  }

  if (key == 's' || key=='S') {
    //timeSlow =! timeSlow;
    speedButton.state =! speedButton.state;
  }

  if (key =='n' || key == 'N') {
    numBallsButton.state =! numBallsButton.state;
  }

  if (key == 'l' || key == 'L') {
    labelButton.state =! labelButton.state;
  }
  if (key == 'd' || key == 'D') {
    debugOn =! debugOn;
  }
  if (key =='r' || key == 'R') {
    saveFrame();
  }
  if (key == 'q'|| key == 'Q') {
    alignSin =! alignSin;
  }
}



void mouseReleased() {
  clickCount = 0;
}
