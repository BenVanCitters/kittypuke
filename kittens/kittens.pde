import processing.opengl.*;
import ddf.minim.*;

Minim minim;
AudioInput in;
float runningMaxAmp = 0.0;    
float curMax = -10.0;
int backColor = color(0,0,0);
int animIndx = 0;
CharAnim charAnim;
BackWaveRect backWaveRect;
ParticleToss partToss;

void setup()
{
  //size(screen.width, screen.height, OPENGL);
  size(500,500,OPENGL);
  //size(500,500,P2D);//,OPENGL);
  noSmooth();
 
  minim = new Minim(this);
  // get a stereo line-in: sample buffer length of 2048
  // default sample rate is 44100, default bit depth is 16
  in = minim.getLineIn(Minim.MONO, 512); 
  
  //BackBomb(AudioInput in, float blockSz, int shiftSpeed)
  backWaveRect = new BackWaveRect();  
  partToss = new ParticleToss();
  drawBackground();
  initAnims();
}

void initAnims()
{
  int sheetCount = 2;
  int curIndex = 0;
  PImage img[] = new PImage[sheetCount];
  AnimSheet animS[] = new AnimSheet[sheetCount];
  int flags[][] = new int[sheetCount][];


  img[curIndex] = loadImage("george.jpg");
  flags[curIndex] = new int[]{1};
  animS[curIndex] = new AnimSheet(new int[][][]{{{0,0}}}, 
                                  920,1101, //wt,ht
                                  img[curIndex], //image
                                  color(255,0,0),//maskcolor
                                  flags[curIndex]); 

  curIndex = 1;
  img[curIndex] = loadImage("kitHead.jpg"); 
  flags[curIndex] = new int[]{0};
  animS[curIndex] = new AnimSheet(new int[][][]{{{0,0}}}, 
                              425, 375, //wt,ht
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
    updateAnimation();
    int animPlacement[] = getDrawPlacement();
        charAnim.changeCharacterAnim(0);
    charAnim.initAnim();
    animPlacement = getDrawPlacement();
    charAnim.draw(animPlacement[0],animPlacement[1],animPlacement[2],animPlacement[3],0);
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
  charAnim.setFrameByPercent(openPercent);  
  }
  println(curMax/runningMaxAmp);
}

//position and scale the animation image on the screen
int[] getDrawPlacement()
{
    float screenWToHRatio = 1.0*width/height;
    float animWToHRatio = 1.0*charAnim.getCurrentAnimWidth()/charAnim.getCurrentAnimHeight();
    int compW = 0;
    int compH = 0;
    int compX = 0;
    int compY = 0;
    int maxW = (int)(width*3);
    int maxH = (int)(height*1.2);
    if(animWToHRatio > screenWToHRatio)
    {
      compW = maxW;
      compX  = (int)((width-maxW)/2.0);
      compH = (int)(compW*animWToHRatio);
      compY = (int)((height - compH)/2.0);
    }
    else
    {
      compH = maxH;
      compY = (int)((height-maxH)/2.0);      
      compW = (int)(compH*animWToHRatio);
      compX = (int)((width - compW)/2.0);
    }
  return new int[]{compX,compY,compW,compH};  
}

void mousePressed()
{
  if(mouseButton == RIGHT)
  {
    int indx = ( charAnim.getCurrentSheetIndex() + 1) % charAnim.getSheetCount(); 
    charAnim.changeCharacterAnim(indx);
    charAnim.initAnim();
  }
  else
  {
   int indx = ( charAnim.getCurrentAnimIndex() + 1) % charAnim.getCurrentAnimCount(); 
   charAnim.setCurrentAnimIndex(indx);
   charAnim.initAnim();
  }

}

void drawBackground()
{
  background(0);

  float[] waveForm = in.mix.toArray();
  backWaveRect.draw(waveForm,runningMaxAmp);  
}

void stop()
{
  // always close audio I/O classes
  in.close();
  // always stop your Minim object
  minim.stop();
  super.stop();
}
