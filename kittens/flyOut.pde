class flyOut
{
  public flyOut()
  {
    this(0.0, //size
         new float[]{random(width),random(height)}, //pos
         new float[]{0.0,0.0}, //vel
         0.0, //rad
         0.0); //rad speed
  }
  
  public flyOut(float sz, float[] p, float[] v, float r, float rTheta)
  {
    this.sz = sz;
    
    pos = new float[2];
    pos[0] = p[0];
    pos[1] = p[1];
    
    vel = new float[2];
    vel[0] = v[0];
    vel[1] = v[1];
    
    rads = r;
    radTheta = rTheta;
    col= new char[]{(char)(random(255)),(char)(random(255)),(char)(random(255))};//255,0,0};//
    isOffScreen = false;
  }

  public void update()
  {
    this.move();
  }
  
  public void move()
  {
    rads += radTheta;
    vel[1] += .8;
    pos[0] += vel[0];
    pos[1] += vel[1];
    //sz *= .98;
    
    if(sz < 1 || 
       pos[0] < 0 || pos[0] > width ||
       pos[1] < 0 || pos[1] > height)
         isOffScreen = true;    
  }
  
  public void draw()
  {
    if(isOffScreen)
      return;
    stroke(100);//col[0],col[1],col[2]);
    strokeWeight(3);
    fill(col[0],col[1],col[2]);//,60);
    pushMatrix();
    
    translate(pos[0],pos[1]);
    rotate(rads);
    triangle(sz,0,
             sz*cos(TWO_PI/3.0),sz*sin(TWO_PI/3.0),
             sz*cos(TWO_PI*2.0/3.0),sz*sin(TWO_PI*2.0/3.0));
    popMatrix();
  }
  
  public boolean isRemoveable()
  {
    return isOffScreen;
  }
  
  private float radTheta;
  protected float rads;
  protected float[] pos;
  protected float[] vel;
  protected float sz;
  private char[] col;
  protected boolean isOffScreen;
}
