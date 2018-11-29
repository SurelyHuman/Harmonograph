class Harmonograph{
  float a, b;
  int x, y, scale, t;
  color c;
  float time = 0;
  int[] data = new int[2];
  ColorEffect fader = new ColorEffect(255, 0, 0);
  
  Harmonograph(){
    
  }
  
  void drawHarmonograph(float a1, float a2, float f1, float f2, float p1, float p2, float pr, float d1, float d2, float dr){
    for(int i = 0; i <= 1000; i++){
      c = fader.Fade();
      time += 0.000005;
      a = ((a1 * sin(time * f1 + p1)) * (exp(-d1 * time))) + ((a1 * sin(time *f1 + p1)) * (exp(-d1 * time)));
      b = ((a2 * sin(time * f2 + p2)) * (exp(-d2 * time))) + ((a2 * sin(time *f2 + p2)) * (exp(-d2 * time)));
      x = round(((a * cos(time * pr)) + (b * sin(time * pr))) * exp(-dr * time));
      y = round(((b * cos(time * pr)) - (a * sin(time * pr))) * exp(-dr * time));
      x = x + 540;
      y = y + 540;
      set(x, y, c);
    }
  }
  
  void reset(){
    x = 0 + 540;
    y = 0 + 540;
    time = 0;
    fader.reset();
  }
  
  int getX() {
    return x;
  }
  
  int getY() {
    return y;
  }  
}  