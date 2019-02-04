/**
 * Flock of Boids
 * by Jean Pierre Charalambos.
 * 
 * This example displays the 2D famous artificial life program "Boids", developed by
 * Craig Reynolds in 1986 and then adapted to Processing in 3D by Matt Wetmore in
 * 2010 (https://www.openprocessing.org/sketch/6910#), in 'third person' eye mode.
 * Boids under the mouse will be colored blue. If you click on a boid it will be
 * selected as the scene avatar for the eye to follow it.
 *
 * Press ' ' to switch between the different eye modes.
 * Press 'a' to toggle (start/stop) animation.
 * Press 'p' to print the current frame ra    te.
 * Press 'm' to change the mesh visual mode.
 * Press 't' to shift timers: sequential and parallel.
 * Press 'v' to toggle boids' wall skipping.
 * Press 's' to call scene.fitBallInterpolation().
 */


import frames.primitives.*;
import frames.core.*;
import frames.processing.*;

Scene scene;
PShape s;
int flockWidth = 1280;
int flockHeight = 720;
int flockDepth = 600;
boolean avoidWalls = true;
float sc = 3;

// visual modes
// 0. Faces and edges
// 1. Wireframe (only edges)
// 2. Only faces
// 3. Only points
int mode;

int initBoidNum = 900; // amount of boids to start the program with
ArrayList<Boid> flock;
Frame avatar;
boolean animate = true;
//Retained mode
boolean retained = false;
//Representation mode
boolean rep = false;
void setup() {
  size(1000, 800, P3D);
  scene = new Scene(this);
  scene.setFrustum(new Vector(0, 0, 0), new Vector(flockWidth, flockHeight, flockDepth));
  scene.setAnchor(scene.center());
  scene.fit(1);
  // Call Retained mode Vertex-Vertex representation
  s = vertexVertexRetained();
  // create and fill the list of boids
  flock = new ArrayList();
  for (int i = 0; i < initBoidNum; i++)
    flock.add(new Boid(new Vector(flockWidth / 2, flockHeight / 2, flockDepth / 2)));
}

void draw() {
  background(0);
  ambientLight(128, 128, 128);
  directionalLight(255, 255, 255, 0, 1, -100);
  walls();
  // Calls Node.visit() on all scene nodes.
  scene
.traverse();
}
  
// Function for Retained vertex vertex  
  PShape vertexVertexRetained(){
    pushStyle();
    // uncomment to draw boid axes
    //scene.drawAxes(10);
    int kind = TRIANGLES;
    strokeWeight(2);
    stroke(color(0, 255, 0));
    fill(color(255, 0, 0, 125));

    VertexVertex representation = new VertexVertex();
    s = representation.retainedMode(kind);
    popStyle();
    return s;
  }
  
//Function for Rained face vertex
  PShape faceVertexRetained(){
    pushStyle();
    // uncomment to draw boid axes
    //scene.drawAxes(10);
    int kind = TRIANGLES;
    strokeWeight(2);
    stroke(color(0, 255, 0));
    fill(color(255, 0, 0, 125));

    FaceVertex representation = new FaceVertex();
    s = representation.retainedMode(kind);
    popStyle();
    return s;
  }

//Change representation mesh
void changeRepresentation(){
    if(!rep) s = vertexVertexRetained();
    else s = faceVertexRetained();
  for (int i = 0; i < initBoidNum; i++)
    flock.get(i).setPos(new Vector(flockWidth / 2, flockHeight / 2, flockDepth / 2));
    
}
void walls() {
  pushStyle();
  noFill();
  stroke(255);

  line(0, 0, 0, 0, flockHeight, 0);
  line(0, 0, flockDepth, 0, flockHeight, flockDepth);
  line(0, 0, 0, flockWidth, 0, 0);
  line(0, 0, flockDepth, flockWidth, 0, flockDepth);

  line(flockWidth, 0, 0, flockWidth, flockHeight, 0);
  line(flockWidth, 0, flockDepth, flockWidth, flockHeight, flockDepth);
  line(0, flockHeight, 0, flockWidth, flockHeight, 0);
  line(0, flockHeight, flockDepth, flockWidth, flockHeight, flockDepth);

  line(0, 0, 0, 0, 0, flockDepth);
  line(0, flockHeight, 0, 0, flockHeight, flockDepth);
  line(flockWidth, 0, 0, flockWidth, 0, flockDepth);
  line(flockWidth, flockHeight, 0, flockWidth, flockHeight, flockDepth);
  popStyle();
}
void updateAvatar(Frame boid) {
  if (boid != avatar) {
    avatar = boid;
    if (avatar != null)
      thirdPerson();
    else if (scene.eye().reference() != null)
      resetEye();
  }
}

// Sets current avatar as the eye reference and interpolate the eye to it
void thirdPerson() {
  scene.eye().setReference(avatar);
  scene.fit(avatar, 1);
}

// Resets the eye
void resetEye() {
  // same as: scene.eye().setReference(null);
  scene.eye().resetReference();
  scene.lookAt(scene.center());
  scene.fit(1);
}
// picks up a boid avatar, may be null
void mouseClicked() {
  // two options to update the boid avatar:
  // 1. Synchronously
  updateAvatar(scene.track("mouseClicked", mouseX, mouseY));
  // which is the same as these two lines:
  // scene.track("mouseClicked", mouseX, mouseY);
  // updateAvatar(scene.trackedFrame("mouseClicked"));
  // 2. Asynchronously
  // which requires updateAvatar(scene.trackedFrame("mouseClicked")) to be called within draw()
  // scene.cast("mouseClicked", mouseX, mouseY);
}

// 'first-person' interaction
void mouseDragged() {
  if (scene.eye().reference() == null)
    if (mouseButton == LEFT)
      // same as: scene.spin(scene.eye());
      scene.spin();
    else if (mouseButton == RIGHT)
      // same as: scene.translate(scene.eye());
      scene.translate();
    else
      // same as: scene.zoom(mouseX - pmouseX, scene.eye());
      scene.moveForward(mouseX - pmouseX);
}

// highlighting and 'third-person' interaction
void mouseMoved(MouseEvent event) {
  // 1. highlighting
  scene.cast("mouseMoved", mouseX, mouseY);
  // 2. third-person interaction
  if (scene.eye().reference() != null)
    // press shift to move the mouse without looking around
    if (!event.isShiftDown())
      scene.lookAround();
}

void mouseWheel(MouseEvent event) {
  // same as: scene.scale(event.getCount() * 20, scene.eye());
  scene.scale(event.getCount() * 20);
}
void keyPressed() {
  switch (key) {
  case 'a':
    animate = !animate;
    break;
  case 's':
    if (scene.eye().reference() == null)
      scene.fit(1);
    break;
  case 't':
    scene.shiftTimers();
    break;
  case 'p':
    println("Frame rate: " + frameRate);
    break;
  case 'v':
    avoidWalls = !avoidWalls;
    break;
  case 'm':
    mode = mode < 3 ? mode+1 : 0;
    break;
  case ' ':
    if (scene.eye().reference() != null)
      resetEye();
    else if (avatar != null)
      thirdPerson();
    break;
   // change retained or inmediate mode
  case 'r':
    retained = !retained;
    changeRepresentation();
    println("Retained " + retained);
    break;
  // change vertexvertex o facevertex representation
  case 'f':
    rep = !rep;
    changeRepresentation();
    println("Representation " + rep);
    break;
  }
}
