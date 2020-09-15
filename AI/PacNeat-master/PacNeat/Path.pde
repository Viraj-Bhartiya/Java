class Path {
  LinkedList<PathNode> path = new LinkedList<PathNode>();//a list of nodes 
  float distance = 0;//length of path
  float distToFinish =0;//the distance between the final node and the paths goal
  PVector velAtLast;//the direction the ghost is going at the last point on the path

  //--------------------------------------------------------------------------------------------------------------------------------------------
  //constructor
  Path() {
  }
  //--------------------------------------------------------------------------------------------------------------------------------------------
  //adds a node to the end of the path
  void addToTail(PathNode n, PathNode endPathNode)
  {
    if (!path.isEmpty())//if path is empty then this is the first node and thus the distance is still 0
    {
      distance += dist(path.getLast().x, path.getLast().y, n.x, n.y);//add the distance from the current last element in the path to the new node to the overall distance
    }

    path.add(n);//add the node
    distToFinish = dist(path.getLast().x, path.getLast().y, endPathNode.x, endPathNode.y);//recalculate the distance to the finish
  }
  //--------------------------------------------------------------------------------------------------------------------------------------------
  //retrun a clone of this 
  Path clone()
  {
    Path temp = new Path();
    temp.path = (LinkedList)path.clone();
    temp.distance = distance;
    temp.distToFinish = distToFinish;
    temp.velAtLast = new PVector(velAtLast.x, velAtLast.y);
    return temp;
  }
  //--------------------------------------------------------------------------------------------------------------------------------------------
  //removes all nodes in the path
  void clear()
  {
    distance =0;
    distToFinish = 0;
    path.clear();
  }
  //--------------------------------------------------------------------------------------------------------------------------------------------
  //draw lines representing the path
  void show() {
    strokeWeight(2);
    for (int i = 0; i< path.size()-1; i++) {
      PVector CoordOfNode = tileToPixel(new PVector(path.get(i).x, path.get(i).y));

      PVector CoordOfNextNode = tileToPixel(new PVector(path.get(i+1).x, path.get(i+1).y));

      line(CoordOfNode.x, CoordOfNode.y, CoordOfNextNode.x, CoordOfNextNode.y);
      //line(path.get(i).x*16 +8, path.get(i).y*16 +8, path.get(i+1).x*16 +8, path.get(i+1).y*16 +8);//
    }
      PVector CoordOfLastNode = tileToPixel(new PVector(path.get(path.size() -1).x, path.get(path.size() -1).y));
    ellipse(CoordOfLastNode.x,CoordOfLastNode.y,5,5);
    //ellipse((path.get(path.size() -1).x*16)+8, (path.get(path.size() -1).y*16)+8, 5, 5);
  }
}