float d, L, blanco, negro;
int i = 0;
int value = 0;
void setup() {
  size( 700, 400 );
  rectMode( CENTER );
  noStroke();
  smooth();
  frameRate(70); 
}
void mouseClicked() {
  if (value == 0) {
    value = 255;
  } else {
    value = 0;
  }
}
void draw() {
    background(value);
      for(int m =0; m<750;m++){
        if(m%50==0){
          fill(255);
          rect(m,150,30,600);  
        }
      }
      i++;
      fill(0,0,255);
      rect(i, 150,50,30);
      fill(255,255,0);
      rect(i, 250,50,30);
      if (i > 675) {
        i = 0;
      }
 }
