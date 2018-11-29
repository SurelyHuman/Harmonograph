import processing.sound.*;
import controlP5.*;

TriOsc tri;
SawOsc saw;
SqrOsc sqr;
Reverb reverb;

float freq=0;
float amp=0.5;
float pos;

ControlP5 cp5, cp5_1;
Accordion accordion;
CheckBox checkbox;
Group g1;
Group g2;
Group g3;
boolean Start = false;

Harmonograph har = new Harmonograph();

public void settings() {
  size(1080, 1080);
  smooth(4);
}

void setup(){
  background(0);
  //size(1080, 1080);
  //fullScreen(FX2D);
  frameRate(20);
  noStroke();
  fill(0);
  gui();
  tri = new TriOsc(this);
  tri.play();
  saw = new SawOsc(this);
  saw.play();
  sqr = new SqrOsc(this);
  sqr.play();
  reverb = new Reverb(this);
  reverb.process(tri);
  reverb.room(0.55);
}

void gui(){
  
  cp5 = new ControlP5(this);
  cp5_1 = new ControlP5(this);
  
  cp5.addToggle("Start")
     .setPosition(1015, 10)
     .setSize(50, 20)
     .setColorBackground(color(120))
     .setColorActive(color(80))
     .setValue(false)
     .setMode(ControlP5.SWITCH)
     ;
     
  cp5_1.addBang("reset")
     .setPosition(960, 10)
     .setSize(50, 20)
     .setColorActive(color(120))
     .setColorForeground(color(80))
     .setTriggerEvent(Bang.RELEASE)
     .setLabel("Reset")
     ; 
  
  // group number 1, contains sliders
  g1 = cp5.addGroup("Parameters")
                .setColorBackground(color(102))
                .setBackgroundColor(color(60,120))
                .setBackgroundHeight(205)
                ;
                
  cp5.addSlider("Amplitude1")
     .setPosition(5,5)
     .setSize(140,15)
     .setValue(90)
     .setColorActive(color(180))
     .setColorBackground(color(120))
     .setColorForeground(color(80))
     .setRange(1.0, 180.0)
     .setGroup(g1)
     ;
     
  cp5.addSlider("Amplitude2")
     .setPosition(5,25)
     .setSize(140,15)
     .setValue(90)
     .setColorActive(color(180))
     .setColorBackground(color(120))
     .setColorForeground(color(80))
     .setRange(1.0, 180.0)
     .setGroup(g1)
     ;
     
  cp5.addSlider("Frequency1")
     .setPosition(5,45)
     .setSize(140,15)
     .setValue(500)
     .setColorActive(color(180))
     .setColorBackground(color(120))
     .setColorForeground(color(80))
     .setRange(1.0, 1000.0)
     .setGroup(g1)
     ;
 
  cp5.addSlider("Frequency2")
     .setPosition(5,65)
     .setSize(140,15)
     .setValue(500)
     .setColorActive(color(180))
     .setColorBackground(color(120))
     .setColorForeground(color(80))
     .setRange(1.0, 1000.0)
     .setGroup(g1)
     ;
  
  cp5.addSlider("Phase1")
     .setPosition(5,85)
     .setSize(140,15)
     .setValue(0.5)
     .setColorActive(color(180))
     .setColorBackground(color(120))
     .setColorForeground(color(80))
     .setRange(0.0, 1.0)
     .setGroup(g1)
     ;
     
  cp5.addSlider("Phase2")
     .setPosition(5,105)
     .setSize(140,15)
     .setValue(0.5)
     .setColorActive(color(180))
     .setColorBackground(color(120))
     .setColorForeground(color(80))
     .setRange(0.0, 1.0)
     .setGroup(g1)
     ;
  
  cp5.addSlider("Phase_R")
     .setPosition(5,125)
     .setSize(140,15)
     .setValue(0.50)
     .setColorActive(color(180))
     .setColorBackground(color(120))
     .setColorForeground(color(80))
     .setRange(0.0, 1.0)
     .setGroup(g1)
     ;
  
 cp5.addSlider("Decay1")
    .setPosition(5,145)
    .setSize(140,15)
    .setValue(0.50)
    .setColorActive(color(180))
    .setColorBackground(color(120))
    .setColorForeground(color(80))
    .setRange(0.0, 1.0)
    .setGroup(g1)
    ;
    
 cp5.addSlider("Decay2")
    .setPosition(5,165)
    .setSize(140,15)
    .setValue(0.50)
    .setColorActive(color(180))
    .setColorBackground(color(120))
    .setColorForeground(color(80))
    .setRange(0.0, 1.0)
    .setGroup(g1)
    ;
    
 cp5.addSlider("Decay_R")
    .setPosition(5,185)
    .setSize(140,15)
    .setValue(2.50)
    .setColorActive(color(180))
    .setColorBackground(color(120))
    .setColorForeground(color(80))
    .setRange(-0.05, 5.000)
    .setGroup(g1)
    ;
  
  // group number 2, contains checkboxes and a bang
  g2 = cp5.addGroup("Audio")
                .setColorBackground(color(102))
                .setBackgroundColor(color(60,120))
                .setBackgroundHeight(175)
                ;
                
  checkbox = cp5.addCheckBox("checkBox")
                .setPosition(5, 5)
                .setSize(40, 40)
                .setColorActive(color(120))
                .setColorForeground(color(120))
                .setColorBackground(color(80))
                .setItemsPerRow(1)
                .setSpacingColumn(30)
                .setSpacingRow(20)
                .addItem("Tri_Reverb", 1)
                .addItem("Saw", 1)
                .addItem("Sqr", 1)
                .setGroup(g2)
                ;              
                
  // group number 3, contains a bang
  g3 = cp5.addGroup("Randomize")
                .setColorBackground(color(102))
                .setBackgroundColor(color(60,120))
                .setBackgroundHeight(150)
                ;              
                
  // change the trigger event, by default it is PRESSED.
  cp5.addBang("bang")
     .setPosition(5, 5)
     .setSize(190, 125)
     .setColorActive(color(120))
     .setColorForeground(color(80))
     .setTriggerEvent(Bang.RELEASE)
     .setLabel("Random")
     .setGroup(g3)
     ;              
                
  // create a new accordion
  // add g1, g2, and g3 to the accordion.
  accordion = cp5.addAccordion("Menu")
                 .setPosition(860,50)
                 .setWidth(205)
                 .addItem(g1)
                 .addItem(g2)
                 .addItem(g3)
                 ;              
                
  cp5.mapKeyFor(new ControlKey() {public void keyEvent() {accordion.open(0,1,2);}}, 'o');
  cp5.mapKeyFor(new ControlKey() {public void keyEvent() {accordion.close(0,1,2);}}, 'c');  
  accordion.open(0,1,2);
  
  // use Accordion.MULTI to allow multiple group 
  // to be open at a time.
  accordion.setCollapseMode(Accordion.MULTI);  
}

