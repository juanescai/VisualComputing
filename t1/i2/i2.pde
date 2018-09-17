float d, L, blanco, negro;
float i = 0;
int value = 0;
void setup() {
  size( 700, 400 );
  rectMode( CENTER );
  noStroke();
  smooth();
  frameRate(70); 
}
void draw() {
  fill(4, 50, 50);
  rect(width/2, height/2, width, height);
  //borde y relleno del cuadrado
  stroke(#ffffff);
  fill(150, 50, 50);
  //trasladamos el punto 0,0 al centro de la ventana
  translate(width/2, height/2);
  //asignamos el valor de giro
  rotate(i);
  //y dibujamos el cuadrado
  rect(0,0,170, 170);
  //resereamos traslación y giro
  resetMatrix();
  //y repetimos con otro rectángulo
  stroke(0, 50);
  fill(150,250,20);
  translate(width/2, height/2);
  rotate(i);
  rect(0, 0, 130, 130);
  //esto hace que el valor del ángulo aumente a cada ciclo
  i = i + 0.07;
  if(mousePressed){
    i = 0;
  }
 }
