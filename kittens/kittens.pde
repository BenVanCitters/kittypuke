import java.util.Iterator;
import processing.opengl.*;
import ddf.minim.*;

Minim minim;
AudioInput in;
float runningMaxAmp = 0.0;    
float curMax = -10.0;
int backColor = color(0,0,0);
int animIndx = 0;
CharAnim charAnim;
BackTriFill backTriFill;
ParticleToss partToss;

void setup()
{
  size(displayWidth,displayHeight,OPENGL);
//size(500,500,OPENGL);
  //size(500,500,P2D);//,OPENGL);
  noSmooth();
 
 noCursor();
  minim = new Minim(this);
  // get a stereo line-in: sample buffer length of 2048
  // default sample rate is 44100, default bit depth is 16
  in = minim.getLineIn(Minim.MONO, 512); 
  
  //BackBomb(AudioInput in, float blockSz, int shiftSpeed)
  backTriFill = new BackTriFill();  
  partToss = new ParticleToss(true,new int[]{1,3,4});
  drawBackground();
  initAnims();
}

void initAnims()
{
  int sheetCount = 6;
  int curIndex = 0;
  PImage img[] = new PImage[sheetCount];
  AnimSheet animS[] = new AnimSheet[sheetCount];
  int flags[][] = new int[sheetCount][];


  img[curIndex] = loadImage("georgeanim.50.png");
  flags[curIndex] = new int[]{1};
  animS[curIndex] = new AnimSheet(new int[][][]{{{0,0},{1,0},{2,0},{3,0},
                                                 {0,1},{1,1},{2,1},{3,1}}}, 
                                  1840/4,1101/2, //wt,ht
                                  img[curIndex], //image
                                  color(255),//maskcolor
                                  flags[curIndex]); 

  curIndex = 1;
  img[curIndex] = loadImage("kitHead.bmp"); 
  flags[curIndex] = new int[]{0};
  animS[curIndex] = new AnimSheet(new int[][][]{{{0,0}}}, 
                              425, 375, //wt,ht
                              img[curIndex], //image
                              color(255),//maskcolor
                              flags[curIndex]);    
                              
  curIndex = 2;
  img[curIndex] = loadImage("cigar2.jpg"); 
  flags[curIndex] = new int[]{0};
  animS[curIndex] = new AnimSheet(new int[][][]{{{0,0}}}, 
                              600, 450, //wt,ht
                              img[curIndex], //image
                              color(255),//maskcolor
                              flags[curIndex]);                                  
  curIndex = 3;
  img[curIndex] = loadImage("kitHead1.bmp"); 
  flags[curIndex] = new int[]{0};
  animS[curIndex] = new AnimSheet(new int[][][]{{{0,0}}}, 
                              1307, 904, //wt,ht
                              img[curIndex], //image
                              color(255),//maskcolor
                              flags[curIndex]); 
  curIndex = 4;
  img[curIndex] = loadImage("kitHead2.bmp"); 
  flags[curIndex] = new int[]{0};
  animS[curIndex] = new AnimSheet(new int[][][]{{{0,0}}}, 
                              187, 131, //wt,ht
                              img[curIndex], //image
                              color(255),//maskcolor
                              flags[curIndex]); 
  
  curIndex = 5;
  img[curIndex] = loadImage("stasch1.jpg"); 
  flags[curIndex] = new int[]{0};
  animS[curIndex] = new AnimSheet(new int[][][]{{{0,0}}}, 
                              168, 59, //wt,ht
                              img[curIndex], //image
                              color(255),//maskcolor
                              flags[curIndex]); 
                              
  ArrayList<AnimSheet> sheets = new ArrayList<AnimSheet>();
  for(int i = 0; i < img.length;i++)
  {
    sheets.add(animS[i]);
  }  
  charAnim = new CharAnim(sheets);
  charAnim.initAnim();
}

void draw()
{
  updateSoundControllers();
  drawBackground();
  
  if(charAnim != null)
  {
    
    int animPlacement[];// = getDrawPlacement();
    
    charAnim.changeCharacterAnim(0);
    charAnim.initAnim();
    updateAnimation();
    animPlacement = getDrawPlacement();
    charAnim.draw(animPlacement[0],animPlacement[1],animPlacement[2],animPlacement[3],PI);
  }
  partToss.draw(curMax,runningMaxAmp);
  println("frameRate: " + frameRate );
}

void updateSoundControllers()
{
    float waveForm[] = in.mix.toArray();
    runningMaxAmp *= .999;
    float tmpMax = runningMaxAmp;
    curMax = -10.0;
    for(int i = 0; i<waveForm.length; i++)
    {
      curMax = max(curMax, abs(waveForm[i]));
      runningMaxAmp = max(runningMaxAmp,abs(waveForm[i]));  
    }    
     
    float diff = abs(tmpMax-runningMaxAmp);
}

void updateAnimation()
{  
  if(runningMaxAmp > 0)
  {    
    float openPercent = min(curMax/runningMaxAmp * 100.0, 99.0);
    //println("openPercent: " + openPercent + " curMax: " + curMax + " runningMaxAmp: " + runningMaxAmp);

    charAnim.changeCharacterAnim(0);
    //println("getCurrentAnimIndex: " + charAnim.getCurrentAnimIndex());
    charAnim.setFrameByPercent(openPercent);  
  }
  //println("curMax/runningMaxAmp: " + curMax/runningMaxAmp);
}

//position and scale the animation image on the screen
int[] getDrawPlacement()
{
    float screenWToHRatio = 1.0*width/height;
    float animWToHRatio = 1.0*charAnim.getCurrentAnimWidth()/charAnim.getCurrentAnimHeight();
    int compW = 0;
    int compH = 0;
    int compX  = (int)(width/2.0);
    int compY  = (int)(height/2.0);
    int maxW = (int)(width*3);
    int maxH = (int)(height*1.2);
    if(animWToHRatio > screenWToHRatio)
    {
      compW = maxW;
      //compX  = (int)(width/2.0);//(int)((width-maxW)/2.0);
      compH = (int)(compW*animWToHRatio);
      //compY = (int)((height - compH)/2.0);
    }
    else
    {
      compH = maxH;
      //compY = (int)(height/2.0);//(int)((height-maxH)/2.0);      
      compW = (int)(compH*animWToHRatio);
      //compX = (int)(width/2.0);//(int)((width - compW)/2.0);
    }
    //println("compX: " + compX);
  return new int[]{compX,compY,compW,compH};  
}

void drawBackground()
{
  background(0);

  //float[] waveForm = in.mix.toArray();
  backTriFill.draw();  
}

void stop()
{
  // always close audio I/O classes
  in.close();
  // always stop your Minim object
  minim.stop();
  super.stop();
}