void draw(){
  tri.freq(0);
  saw.freq(0);
  sqr.freq(0);
  fill(102);
  if(Start == false){  
    har.reset();
    accordion.setVisible(true);
    cp5_1.setVisible(true);
    background(0);
  }
  else{
    if (accordion.isVisible()){
      accordion.setVisible(false);
      cp5_1.setVisible(false);
      background(0);
    }
    har.drawHarmonograph(cp5.getController("Amplitude1").getValue(),cp5.getController("Amplitude2").getValue(), cp5.getController("Frequency1").getValue(), 
                                            cp5.getController("Frequency2").getValue(), cp5.getController("Phase1").getValue(), cp5.getController("Phase2").getValue(), cp5.getController("Phase_R").getValue(), 
                                            cp5.getController("Decay1").getValue(), cp5.getController("Decay2").getValue(), cp5.getController("Decay_R").getValue());                                           
    amp = map(har.getY(), 0, height, 1.0, 0.0);
    freq = map(har.getX(), 0, width, 80.0, 1000.0);
    pos = map(har.getX(), 0, width, -1.0, 1.0);
    if (checkbox.getArrayValue()[0] == 1) {
      tri.amp(amp);
      tri.freq(freq);
      tri.pan(pos);
    }
    if (checkbox.getArrayValue()[1] == 1) {
      saw.amp(amp);
      saw.freq(freq);
      saw.pan(pos);
    }
    if (checkbox.getArrayValue()[2] == 1) {
      sqr.amp(amp);
      sqr.freq(freq);
      sqr.pan(pos);
    }
  } 
  println(frameRate);
}

void reset(){
  String[] sliders = {"Amplitude1", "Amplitude2", "Frequency1", "Frequency2", "Phase1", "Phase2", "Phase_R", "Decay1", "Decay2", "Decay_R"};
  float[] o_values = {90, 90, 500, 500, 0.5, 0.5, 0.5, 0.5, 0.5, 2.50};
  for (int i = 0; i < sliders.length; ++i){
    cp5.getController(sliders[i]).setValue(o_values[i]);
  }
} 

void shuffle(){
  String[] sliders = {"Amplitude1", "Amplitude2", "Frequency1", "Frequency2", "Phase1", "Phase2", "Phase_R", "Decay1", "Decay2", "Decay_R"};
  float[] randy = {random(1.0,180), random(1.0,180), random(1.0,1000), random(1.0,1000), random(0.0,1.0), random(0.0, 1.0), random(0.0, 1.0), random(0.0, 1.0), random(0.0, 1.0), random(-0.05, 5.000)};
  for (int i = 0; i < sliders.length; ++i){
    cp5.getController(sliders[i]).setValue(randy[i]);
  }
}

public void bang() {
  shuffle();
}
