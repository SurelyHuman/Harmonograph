class ColorEffect{
  float r, g, b, rs, gs, bs;
  color c;
  int R, G, B;
  float N = 0.001;
  
  ColorEffect(float rx, float gx, float bx){
    r = rs = rx;
    g = gs = gx;
    b = bs = bx;
  }
  
  color Fade(){
    if(r == 255 && b == 0 && g < 255)
      {
        g += N;
        if(g > 255) g = 255;
      }
      if(g == 255 && r > 0 && b == 0 )
      {
        r -= N;
        if (r < 0) r = 0;
      }
      if(g == 255 && r == 0 && b < 255)
      {
        b += N;
        if (b > 255) b = 255;
      }
      if(b == 255 && g > 0 && r == 0)
      {
        g -= N;
        if (g < 0) g = 0;
      }
      if(b == 255 && r < 255 && g == 0)
      {
        r += N;
        if (r > 255) r = 255;
      }
      if(r == 255 && b > 0 && g == 0)
      {
        b -= N;
        if (b < 0) b = 0;
      }
    R = round(r);
    G = round(g);
    B = round(b);
    c = color(R,G,B);
    return c;
  }
  
  void reset(){
    r = rs;
    g = gs;
    b = bs;
  }  
}  