int i = 150;
float var = 0;

void setup() {
  size(700,500);
   rectMode( CENTER );
  noStroke();
  smooth();
  frameRate(350);
}

void draw() {
  background(0);
  for (int k = 20;k<700;k++){
    if(k%50==0){
      rect(k, 0,10,1000);
      k+=30;
    }    
  }
  fill(255,255,0);
  rotate(PI/2.0);
  for (int k = 20;k<700;k++){
    if(k%50==0){
      rect(k, 0,10,1400);
      k+=30;
    }    
  }
}
