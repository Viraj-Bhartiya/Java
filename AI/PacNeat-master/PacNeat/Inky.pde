class Inky {
  PVector pos = tileToPixel(new PVector(23, 26));

  PVector vel = new PVector(1, 0);
  Path bestPath; // the variable stores the path the ghost will be following
  ArrayList<PathNode> ghostPathNodes = new ArrayList<PathNode>();//the nodes making up the path including the ghosts position and the target position
  PathNode start;//the ghosts position as a node
  PathNode end; //the ghosts target position as a node
  color colour = color(135, 206, 250);//blueish


  boolean chase = true;//true if the ghost is in chase mode false if in scatter mode
  boolean frightened = false;//true if the ghost is in frightened mode
  int flashCount = 0;//in order to make the ghost flash when frightened this is a counter
  int chaseCount = 0;//counter for the switch between chase and scatter
  boolean returnHome = false;//if eaten return home
  boolean deadForABit = false;//after the ghost returns home it disappears for a bit
  int deadCount = 0;
  Pacman pacman;
  
  boolean active = inkyActive;

  //------------------------------------------------stuff to replay the ghost
  boolean replay = false;
  ArrayList<Integer> frightenedTurns = new ArrayList<Integer>();
  int upToIndex = 0;
  //--------------------------------------------------------------------------------------------------------------------------------------------------
  //constructor
  Inky(Pacman pac) {
    pacman = pac;
    setPath();
  }
  //--------------------------------------------------------------------------------------------------------------------------------------------------
  void update() {
    //increments counts
    chaseCount ++;
    if (chase) {
      if (chaseCount > 1500) {
        chase = false;  
        chaseCount = 0;
      }
    } else {
      if (chaseCount > 800) {
        chase = true;
        chaseCount = 0;
      }
    }

    if (deadForABit) {
      deadCount ++;
      if (deadCount > 400) {
        deadForABit = false;
      }
    } else {
      if (frightened) {
        flashCount ++;
        if (flashCount > 1000) {//after 10 seconds the ghosts are no longer frightened
          frightened = false;
          flashCount = 0;
        }
      }
    }
  }

  void show() {
    if (active) {
      if (!deadForABit) {
        PImage sprite = inkySprite;
        if (!frightened) {
          if (returnHome) {//have the ghost be transparent if on its way home
            tint(255,127);
            sprite = deadSprite;
          } else {// colour the ghost
            sprite = inkySprite;
          }
          // bestPath.show();//show the path the ghost is following
        } else {//if frightened
          if (floor(flashCount / 30) %2 ==0) {//make it flash white and blue every 30 frames
            sprite = frightenedSprite2;
          } else {//flash blue
            sprite = frightenedSprite;
          }
        }
        image(sprite, pos.x-15, pos.y -15);
        tint(255,255);
        // ellipse(pos.x, pos.y, 30, 30);//draw the ghost as a circle
      }
    }
  }
  //--------------------------------------------------------------------------------------------------------------------------------------------------
  //moves the ghost along the path
  void move() {
    if (active) {
      if (!deadForABit) {//dont move if dead
        pos.add(vel);
        pos.add(vel);

        checkDirection();//check if need to change direction next move
      }
      update();
    }
  }
  //--------------------------------------------------------------------------------------------------------------------------------------------------

  //calculates a path from the first node in ghost nodes to the last node in ghostPathNodes and sets it as best path
  void setPath() {
    ghostPathNodes.clear();
    setPathNodes();
    start  = ghostPathNodes.get(0);
    end = ghostPathNodes.get(ghostPathNodes.size()-1);
    Path temp = AStar(start, end, vel);
    if (temp!= null) {//if not path is found then dont change bestPath
      bestPath = temp.clone();
    }
  }
  //--------------------------------------------------------------------------------------------------------------------------------------------------
  //sets all the nodes and connects them with adjacent nodes 
  //also sets the target node
  void setPathNodes() {

    ghostPathNodes.add(new PathNode(pixelToTile(pos)));//add the current position as a node
    for (int i = 1; i< 27; i++) {//check every position
      for (int j = 1; j< 30; j++) {
        //if there is a space up or below and a space left or right then this space is a node
        if (!originalTiles[j][i].wall) {
          if (!originalTiles[j-1][i].wall || !originalTiles[j+1][i].wall) { //check up for space
            if (!originalTiles[j][i-1].wall || !originalTiles[j][i+1].wall) {//check left and right for space

              ghostPathNodes.add(new PathNode(i, j));//add the nodes
            }
          }
        }
      }
    }
    if (returnHome) {//if returning home then the target is just above the ghost room thing
      ghostPathNodes.add(new PathNode(13, 11));
    } else {
      if (chase) {
        PVector pacmanPosition = pixelToTile(pacman.pos);// new PVector((pacman.pos.x-8) / 16, (pacman.pos.y-8)/16);
        PVector blinkyPosition = pixelToTile(pacman.blinky.pos);// new PVector((pacman.blinky.pos.x-8)/16, (pacman.blinky.pos.y - 8)/16);
        PVector blinkyToPacman = new PVector(pacmanPosition.x - blinkyPosition.x, pacmanPosition.y - blinkyPosition.y);

        PVector target = new PVector (pacmanPosition.x + blinkyToPacman.x, pacmanPosition.y + blinkyToPacman.y);
        PVector nearestTile = getNearestNonWallTile(target);
        PVector tileCoord = pixelToTile(pos);
        
        if (dist(tileCoord.x,tileCoord.y, nearestTile.x, nearestTile.y)<1) {
          ghostPathNodes.add(new PathNode(pacmanPosition));
        } else {


          ghostPathNodes.add(new PathNode(nearestTile.x, nearestTile.y));
        }
      } else {//scatter
        ghostPathNodes.add(new PathNode(26, 29));
      }
    }

    for (int i = 0; i< ghostPathNodes.size(); i++) {//connect all the nodes together
      ghostPathNodes.get(i).addEdges(ghostPathNodes);
    }
  }
  //--------------------------------------------------------------------------------------------------------------------------------------------------
 //check if the ghost needs to change direction as well as other stuff
  void checkDirection() {
    if (pacman.hitPacman(pos)) {//if hit pacman
      if (frightened) {//eaten by pacman
        returnHome = true;
        frightened = false;
      } else if (!returnHome) {//killPacman
        pacman.kill();
      }
    }


    // check if reached home yet
    if (returnHome) {
      PVector tilePos = pixelToTile(pos);
      if (dist(tilePos.x,tilePos.y, 13, 11) < 1) {
        //set the ghost as dead for a bit
        returnHome = false;
        deadForABit = true;
        deadCount = 0;
      }
    }


    
    if (isCriticalPosition(pos)) {//if on a critical position 
      PVector matrixPosition = pixelToTile(pos);//new PVector((pos.x-8)/16, (pos.y - 8)/16);//convert position to an array position
      boolean isPathNode = false;
      for (int j = 0; j < ghostPathNodes.size(); j++) {
        if (matrixPosition.x ==  ghostPathNodes.get(j).x && matrixPosition.y == ghostPathNodes.get(j).y) {
          isPathNode = true;
        }
      }
      if (!isPathNode) {//if not on a node then no need to do anything
        return;
      }
      if (frightened) {//no path needs to generated by the ghost if frightened
        //if on a node
        //set a random direction


        PVector newVel = new PVector();


        int rand = floor(random(4));
        if (replay && upToIndex < frightenedTurns.size()) {

          rand = frightenedTurns.get(upToIndex);
          upToIndex++;
        }

        switch(rand) {
        case 0:
          newVel = new PVector(1, 0);
          break;
        case 1:
          newVel = new PVector(0, 1);
          break;
        case 2:
          newVel = new PVector(-1, 0);
          break;
        case 3:
          newVel = new PVector(0, -1);
          break;
        }
        //if the random velocity is into a wall or in the opposite direction then choose another one
        while (originalTiles[floor(matrixPosition.y + newVel.y)][floor(matrixPosition.x + newVel.x)].wall || (newVel.x +2*vel.x ==0 && newVel.y + 2*vel.y ==0)) {
          rand = floor(random(4));
          switch(rand) {
          case 0:
            newVel = new PVector(1, 0);
            break;
          case 1:
            newVel = new PVector(0, 1);
            break;
          case 2:
            newVel = new PVector(-1, 0);
            break;
          case 3:
            newVel = new PVector(0, -1);
            break;
          }
        }

        if (!replay) {
          frightenedTurns.add(rand);
        }
        vel = new PVector(newVel.x/2, newVel.y/2);//halve the speed
      } else {//not frightened

        setPath();

        for (int i =0; i< bestPath.path.size()-1; i++) {//if currently on a node turn towards the direction of the next node in the path 
          if (matrixPosition.x ==  bestPath.path.get(i).x && matrixPosition.y == bestPath.path.get(i).y) {

            vel = new PVector(bestPath.path.get(i+1).x - matrixPosition.x, bestPath.path.get(i+1).y - matrixPosition.y);
            vel.mult(100);
            vel.limit(1);

            return;
          }
        }
      }
    }
  }
}