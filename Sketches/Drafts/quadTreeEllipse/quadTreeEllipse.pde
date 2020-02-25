PImage img;
PImage img2;
int count=0;
float tt=0;
PGraphics canvas;
float ran = random(10);

void setup() {
    frameRate(30);
    size(600, 600);
    canvas = createGraphics(600, 600);
    //canvas = createCanvas(window.innerWidth, window.innerHeight);
    //canvas.parent('canvas');
    //canvas.drawingContext.imageSmoothingEnabled=false;

  //createCanvas(500, 500);
}

void draw() {
  background(255);
  
  split0(canvas.width, canvas.height);
  
  count=0;
  tt+=1;

  //if(tt%20==0) ran = Math.random() * 10;
}

void split0(int w, int h){
    split1(0,0,w,h,0);
}

void split1(int x, int y, int w, int h, int n){
    randomSeed(int(count + ran));

  //if( (random()<0.2 && n>3) || n > ((tt*0.01)%20) ){
  if( n > 4 ){

    if((count+n)%2==0){
      fill(255,0,0);
      stroke(255);
      ellipse(x+w/2, y+h/2, w, h);
    }else{
      fill(255,0,0);
      stroke(255);      
      ellipse(x+w/2, y+h/2, w, h);
    }

  }else{
    
    float rr = 0.5+0.5 * sin(3*(tt*0.01));
    rr = Math.max(Math.min(rr,1),0);

    float ww = w*rr;
    float ww2 = w*(1-rr);

    rr = 0.5+0.5 * sin(4*(tt*0.01));
    rr = Math.max(Math.min(rr,1),0);

    float hh = h*rr;
    float hh2 = h*(1-rr);
    

    if(count % 2 == 0){
        split1(x,y,int(ww),h,n+1);
        split1(int(x+ww),y,int(ww2),h,n+1);
    }else{
        split1(x,y,w,int(hh),n+1);
        split1(x,int(y+hh),w,int(hh2),n+1);
    }

    
  }
  
  count++;
}
