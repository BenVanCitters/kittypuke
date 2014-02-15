class ParticleToss
{
  
//  Minim minim;
//  AudioInput in;
  float runningMaxAmp = 0.0;                            
  
  RadialFlyOutCollection fOC;
  
 public ParticleToss(boolean isEmitter, int[] animIndecies)
  {
    fOC = new RadialFlyOutCollection(isEmitter,animIndecies,new float[]{width/2.0,
                                                            (height*4.0/10.0)});
  }
  
  public void draw(float curMax,float runningMaxAmp)
  {
    //for(int i = 0; i < expCount; i++)
//    int particleCount = (int)(100.0/expCount);
    fOC.addFlyOut((int)(curMax*3/runningMaxAmp), //number
                        170, //sz
                        new float[]{0.0,0.0}); //velocity   
    fOC.update();
    fOC.draw();          
  }
}
