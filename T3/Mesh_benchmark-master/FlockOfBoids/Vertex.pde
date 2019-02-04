// Class for vertex

class Vertex{
  
  //Variables
  String name;
  float x, y, z;
  int [] neighbors;
  
  //Constructor
  Vertex(String name, float x, float y, float z, int [] neighbors){
    this.name = name;
    this.x = x;
    this.y = y;
    this.z = z;
    this.neighbors = neighbors;
  }
}
