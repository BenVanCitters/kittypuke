class PukingFlyOut extends flyOut
{
  public PukingFlyOut(int animIndex,boolean puke, float sz, float[] p, float[] v, float r, float rDelta)
  {
    super(sz, p, v, r, rDelta);
    this.animIndex = animIndex;
    this.puking = puke;
    if(puking)
    {
      radFlyOutClctn = new RadialFlyOutCollection(false,new int[]{2,5},p);
    }
    
  }
//  public flyOut(float sz, float[] p, float[] v, float r, float rTheta)
  
  public void draw()
  {
    //do yer shit

    charAnim.changeCharacterAnim(animIndex);
    charAnim.initAnim();
    charAnim.setFrameByPercent(.5); 
    
    int animPlacement[] = this.getDrawPlacement();
    pushMatrix();
    //rotate(TWO_PI*mouseY/height);
    charAnim.draw(animPlacement[0],animPlacement[1],animPlacement[2],animPlacement[3],rads);
    //go take care of the parents business.
    popMatrix();
    //super.draw();
    if(puking)
    {
      radFlyOutClctn.draw();
    }
  }
 
  //position and scale the animation image on the screen
  int[] getDrawPlacement()
  {
    charAnim.changeCharacterAnim(animIndex);
    int tmpW = charAnim.getCurrentAnimWidth();
    int tmpH = charAnim.getCurrentAnimHeight();
  
    
    float animWToHRatio = 1.0*tmpW/tmpH;

    int compX = (int)pos[0];
    int compY = (int)pos[1];
    int compW = (int)(sz);
    int compH = (int)(sz);
    if(tmpW >tmpH)
    {
      compW = (int)(sz);
      compH = (int)(sz/animWToHRatio);
    }
    else
    {
      compH = (int)(sz);
      compW = (int)(sz*animWToHRatio);      
    }

    return new int[]{compX,compY,compW,compH};  
  }
  
  public void update()
  {
    super.update();
    if(puking)
    {
      radFlyOutClctn.setPos(pos);
      //println("pukeupdate");
      if(!isOffScreen && random(1) > .9)
        radFlyOutClctn.addFlyOut(1,100,vel);
      radFlyOutClctn.update();
    }
  }
  
  public boolean isRemoveable()
  {
    boolean isEmpty = true;
    if(puking)
    {
      isEmpty = radFlyOutClctn.getCount() < 1;
    }
    return isOffScreen && isEmpty;
  }
  
 private int animIndex; 
 private boolean puking;
 RadialFlyOutCollection radFlyOutClctn;
 //private charAnim;
}
