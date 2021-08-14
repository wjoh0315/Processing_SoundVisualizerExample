import processing.sound.*;

FFT fft;
SoundFile in;
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
  in = new SoundFile(this, "test.mp3");
  
  in.rate(1);
  in.play();
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
    r2 = r + clamp(spectrum[i] * 1000, 100);
    line(
      r * cos(radians(i)) + 375, 
      r * sin(radians(i)) + 250, 
      r2 * cos(radians(i)) + 375, 
      r2 * sin(radians(i)) + 250
    );
  }
}
