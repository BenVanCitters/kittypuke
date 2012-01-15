class PukingFlyOut extends flyOut
{
  public PukingFlyOut(int animIndex,float sz, float[] p, float[] v, float r, float rTheta)
  {
    super(sz, p, v, r, rTheta);
    this.animIndex = animIndex;
  }
//  public flyOut(float sz, float[] p, float[] v, float r, float rTheta)
  
  public void draw()
  {
    //do yer shit

    charAnim.changeCharacterAnim(animIndex);
    charAnim.initAnim();
    charAnim.setFrameByPercent(.5); 
    
    int animPlacement[] = getDrawPlacement();
    pushMatrix();
    //rotate(TWO_PI*mouseY/height);
    charAnim.draw(animPlacement[0],animPlacement[1],animPlacement[2],animPlacement[3],TWO_PI*mouseY/height);
    //go take care of the parents business.
    popMatrix();
    //super.draw();
  }
 
  //position and scale the animation image on the screen
  int[] getDrawPlacement()
  {
      float screenWToHRatio = 1.0*width/height;
      float animWToHRatio = 1.0*charAnim.getCurrentAnimWidth()/charAnim.getCurrentAnimHeight();

      int compX = (int)pos[0];
      int compY = (int)pos[1];
      int compW = (int)(50);
      int compH = (int)(50);

    return new int[]{compX,compY,compW,compH};  
  }
  
 private int animIndex; 
 //private charAnim;
}
