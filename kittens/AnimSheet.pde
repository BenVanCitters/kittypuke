class AnimSheet
{
  public AnimSheet(int anim[][][], int cellW, int cellH, PImage sheet, int maskColor, int[] flags)
  {
    this.anim = anim;
    this.cellW = cellW;
    this.cellH = cellH;

    this.sheet = sheet;
    this.maskColor = maskColor;
    this.flags = flags; // one flag per animation
    initMask();
  }
  
  public int getAnimCount()
  {
    return anim.length;
  }
  
  private void initMask()
  {
    sheet.loadPixels();
      int mask[] = new int[sheet.pixels.length];
      for(int i = 0; i < sheet.pixels.length; i++)
      {
        mask[i] = (sheet.pixels[i] == maskColor) ? color(255,0,0,0) : (0xffffffff | sheet.pixels[i]);
      }
    sheet.updatePixels();
    sheet.mask(mask);
  }

  public int getAnimLength(int index)
  {
    return anim[index].length;
  }

  public int getAnimWidth()
  {
    return cellW;
  }  
  public int getAnimHeight()
  {
    return cellH;
  }  
  public void printFrame(int animIndex, int frameIndex, int x, int y, float w, float h,float theta)
  {
    noStroke();
    noFill();
    float cntr[] = new float[]{x+w/2.0,
                               y+h/2.0};
    float rad = dist(cntr[0],cntr[1],x,y);
    
    acos((w/2.0)/(rad));
    beginShape();  
      texture(sheet);
      textureMode(IMAGE);
      //upper left corner
      vertex(x,y,//cos(theta)*rad,sin(theta)*rad,
             anim[animIndex][frameIndex][0]*cellW,
             anim[animIndex][frameIndex][1]*cellH);
      //upper right corner
      vertex(x+w,y,
             (anim[animIndex][frameIndex][0]+1)*cellW,
             anim[animIndex][frameIndex][1]*cellH);
      //lower right corner
      vertex(x+w,y+h,
             (anim[animIndex][frameIndex][0]+1)*cellW, 
             (anim[animIndex][frameIndex][1]+1)*cellH);
      //lower left corner
      vertex(x,y+h,
             anim[animIndex][frameIndex][0]*cellW,
             (anim[animIndex][frameIndex][1]+1)*cellH);
    endShape();
  }
  
  public boolean isAnimRepeating(int index)
  {
    return (flags[index] & 1) != 0;
  }
  // anim[2][1][0]- 2nd anim, 1st frame x coord 
  // anim[3][5][1]- 3rd anim, 5th frame y coord  
  private int anim[][][];
  private int cellW;
  private int cellH;
  private PImage sheet;
  private int maskColor;
  private int[] flags; // one flag per animation 1 = repeat, 0 = play once
}

