class RadialFlyOutCollection
{
  public RadialFlyOutCollection(boolean emitter, int[] animIndecies, float[] position)
  {
    flyOuts = new ArrayList<flyOut>();
    pEmitting = emitter;
    this.animIndecies = animIndecies;
    pos = position;
  }
  
  //num = number of flyouts to spawn,  scale - loudness of sound, in this case
  public void addFlyOut(int num, float sz, float[] vel)
  {
    int maxSpd = 40;
    //float center[] = ;
    float vertRad = 5;
    float horzRad = 40;
    float posTheta = random(TWO_PI);
    
    for(int i = 0; i < num; i++)
    {
      float rndSpdMult = random(maxSpd);
      float rad = random(TWO_PI);
      float posi[] = new float[]{pos[0] + cos(posTheta)*horzRad,
                              pos[1] + sin(posTheta)*vertRad};
      float velo[] = new float[]{vel[0]+.6*rndSpdMult*cos(rad),
                                vel[1]+.45*rndSpdMult*sin(rad)};
      int indx= (int)(random(animIndecies.length));
      flyOuts.add(new PukingFlyOut(animIndecies[indx], pEmitting, sz, 
                             posi,
                             velo, 
                             random(TWO_PI), 
                             random(.25)-.125));
    }
  }
  
  public void update()
  {
    for(flyOut f : flyOuts)
    {
      f.update();
    }

    Iterator it = flyOuts.iterator();
    while(it.hasNext())
    {
      flyOut tmp = (flyOut)(it.next());
      if(tmp.isRemoveable())
        it.remove();
    }
  }
  
  
  public void setPos(float[] position)
  {
    pos = position;
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
  float[] pos;
  float verticalRad;
  float horzRad;
  boolean pEmitting;
  int[] animIndecies;
}
