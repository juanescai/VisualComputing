// Class for vertex-vertex representation

class VertexVertex {
  ArrayList<Vertex> vertexList = new ArrayList<Vertex>();
  PShape boid;
  
  VertexVertex(){
    this.vertexList = initializeVertex();
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
  
  //Retained Mode
  PShape retainedMode(int kind){
    boid = createShape();
    boid.beginShape(kind);
    for(int i = 0; i < vertexList.size(); i++){
      Vertex v = vertexList.get(i);
      boid.vertex(v.x, v.y, v.z);
      for(int j = 0; j < v.neighbors.length; j ++){
        int index = v.neighbors[j];
        Vertex neighbor = vertexList.get(index);
        boid.vertex(neighbor.x, neighbor.y, neighbor.z);
      }
    }
    boid.endShape(CLOSE);
    return boid;
  }
  
  //Inmediate Mode
  void inmediateMode(int kind){
    beginShape(kind);
    for(int i = 0; i < vertexList.size(); i++){
      Vertex v = vertexList.get(i);
      vertex(v.x, v.y, v.z);
      for(int j = 0; j < v.neighbors.length; j ++){
        int index = v.neighbors[j];
        Vertex neighbor = vertexList.get(index);
        vertex(neighbor.x, neighbor.y, neighbor.z);
      }
    }
    endShape(CLOSE);
  }
  
}