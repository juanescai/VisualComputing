PImage img;
int i = 150;
float var = 0;

void setup() {
  size(400,400);
   rectMode( CENTER );
  noStroke();
  smooth();
  frameRate(450);
}

void draw() {
  background(169,169,169);
  i++;
  fill(150,0,255);
  ellipse(i, 200,20,20);
  if (i > 350) {
     i = 0;
  }
  rotate(-PI/3.0);
  for (int k = 0;k<1000;k++){
    if (k%2==0){
      fill(255);
      rect(0, k,10,80);
      k+=10;
    }
    else{
      fill(0);
      rect(0, k,10,80);
      k+=10;
    }
  }
  rotate(-PI/3.0);
  for (int k = -200;k<1000;k++){
    if (k%2==0){
      fill(255);
      rect(-350, k,10,80);
      k+=10;
    }
    else{
      fill(0);
      rect(-350, k,10,80);
      k+=10;
    }    
  }

  
}
