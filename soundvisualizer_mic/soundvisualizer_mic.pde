import processing.sound.*;

FFT fft;
AudioIn in;
int bands = 512;
float[] spectrum = new float[bands];
float r = 100;

float clamp(float a, float b)
{
  if (a >= b)
    return b;
    
  return a;
}

void setup()
{
  size(750, 500);
  background(255);
  
  fft = new FFT(this, bands);
  in = new AudioIn(this, 0);
  
  in.start();
  fft.input(in);
}

void draw()
{
  clear();
  background(255);
  strokeWeight(2.5);
  fft.analyze(spectrum);
  
  float r2;
  for (int i = 0; i < 360; i += 6)
  {
    r2 = r + clamp(spectrum[i] * 5000, 100);
    line(
      round(r * cos(radians(i)) + width / 2), 
      round(r * sin(radians(i)) + height / 2), 
      round(r2 * cos(radians(i)) + width / 2), 
      round(r2 * sin(radians(i)) + height / 2)
    );
  }
}
