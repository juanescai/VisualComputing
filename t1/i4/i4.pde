PImage img;
int i = 150;
float var = 0;

void setup() {
  size(400,400);
   img = loadImage("Imagen1.png");
   rectMode( CENTER );
  noStroke();
  smooth();
  frameRate(150);
}

void draw() {
  background(255);
  i++;
  fill(0,0,255);
  ellipse(i, 0,20,20);
  if (i > 350) {
     i = 0;
  }
  rotate(-PI/3.0);
  for (int k = 0;k<1000;k++){
    if (k%2==0){
      fill(255,255,0);
      rect(0, k,20,80);
      k+=20;
    }
    else{
      fill(0);
      rect(0, k,20,80);
      k+=20;
    }
  }
  rotate(-PI/3.0);
  for (int k = -200;k<1000;k++){
    if (k%2==0){
      fill(255);
      rect(-350, k,20,80);
      k+=20;
    }
    else{
      fill(0);
      rect(-350, k,20,80);
      k+=20;
    }    
  }

  
}
