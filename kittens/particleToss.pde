class ParticleToss
{
  
//  Minim minim;
//  AudioInput in;
  float runningMaxAmp = 0.0;                            
  
  RadialFlyOutCollection fOC;
  
 public ParticleToss()
  {
    //minim = new Minim(this);
    // get a stereo line-in: sample buffer length of 2048
    // default sample rate is 44100, default bit depth is 16
    //in = minim.getLineIn(Minim.MONO, 512); 
    fOC = new RadialFlyOutCollection();
    
  }
  
  public void draw(float curMax,float runningMaxAmp)
  {

    
    //if(diff > 0)
    {
      //spawn flyout    
    //  int expCount = (int)(random(10));
      //for(int i = 0; i < expCount; i++)
      {
  //      int particleCount = (int)(100.0/expCount);
        fOC.addFlyOut((int)(curMax*10/runningMaxAmp),curMax/runningMaxAmp);
      }
    }
    
    fOC.update();
    fOC.draw();          
  }
}
