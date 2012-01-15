class CharAnim
{
  public CharAnim(ArrayList<AnimSheet> sheets)
  {
    this.sheets = sheets;
    currentFrameIndexOffset = 0;
    currentFrameIndex = 0;
    if(this.sheets != null)
    {
      curSheet = this.sheets.get(0);
    }
  }
  
  //switches to a new sprite sheet
  private boolean changeCharacterAnim(int index)
  {
    if(this.sheets != null)
    {
      currentAnimIndex = index;
      curSheet = this.sheets.get(index);
      setCurrentAnimIndex(0);
      return curSheet != null;
    }
    return false;
  }  
  
  public void initAnim()
  {    
    long tm = millis();
    currentFrameIndexOffset = curSheet.getAnimLength(currentAnimIndex)-(int)((tm%1000)*(curSheet.getAnimLength(currentAnimIndex)/1000.0));
    updateFrameIndex(tm); //sets the current frame index
  }
  
  //these adjust the frame number 
  //maybe these should be private and called from another 'update' function?
  public void updateFrameIndex()
  {
    updateFrameIndex(millis());
  }  
  
  /**  I don't know how to write java docs
  @pct - number between 1-100
  */
  public void setFrameByPercent(float pct)
  {
    currentFrameIndex =  (int)( (pct/100.0) *(curSheet.getAnimLength(currentAnimIndex)));
  }  
  
  public void updateFrameIndex(long tm)
  {
    //TODO: figure out how to use framespeed in here
   
    if(curSheet.isAnimRepeating(currentAnimIndex) || currentFrameIndex < curSheet.getAnimLength(currentAnimIndex)-1)
    {
      currentFrameIndex =  (int)( ( (tm) %1000 ) *(curSheet.getAnimLength(currentAnimIndex)/1000.0))  ;  
      currentFrameIndex = (currentFrameIndex +currentFrameIndexOffset) % (curSheet.getAnimLength(currentAnimIndex) );
    }      
  }
  
  public boolean isCurrentAnimFinished()
  {
    //the anim should have the flag set and it should be on the last frame to be considered 'done'
    return (!curSheet.isAnimRepeating(currentAnimIndex) && (currentFrameIndex == curSheet.getAnimLength(currentAnimIndex)-1));
  }
  
  public void draw(int x, int y, int wt, int ht,float theta)
  {      
    //printFrame(int animIndex, int frameIndex, int x, int y, float w, float h)
    //updateFrameIndex();
    curSheet.printFrame(currentAnimIndex, currentFrameIndex, x,y,wt,ht,theta);
  }
  
  public boolean setCurrentAnimIndex(int index)
  {
    if( index <= curSheet.getAnimCount() )
    {
      currentAnimIndex = index;
      return true;
    }
    return false;
  }
  
  public int getCurrentAnimIndex()
  {
    return currentAnimIndex;
  }
  
  public int getCurrentSheetIndex()
  {
    return sheets.indexOf(curSheet);
  }

  public int getSheetCount()
  {
    return sheets.size();
  }
  
  public int getCurrentAnimCount()
  { 
    return curSheet.getAnimCount();
  }  

  public int getCurrentAnimWidth()
  { 
    return curSheet.getAnimWidth();
  }  
  
  public int getCurrentAnimHeight()
  { 
    return curSheet.getAnimHeight();
  }  
  
  private int frameSpeed =1000;
  private ArrayList<AnimSheet> sheets;
  private int currentFrameIndex;
  private int currentFrameIndexOffset;
  private int currentAnimIndex;
  private AnimSheet curSheet;
}
