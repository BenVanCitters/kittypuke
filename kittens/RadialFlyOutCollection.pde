class RadialFlyOutCollection
{
  public RadialFlyOutCollection()
  {
    flyOuts = new ArrayList<flyOut>();
  }
  
  //num = number of flyouts to spawn,  scale - loudness of sound, in this case
  public void addFlyOut(int num, float scale)
  {
    int maxSz = 40;
    int maxSpd = 40;
    float center[] = new float[]{width/2.0,
                              (height*2.8/10.0)};
    float vertRad = 5;
    float horzRad = 40;
    float posTheta = random(TWO_PI);
    
//    float pos[] = new float[]{center[0] + cos(posTheta)*horzRad,
//                              center[1] + sin(posTheta)*vertRad};
    for(int i = 0; i < num; i++)
    {
      float rndSpdMult = random(maxSpd);
      float rad = random(TWO_PI);
      float pos[] = new float[]{center[0] + cos(posTheta)*horzRad,
                              center[1] + sin(posTheta)*vertRad};
      float vel[] = new float[]{.6*rndSpdMult*cos(rad)*scale,
                                .45*rndSpdMult*sin(rad)*scale};
      flyOuts.add(new PukingFlyOut(1,maxSz*scale, 
                             pos,
                             vel, 
                             random(TWO_PI), 
                             random(.5)));
    }
  }
  
  public void update()
  {
    for(flyOut f : flyOuts)
    {
      f.move();
    }

    Iterator it = flyOuts.iterator();
    while(it.hasNext())
    {
      flyOut tmp = (flyOut)(it.next());
      if(tmp.isRemoveable())
        it.remove();
    }
  }
  
  public void draw()
  {
    for(flyOut f : flyOuts)
    {
      f.draw();
    }
  }
  
  public int getCount()
  {
    return flyOuts.size();
  }
  ArrayList<flyOut> flyOuts;
  float center[];
  float verticalRad;
  float horzRad;
}
