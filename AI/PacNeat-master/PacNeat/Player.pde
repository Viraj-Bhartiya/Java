class Player {
  Pacman pacman;
  float fitness;
  Genome brain;
  float[] vision = new float[8];//the input array fed into the neuralNet
  float[] decision = new float[4]; //the out put of the NN
  float unadjustedFitness;
  int lifespan = 0;//how long the player lived for fitness
  int bestScore =0;//stores the score achieved used for replay
  boolean dead;
  int score;
  int gen = 0;
  int stage =1; //used for gen shit
  //---------------------------------------------------------------------------------------------------------------------------------------------------------
  //constructor

  Player() {
    pacman = new Pacman();
    brain = new Genome(13, 4);
  }

  //---------------------------------------------------------------------------------------------------------------------------------------------------------
  void show() {
    for (int i = 0; i< 28; i++) {
      for (int j = 0; j< 31; j++) {
        pacman.tiles[j][i].show();
      }
    }

    pacman.blinky.show();
    pacman.pinky.show();
    pacman.inky.show();
    pacman.clyde.show();
    pacman.show();
  }
  //---------------------------------------------------------------------------------------------------------------------------------------------------------
  void move() {
    pacman.move();
    pacman.blinky.move();
    pacman.pinky.move();
    pacman.inky.move();
    pacman.clyde.move();
  }
  //---------------------------------------------------------------------------------------------------------------------------------------------------------
  void update() {
    move();
    checkGameState();
  }
  //---------------------------------------------------------------------------------------------------------------------------------------------------------
  void checkGameState() {
    if (pacman.gameOver) {
      dead = true;
    }
    score = pacman.score;
  }


  //----------------------------------------------------------------------------------------------------------------------------------------------------------

  void look() {

    if (isCriticalPosition(pacman.pos)) {

      //so how this works
      //get the 'danger' of going in that direciton by finding the nearest ghost in that direction and inversing the distance to it
      //also this is assuming that this is called every time pacman is at a critical point

      vision = new float[13];
      distanceToGhostInDirection();
      setDistanceToWalls();
      vision[vision.length -1] = (pacman.blinky.frightened)? 1:0;
    }
  }




  //-----------------------------------------------------------------------------------------------------------------------------------------------------

  //set the inputs for vision in each direction for the ghosts
  void distanceToGhostInDirection() {
    pacman.blinky.setPathNodes();//using blinkies nodes to do shit
    ArrayList<PathNode> allNodes = (ArrayList)pacman.blinky.ghostPathNodes.clone();
    PathNode pacmanNode = allNodes.get(allNodes.size()-1);
    if (!pacman.blinky.active) {
      allNodes.remove(0);
    } else {
      allNodes.get(0).isGhost = true;
    }
    if (pacman.clyde.active) {
      PVector clydePos = pixelToTile(pacman.clyde.pos);
      allNodes.add(new PathNode(getNearestNonWallTile(new PVector(clydePos.x, clydePos.y)), true));
    }
    if (pacman.pinky.active) {
      PVector pinkyPos = pixelToTile(pacman.pinky.pos);
      allNodes.add(new PathNode(getNearestNonWallTile(new PVector(pinkyPos.x, pinkyPos.y)), true));
    }
    if (pacman.inky.active) {
      PVector inkyPos = pixelToTile(pacman.inky.pos);
      allNodes.add(new PathNode(getNearestNonWallTile(new PVector(inkyPos.x, inkyPos.y)), true));
    }



    //now that all the ghosts are added
    for (int i = 0; i< allNodes.size(); i++) {//connect all the nodes together
      allNodes.get(i).addEdges(allNodes);
    }
    //now that the nodes are done lets look to the left

    PVector[] directions = new  PVector[4];
        for (int i = 0; i< 4; i++) {
      directions[i] = new PVector(pacman.vel.x, pacman.vel.y);
      directions[i].rotate(PI/2 *i);
      directions[i].x = round(directions[i].x);
      directions[i].y = round(directions[i].y);

    }

    int visionIndex = -1;

    for (PVector dir : directions) {//for each direction
      visionIndex++;
      float distance = 0;
      PathNode temp = pacmanNode;
      PathNode previousNode = pacmanNode;

      PVector wrongWay = new PVector(-dir.x, -dir.y);
      float min = 100;
      int minIndex = 0;
      boolean intersectionPassed = false;
      while (!temp.isGhost) {//keeps looking left until it finds a wall or a ghost

        min = 100;
        //find the closest edge to the left
        for (int i = 0; i< temp.edges.size(); i++) {
          PVector nodeInDirection = new PVector(temp.edges.get(i).x - temp.x, temp.edges.get(i).y - temp.y);
          nodeInDirection.normalize();
          if (nodeInDirection.x == dir.x && nodeInDirection.y == dir.y) {//if the node is in the desired direction of temp node
            if (dist(temp.x, temp.y, temp.edges.get(i).x, temp.edges.get(i).y)  <  min) {//if the node is the closest seen in the desired direction
              min = dist(temp.x, temp.y, temp.edges.get(i).x, temp.edges.get(i).y);
              minIndex = i;
              wrongWay = new PVector(-nodeInDirection.x, -nodeInDirection.y);
            }
          }
        }

        if (min == 100) {//hit a wall
          break;
        }

        //add the distance to this node to the distance covered
        distance += min;
        previousNode = temp;//set the previous node to the current node
        temp = temp.edges.get(minIndex);//set the current node to the closest node to the left of this node

        if (!intersectionPassed && isIntersection(temp)) {//keep track of whether or not the path passes an intersection or not
          intersectionPassed = true;
        }
      }
      //either wall or ghost is found
      if (temp.isGhost) {//if we found a ghost then we're done with this direction
        vision[visionIndex] = 1.0/distance;
      } else {
        if (distance == 0) {
          vision[visionIndex] = 0.0;
        } else {
          if (intersectionPassed) {//if an itersection has been passed then fuck it
            vision[visionIndex] = 0.0;
          } else {



            //so at this point we havent found a ghost nor have we passed an intersection
            //lets think about what this means
            //if we are not currently on an intersection and we hit a wal that means we hit a corner
            //a corner will have 2 direcitons coming out of it

            //if a corner is reached then continue by finding the nearest node which isnt the previous node visited
            //this is continued until we reach a ghost or an intersection
            while (!temp.isGhost && !isIntersection(temp)) {
              //print(3);
              min = 100;

              for (int i = 0; i< temp.edges.size(); i++) {
                PVector nodeInDirection = new PVector(temp.edges.get(i).x - temp.x, temp.edges.get(i).y - temp.y);
                nodeInDirection.normalize();

                if (nodeInDirection.x != wrongWay.x || nodeInDirection.y != wrongWay.y) {

                  if (temp.edges.get(i) != previousNode) {
                    //println("nid", nodeInDirection.x, nodeInDirection.y);

                    if (dist(temp.x, temp.y, temp.edges.get(i).x, temp.edges.get(i).y)  < min) {
                      min = dist(temp.x, temp.y, temp.edges.get(i).x, temp.edges.get(i).y);
                      minIndex = i;
                    }
                  }
                }
              }
              if (min == 100) {//if no nodes found which arent the previous node then fuck
                print("FUCKKKKKK");//error message
                break;
              }

              previousNode = temp;
              temp = temp.edges.get(minIndex);


              distance += min;
              wrongWay = new PVector(previousNode.x - temp.x, previousNode.y - temp.y);
              wrongWay.normalize();
            }
            if (temp.isGhost) {
              vision[visionIndex] = 1/distance;//if there is a ghost in this direction then add the inverse of the distance to the inputs
            } else {
              vision[visionIndex] = (0.0);//if no ghost is found then add a 0
            }
          }
        }
      }
    }
  }

//------------------------------------------------------------------------------------------------------------------------------------------------------
  //returns whether or not the node is an intersection, i.e has more than 2 direction going out of it
  boolean isIntersection(PathNode n) {
    boolean left = false;
    boolean right = false;
    boolean up = false;
    boolean down= false;
    int countDirections = 0;
    for (int i = 0; i< n.edges.size(); i ++) {
      if ( n.x < n.edges.get(i).x && !left) {
        countDirections++;
        left = true;
      } else if (n.x > n.edges.get(i).x && !right) {
        countDirections++;
        right = true;
      } else if (n.y <n.edges.get(i).y && !up) {
        countDirections++;
        up = true;
      } else if (n.y > n.edges.get(i).y && !down) {
        countDirections++;
        down = true;
      }

      if (countDirections > 2) {
        return true;
      }
    }

    return false;
  }

//----------------------------------------------------------------------------------------------------------------------------------------------------------
//sets some inputs for the NN for whether or not there is a wall directly next to it in all directions
  void setDistanceToWalls() {

    PVector matrixPosition = pixelToTile(pacman.pos);
    PVector[] directions = new  PVector[4];
    for (int i = 0; i< 4; i++) {//add 4 directions to the array
      directions[i] = new PVector(pacman.vel.x, pacman.vel.y);
      directions[i].rotate(PI/2 *i);
      directions[i].x = round(directions[i].x);
      directions[i].y = round(directions[i].y);
    }

    int visionIndex = 4;
    for (PVector dir : directions) {//for each direction
      PVector lookingPosition = new PVector(matrixPosition.x + dir.x, matrixPosition.y+ dir.y);//look int that direction
      if (originalTiles[(int)lookingPosition.y][(int)lookingPosition.x].wall) {//if there is a wall in that direction
        vision[visionIndex] = 1;
      } else {
        vision[visionIndex] = 0;
      }

      while (true) {//keep look in that direction until you reach a dot or a wall
        if (originalTiles[(int)lookingPosition.y][(int)lookingPosition.x].wall) {//if wall
          vision[visionIndex + 4] = 0;
          break;
        }

        if (pacman.tiles[(int)lookingPosition.y][(int)lookingPosition.x].dot && !pacman.tiles[(int)lookingPosition.y][(int)lookingPosition.x].eaten) {//if dot
          vision[visionIndex + 4] = 1;//this allows the players to see in which direction a dot is
          break;
        }

        lookingPosition.add(dir);//look further in that direction if neither a dot nor a wall was found
      }
      visionIndex +=1;
    }
  }





  //---------------------------------------------------------------------------------------------------------------------------------------------------------
  //gets the output of the brain then converts them to actions
  void think() {

    float max = 0;
    int maxIndex = 0;
    //get the output of the neural network
    decision = brain.feedForward(vision);

    for (int i = 0; i < decision.length; i++) {
      if (decision[i] > max) {
        max = decision[i];
        maxIndex = i;
      }
    }

    if (max < 0.8) {//if the max output was less than 0.8 then do nothing
      return;
    }
    PVector currentVel = new PVector(pacman.vel.x, pacman.vel.y);



    currentVel.rotate((PI/2) * maxIndex);
    currentVel.x = round(currentVel.x);
    currentVel.y = round(currentVel.y);
    pacman.turnTo = new PVector(currentVel.x, currentVel.y);
    pacman.turn = true;

  }
  //---------------------------------------------------------------------------------------------------------------------------------------------------------
  //returns a clone of this player with the same brian
  Player clone() {
    Player clone = new Player();
    clone.brain = brain.clone();
    clone.fitness = fitness;
    clone.brain.generateNetwork();
    clone.gen = gen;
    clone.bestScore = score;
    return clone;
  }

//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//since there is some randomness in pacman (when the ghosts are frightened they move randomly) sometimes when we want to replay the game then we need to remove that randomness
//this fuction does that

  Player cloneForReplay() {
    Player clone = new Player();
    clone.brain = brain.clone();
    clone.fitness = fitness;
    clone.brain.generateNetwork();
    clone.pacman.blinky.frightenedTurns = (ArrayList)pacman.blinky.frightenedTurns.clone();
    clone.pacman.blinky.replay = true;
    clone.pacman.pinky.frightenedTurns = (ArrayList)pacman.pinky.frightenedTurns.clone();
    clone.pacman.pinky.replay = true;
    clone.pacman.inky.frightenedTurns = (ArrayList)pacman.inky.frightenedTurns.clone();
    clone.pacman.inky.replay = true;
    clone.pacman.clyde.frightenedTurns = (ArrayList)pacman.clyde.frightenedTurns.clone();
    clone.pacman.clyde.replay = true;
    clone.pacman.replay = true;
    clone.gen = gen;
    clone.bestScore = score;
    clone.stage = stage;
    return clone;
  }

  //---------------------------------------------------------------------------------------------------------------------------------------------------------
  //fot Genetic algorithm
  void calculateFitness() {
    score  = pacman.score;
    bestScore = score;
    lifespan = pacman.lifespan;
    fitness = score*score;
  }

  //---------------------------------------------------------------------------------------------------------------------------------------------------------
  Player crossover(Player parent2) {
    Player child = new Player();
    child.brain = brain.crossover(parent2.brain);
    child.brain.generateNetwork();
    return child;
  }
}
