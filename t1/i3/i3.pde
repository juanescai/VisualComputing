PImage img;
int counter = 1;
float var = 0;

void setup() {
  size(700, 400);
  smooth();
  background(0, 0, 0);
  img = loadImage("Moneda.png");
  imageMode(CENTER); //you can change mode to CORNER to see the difference.
}

void draw() {
  background(255);
  fill(255);  
  if (mousePressed) {
    translate(width/2, height/2);
    rotate(var);
    image(img, 0, 0, 300, 300);    
  }
  else{
    counter++;
    translate(width/2, height/2);
    var = counter*TWO_PI/360;
    rotate(counter*TWO_PI/360);
    image(img, 0, 0, 300, 300);
  }
}
