import frames.timing.*;
import frames.primitives.*;
import frames.core.*;
import frames.processing.*;

// 1. Frames' objects
Scene scene;
Frame frame;
Vector v1, v2, v3;
// timing
TimingTask spinningTask;
boolean yDirection,antialiasing,shading;
// scaling is a power of 2
int n = 4;
int anti = 1;
color c1 = color(255,0,0);//color for vertex 1
color c2 = color(0,255,0);//color for vertex 2
color c3 = color(0,0,255);//color for vertex 3

// 2. Hints
boolean triangleHint = true;
boolean gridHint = true;
boolean debug = true;

// 3. Use FX2D, JAVA2D, P2D or P3D
String renderer = P3D;

void setup() {
  //use 2^n to change the dimensions
  size(1024, 810, renderer);
  scene = new Scene(this);
  if (scene.is3D())
  scene.setType(Scene.Type.ORTHOGRAPHIC);
  scene.setRadius(width/2);
  scene.fitBallInterpolation();

  // not really needed here but create a spinning task
  // just to illustrate some frames.timing features. For
  // example, to see how 3D spinning from the horizon
  // (no bias from above nor from below) induces movement
  // on the frame instance (the one used to represent
  // onscreen pixels): upwards or backwards (or to the left
  // vs to the right)?
  // Press ' ' to play it
  // Press 'y' to change the spinning axes defined in the
  // world system.
  spinningTask = new TimingTask() {
    @Override
    public void execute() {
      scene.eye().orbit(scene.is2D() ? new Vector(0, 0, 1) :
      yDirection ? new Vector(0, 1, 0) : new Vector(1, 0, 0), PI / 100);
    }
  };
  scene.registerTask(spinningTask);

  frame = new Frame();
  frame.setScaling(width/pow(2, n));

  // init the triangle that's gonna be rasterized
  randomizeTriangle();
}

void draw() {
  background(0);
  stroke(0, 255, 0);
  if (gridHint)
  scene.drawGrid(scene.radius(), (int)pow(2, n));
  if (triangleHint)
  drawTriangleHint();
  pushMatrix();
  pushStyle();
  scene.applyTransformation(frame);
  triangleRaster();
  popStyle();
  popMatrix();
}

// Implement this function to rasterize the triangle.
// Coordinates are given in the frame system which has a dimension of 2^n
void triangleRaster() {
  // frame.location converts points from world to frame
  // here we convert v1 to illustrate the idea
  float begin=350-(width/pow(2, n))/2;
  float area = edgeFunction(v1, v2, v3); 
  for(float i=-begin;i<=begin;i=i+width/pow(2, n)){
    for(float j=-begin;j<=begin;j=j+width/pow(2, n)){
      Vector p = new Vector(i,j);
      float w0 = edgeFunction(v2, v3, p);
      float w1 = edgeFunction(v3, v1, p); 
      float w2 = edgeFunction(v1, v2, p); 
      
      if (w0 >= 0 && w1 >= 0 && w2 >= 0) {
        w0 /= area;
        w1 /= area; 
        w2 /= area;
        pushStyle();
        popStyle();
      }
      
    }
  }
  
  if (debug) {
    pushStyle();
    stroke(255, 0, 0, 125);
    popStyle();    
    pushStyle();
    stroke(255, 255, 255, 125);
    popStyle();
  }
  
  pushStyle();
  stroke(125, 125, 125, 125);
  int potencia = (int) pow(2,n-1);
   popStyle();
   float shadeArea = edgeFunction(frame.location(v1).x(), frame.location(v1).y(), frame.location(v2).x(), frame.location(v2).y(), frame.location(v3).x(), frame.location(v3).y() );
    for(int  i = -potencia ; i < potencia; i++ ){
      for(int j = -potencia; j < potencia; j++){
        float K_v1v2 = edgeFunction(frame.location(v1).x(), frame.location(v1).y(), frame.location(v2).x(), frame.location(v2).y(), i, j ),
              K_v2v3 = edgeFunction(frame.location(v2).x(), frame.location(v2).y(), frame.location(v3).x(), frame.location(v3).y(), i, j ),
              K_v3v1 = edgeFunction(frame.location(v3).x(), frame.location(v3).y(), frame.location(v1).x(), frame.location(v1).y(), i, j );
          if ((K_v1v2 >=0  && K_v2v3 >= 0 && K_v3v1 >= 0) || (K_v1v2 <=0  && K_v2v3 <=0 && K_v3v1 <=0) ){
                pushStyle();
                colorMode(RGB, 1);
                stroke( K_v1v2/shadeArea, K_v2v3/shadeArea, K_v3v1/shadeArea);
                point(i,j);
                popStyle();
              }   
      }
    
    }
}

float edgeFunction(Vector a, Vector b, Vector c) {
  float ax = a.x(), ay = a.y();
  float bx = b.x(),  by = b.y();
  float cx = c.x(), cy = c.y();

  return (cx - ax) * (by - ay) - (cy - ay) * (bx - ax);
}
float edgeFunction( float a_x,  float a_y , float b_x, float b_y, float c_x,  float c_y) 
{ 
    return (((c_x - a_x) * (b_y - a_y)) - ((c_y - a_y) * (b_x - a_x))); 
}

void randomizeTriangle() {
  int low = -width/2;
  int high = width/2;
  v1 = new Vector(random(low, high), random(low, high));
  v2 = new Vector(random(low, high), random(low, high));
  v3 = new Vector(random(low, high), random(low, high));
}

void drawTriangleHint() {
  pushStyle();
  noFill();
  strokeWeight(2);
  stroke(255, 0, 0);
  triangle(v1.x(), v1.y(), v2.x(), v2.y(), v3.x(), v3.y());
  strokeWeight(5);
  stroke(0, 255, 255);
  point(v1.x(), v1.y());
  point(v2.x(), v2.y());
  point(v3.x(), v3.y());
  popStyle();
}

void keyPressed() {
  if (key == 'g')
    gridHint = !gridHint;
  if (key == 't')
    triangleHint = !triangleHint;
  if (key == 'd')
    debug = !debug;
  if (key == '+') {
    n = n < 7 ? n+1 : 2;
    frame.setScaling(width/pow( 2, n));
  }
  if (key == '-') {
    n = n >2 ? n-1 : 7;
    frame.setScaling(width/pow( 2, n));
  }
  if (key == 'r')
    randomizeTriangle();
  if (key == ' ')
    if (spinningTask.isActive())
      spinningTask.stop();
    else
      spinningTask.run(20);
  if (key == 'y')
    yDirection = !yDirection;
  if (key == 'a')
    antialiasing = !antialiasing;
  if (key == 's')
    shading = !shading;
}
