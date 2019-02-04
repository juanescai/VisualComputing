//Class for face-vertex representation

class FaceVertex {
  ArrayList<Vertex> vertexList = new ArrayList<Vertex>();
  ArrayList<Face> faceList = new ArrayList<Face>();
  PShape boid;
  
  FaceVertex(){
    this.vertexList = initializeVertex();
    this.faceList = initializeFaces();
  }
  
  //Initialization vertex
  ArrayList<Vertex> initializeVertex(){
    int [] neighbors0 = {1, 2, 3};
    int [] neighbors1 = {0, 2, 3};
    int [] neighbors2 = {0, 1, 3};
    int [] neighbors3 = {0, 1, 2};
    
    Vertex v0 = new Vertex("v0", 3 * sc, 0, 0, neighbors0);
    Vertex v1 = new Vertex("v1",-3 * sc, 2 * sc, 0, neighbors1);
    Vertex v2 = new Vertex("v2",-3 * sc, -2 * sc, 0, neighbors2);
    Vertex v3 = new Vertex("v3",-3 * sc, 0, 2 * sc, neighbors3);
    
    ArrayList<Vertex> vertexList = new ArrayList<Vertex>();
    vertexList.add(v0);
    vertexList.add(v1);
    vertexList.add(v2);
    vertexList.add(v3);
    
    return vertexList;
  }
  
  //Initialization Face
  ArrayList<Face> initializeFaces(){
    int [] vertex = {0, 1, 2};
    int [] vertex1 = {0, 1, 3};
    int [] vertex2 = {0, 3, 2};
    int [] vertex3 = {3, 1, 2};
    
    Face f0 = new Face("f0", vertex);
    Face f1 = new Face("f1", vertex1);
    Face f2 = new Face("f2", vertex2);
    Face f3 = new Face("f3", vertex3);
    
    ArrayList<Face> faceList = new ArrayList<Face>();
    faceList.add(f0);
    faceList.add(f1);
    faceList.add(f2);
    faceList.add(f3);

    return faceList;
  }
  //Retained Mode
    PShape retainedMode(int kind){
    boid = createShape();
    boid.beginShape(kind);
    for(int i = 0; i < faceList.size(); i++){
      Face f = faceList.get(i);
      for(int j = 0; j < f.vertex.length; j ++){
        int index = f.vertex[j];
        Vertex v = vertexList.get(index);
        boid.vertex(v.x, v.y, v.z);
      }
    }
    boid.endShape(CLOSE);
    return boid;
  }
  
  //InmediateMode
  void inmediateMode(int kind){
    beginShape(kind);
    for(int i = 0; i < faceList.size(); i++){
      Face f = faceList.get(i);
      for(int j = 0; j < f.vertex.length; j ++){
        int index = f.vertex[j];
        Vertex v = vertexList.get(index);
        vertex(v.x, v.y, v.z);
      }
    }
    endShape(CLOSE);
  }
  
} 