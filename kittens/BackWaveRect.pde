class BackWaveRect
{       

  public BackWaveRect()
  {
    float wToH =1.0;// 1.0*width/height;
    // get a stereo line-in: sample buffer length of 2048
    // default sample rate is 44100, default bit depth is 16

    blockVals = new float[blockCount];
    pg = createGraphics((int)(blockCount* wToH), blockCount,P2D);
    pg.noSmooth();
  }
  
  public void draw(float[] waveForm, float maxVal)
  { 
    int chunkW = waveForm.length/blockCount;
    
    for(int i = 0; i < blockVals.length; i++)
    {
      float blockVal = 0;
      for(int j=0; j< chunkW; j++)
      {
        blockVal += abs(waveForm[i]);
      }
      blockVals[i] = 255.0*(blockVal/chunkW)/maxVal;

    }
    pg.beginDraw();
    pg.loadPixels();
    for(int j = 0; j < pg.height-1;j++)
    {  
      for(int i = 0; i < pg.width;i++)
      {
        pg.pixels[i+j*pg.width] = pg.pixels[i+(j+1)*pg.width];
      }
    }
    for(int i = 0; i < pg.width; i++)
    {
      pg.pixels[pg.width*(pg.height-1) + i] = color(blockVals[i]);
    }
    pg.updatePixels();
    pg.endDraw();
    //size the image a little large to hide weird blurring on left and bottom
    image(pg, 0, 0, width+50, height+50);    
  }
  
  //colr should be a 'color' "object"
  void drawWaveForm(int colr, float waveForm[])
  {
    noFill();
    stroke(colr);
    strokeWeight(5);
    beginShape();  
    for(int i = 0; i < waveForm.length; i++)
    {
      vertex(1.0*i*width/waveForm.length, 
              height/2.0 * (1 + waveForm[i]));
    }
    endShape();
  }
  
  private float runningMaxAmp = 0.0;                            
  private int backColor = color(0,0,0);
  private int blockCount = 20;
  private float blockVals[];
  private PGraphics pg;
}
