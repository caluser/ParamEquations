//Using Parametric Equations to get different shapes.

import controlP5.*;
ControlP5 cp5;
//CheckBox cb1, cb2;

//PImage up;
//PImage down;

void setup()
{ background(50); size(600,600); 
rectMode(CENTER);

//up=loadImage("up.png");
//down=loadImage("down.png");

  /*GUI*/
cp5 = new ControlP5(this);
    
  cp5.begin();
  
      cp5.addSlider("spd")
     .setCaptionLabel("Animation Speed")
     .setPosition(10,10)
     .setSize(200, 20)
     .setRange(0.01, 2)
     .setValue(0.4)
     .setColorForeground(color(170, 0, 0))
     .setColorBackground(color(100, 0, 0))
     .setColorActive(color(230, 0, 0))
     ;
     
 /* cb1 = cp5.addCheckBox("cb1")
     .setPosition(10,40)
     .setImage(loadImage("up.png"))
     .setSize(30, 30)
     .setItemsPerRow(5)
     .setSpacingColumn(15)
     .setSpacingRow(20)
     .setCaptionLabel("Amount of Lines")
     .addItem("+",0)
     .addItem("-",0)
    //      .setImage(loadImage("down.png"))
     ; 
   */  
 cp5.end();

}

float t=1;
float spd;
static int lines=5;
int kpress=0;
color c;


int sflag=0;    //stop.
int fillines=0;  //fill colors or seperated lines.
int flagu=0;  //upper connecting lines.
int flagd=0;  //lower connecting lines.
int joints=0;  //showing joints on lines.
int flagl=1; //showing main lines on/off.

void draw()
{
  if(fillines==0) background(20);

  
    pushMatrix();
    
  translate(width/2,height/2); //Translate all object to the center.
  if(sflag==0)
  for(int i=0; i<lines; i++){
    float r=255,g=255,b=255;
    if(kpress==1 || kpress==2){
       r=abs(cos((x1(t/10)/100))*255);
       g=abs(cos((x2(t/50)/100))*255);
       b=abs(cos((y1(t/20)/100))*255);
    }
    if(kpress==3){
       r=abs(cos(x2(t)/100)*255)-30;
       g=abs(cos(y2(t)/200)*205)-30;
       b=abs(sin(x1(t/100)/100)*255)-30;
    }
   //if(r<30) r=abs((r*5)%255);
   //if(g<30) g=abs((g*5)%255);
   //if(b<20) b=abs((b*5)%255);
  c=color(r+20, g+20, b+20);
  if(kpress==1 || kpress==2)  stroke(((r+b+g)/3)+80);
    strokeWeight(2);
  fill(c);
  rect(270,-270,25,25);
  noFill();
  stroke(c);
    strokeWeight(5);
  if(flagl==1) line(x1(t+i*5),y1(t+i*5),x2(t+i*5),y2(t+i*5));                   //Main Line
  if(i!=0) { if(flagu==1)line(x1(t+i*5),y1(t+i*5),x1(t+(i-1)*5),y1(t+(i-1)*5));  //Connecting 'upper' line
             if(flagd==1)line(x2(t+i*5),y2(t+i*5),x2(t+(i-1)*5),y2(t+(i-1)*5)); }//      ""   'lower'
 
  }
   for(int i=0; i<lines; i++)  if(joints==1){fill(255); strokeWeight(2); ellipse(x1(t+(i)*5),y1(t+(i)*5),10,10); ellipse(x2(t+(i)*5),y2(t+(i)*5),10,10); noFill(); }
  
    popMatrix();

  t+=spd;

}

float x1(float t){
switch (kpress)
{
  
            case 1:  { return 100*sin(t/10)+20*sin(t/5); }
            case 2:  { return 57*cos(t/10)+200*cos(t/50); }
            case 3:  { return 150*sin(t/33)*cos(t/900); }
            
 }//switch
       return 0;
}//x1

float y1(float t){
switch (kpress)
{
            case 1:  { return 200*sin(t/12); }
            case 2:  { return 170*cos(t/8)+cos(t*t); }
            case 3:  { return 250*sin(t/sqrt(t))*sin(t/48)*sin(t/70); }
            
 }//switch
       return 0;
}//y1

float x2(float t){
switch (kpress)
{
            case 1:  { return 200*sin(t/12)+2*sin(t/3); }
            case 2:  { return 150*cos(pow(t/100,2)/60)+100*sin(t/50); }
            case 3:  { return 250*sin(t/17)*cos(t/300)*sin(t/90); }
 
 }//switch
       return 0;
}//y1

float y2(float t)
{
switch (kpress)
{
            case 1:  { return 200*cos(t/20)+20*cos(t/20); }
            case 2:  { return 100*sin(t/50)+cos(pow(t*2,2)/10); }
            case 3:  { return 100*pow(2.72,cos(t/70))*cos(t/9); }
            
 }//switch
       return 0;
}//y1

void keyPressed(){
 if(key=='1') kpress=1; 
 else if(key=='2') { kpress=2; lines=5; }
 else if(key=='3') { kpress=3; }
 else if(key=='s') if(sflag==0) sflag=1; else sflag=0;
 else if(key=='+') if(lines<30) lines++; else return;
 else if(key=='-') if(lines>1) lines--; else return;
 else if(key=='q') if(flagu==0) flagu=1; else flagu=0;
 else if(key=='w') if(flagd==0) flagd=1; else flagd=0;
 else if(key=='j') if(joints==0) joints=1; else joints=0;
 else if(key=='l') if(flagl==0) flagl=1; else flagl=0;
}

void mousePressed()
{
  //Activate fill only if mouse is NOT above slider.
  if(mouseButton==LEFT) if(!cp5.getController("spd").isMouseOver()) { if(fillines==0) fillines=1; else fillines=0; }

}