class BackTriFill
{       
  public BackTriFill()
  {
    float wToH =1.0;// 1.0*width/height;
    this.curTheta = random(TWO_PI);  
    this.delta = random(.125/8)-.125/16;  
    this.divs = 50;
   // pg = createGraphics(200, 200,OPENGL);
    //pg.noSmooth();
  }
  
  
  /*
  public void draw()
  { 
    //max length is the diagonal divided by two
    float len = sqrt(pg.width*pg.width + pg.height*pg.height);
    curTheta += delta;
    float cnter[] = new float[]{pg.width/2.0,
                                pg.height/3.0};
    pg.beginDraw();
    pg.background(color(255,0,0));
    pg.fill(color(0,255,0));
    float radsPerDiv = 1.0*TWO_PI/(divs/2.0);
    pg.beginShape(TRIANGLES);
    for(int i = 0; i < divs; i++)
    {
      pg.vertex(cnter[0],cnter[1]);
      pg.vertex(cnter[0] + cos(curTheta+i*radsPerDiv)*len,
                cnter[1] + sin(curTheta+i*(radsPerDiv))*len);
      pg.vertex(cnter[0] + cos(curTheta+(i+.5)*radsPerDiv)*len,
                cnter[1] + sin(curTheta+(i+.5)*radsPerDiv)*len);
    }
    pg.endShape();
    pg.endDraw();
    //size the image a little large to hide weird blurring on left and bottom
    image(pg, 0, 0);//, width, height);    
  }
  */
  public void draw()
  { 
    //max length is the diagonal divided by two
    float len = sqrt(width*width + height*height);
    curTheta += delta;
    float cnter[] = new float[]{width/2.0,
                                height/3.0};

    background(color(255,0,0));
    fill(color(0,255,0));
    float radsPerDiv = 1.0*TWO_PI/(divs/2.0);
    beginShape(TRIANGLES);
    for(int i = 0; i < divs; i++)
    {
      vertex(cnter[0],cnter[1]);
      vertex(cnter[0] + cos(curTheta+i*radsPerDiv)*len,
                cnter[1] + sin(curTheta+i*(radsPerDiv))*len);
      vertex(cnter[0] + cos(curTheta+(i+.5)*radsPerDiv)*len,
                cnter[1] + sin(curTheta+(i+.5)*radsPerDiv)*len);
    }
    endShape();
    
    //size the image a little large to hide weird blurring on left and bottom
//    image(pg, 0, 0);//, width, height);    
  }
  
  private float curTheta = 0.0;  
  private float delta = 0.0;  
  private int divs;
  private int backColor = color(0,0,0);
  private PGraphics pg;
}
