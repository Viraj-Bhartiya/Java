class Pacman {
  PVector pos;
  PVector vel = new PVector(1, 0);

  //when pacman reaches a node its velocity changes to the value stored in turnto
  PVector turnTo = new PVector(1, 0);
  boolean turn = false;
  int score = 0;
  int lives = 0;
  boolean  gameOver = false;
  Blinky blinky;
  Pinky pinky;
  Inky inky;
  Clyde clyde;
  int lifespan = 0;
  int ttl = 100;//time to live without eating another dot
  int stopTimer = 0;// how long the player has been stopped for
  boolean replay = false;
  Tile[][] tiles = new Tile[31][28];

  //---------------------------------------------------------------------------------------------------------------------------------------------------------
  //constructor
  Pacman() {
    pos = tileToPixel(new PVector(13, 23));
    for (int i = 0; i< 28; i++) {//for each tile
      for (int j = 0; j< 31; j++) {
        tiles[j][i] = originalTiles[j][i].clone();
      }
    }

    blinky = new Blinky(this);
    inky = new Inky(this);
    pinky = new Pinky(this);
    clyde = new Clyde(this);
  }

  //------------------------------------------------------------------------------------------------------------------------------------------------------------
  //get pointers to all the ghosts
  void setGhosts(Blinky b, Pinky p, Inky i, Clyde c) {
    blinky = b;
    pinky = p;
    inky = i;
    clyde = c;
  }

  //---------------------------------------------------------------------------------------------------------------------------------------------------------

  //draws pacman
  void show() {
    fill(255, 255, 0);
    stroke(255, 255, 0);
    pushMatrix();
    translate(pos.x, pos.y);
    if (vel.x == 1) {
    } else if (vel.x == -1) {
      rotate(PI);
    } else if (vel.y == 1) {
      rotate(PI/2);
    } else if (vel.y ==-1) {
      rotate(3* PI / 2);
    }

    image(pac, -15, -15, 30, 30);


    popMatrix();

  }

  //---------------------------------------------------------------------------------------------------------------------------------------------------------
  //move pacman if not facing wall
  void move() {
    if (!clydeActive) {
      ttl --;
      if (ttl <= 0 ) {
        kill();
      }
    }
    if (checkPosition() &&vel.mag()!=0 ) {
      stopTimer = 0;
      pos.add(vel);
      pos.add(vel);

    } else {
      stopTimer ++; 
      if (stopTimer > 100) {
        kill();
      }
    }

    lifespan ++;
  }

  //---------------------------------------------------------------------------------------------------------------------------------------------------------

  //returns whether the input vector hits pacman
  boolean hitPacman(PVector GhostPos) {
    if (dist(GhostPos.x, GhostPos.y, pos.x, pos.y) < 25) {
      return true;
    }
    return false;
  }


  //---------------------------------------------------------------------------------------------------------------------------------------------------------
  //called when a ghost hits pacman
  void kill() {
    lives -=1;
    if (lives < 0) {//game over if no lives left
      gameOver = true;
    } else {
      pos = tileToPixel(new PVector(13, 23));  //reset positions  

      blinky = new Blinky(this);
      clyde = new Clyde(this);
      pinky = new Pinky(this);
      inky = new Inky(this);
      vel = new PVector(-1, 0);
      turnTo = new PVector(-1, 0);
    }
  }

  //-------------------------------------------------------------------------------------------------------------------------------------------------
  //returns whether pacman can move i.e. there is no wall in the direction of vel
  boolean checkPosition() {

    if (isCriticalPosition(pos)) {//if on a critical position

      PVector matrixPosition = pixelToTile(pos);//convert position to an array position

      //check if the position has been eaten or not, note the blank spaces are initialised as already eaten
      if (!tiles[floor(matrixPosition.y)][floor(matrixPosition.x)].eaten) {
        tiles[floor(matrixPosition.y)][floor(matrixPosition.x)].eaten =true;
        score +=1;//add a point
        ttl = 600;
        if (tiles[floor(matrixPosition.y)][floor(matrixPosition.x)].bigDot && bigDotsActive) {//if big dot eaten
          //set all ghosts to frightened
          if (!blinky.returnHome && !blinky.deadForABit) {


            blinky.frightened = true;
            blinky.flashCount = 0;
          }
          if (!clyde.returnHome && !clyde.deadForABit) {


            clyde.frightened = true;
            clyde.flashCount = 0;
          }
          if (!pinky.returnHome && !pinky.deadForABit) {


            pinky.frightened = true;
            pinky.flashCount = 0;
          }
          if (!inky.returnHome && !inky.deadForABit) {


            inky.frightened = true;
            inky.flashCount = 0;
          }
        }
      }


      PVector positionToCheck= new PVector(matrixPosition.x + turnTo.x, matrixPosition.y+ turnTo.y); // the position in the tiles double array that the player is turning towards

      if (tiles[floor(positionToCheck.y)][floor(positionToCheck.x)].wall) {//check if there is a free space in the direction that it is going to turn
        if (tiles[floor(matrixPosition.y + vel.y)][floor(matrixPosition.x + vel.x)].wall) {//if not check if the path ahead is free
          vel = new PVector(turnTo.x, turnTo.y);
          return false;//if neither are free then dont move
        } else {//forward is free
          return true;
        }
      } else {//free to turn
        vel = new PVector(turnTo.x, turnTo.y);
        //vel.mult(3);

        return true;
      }
    } else {
      PVector ahead = new PVector(pos.x + 10 * vel.x, pos.y + 10*vel.y);
      if (isCriticalPosition(ahead)) {//if 10 places off a critical position in the direction that pacman is moving
        PVector matrixPosition = pixelToTile(ahead);//convert that position to an array position
        if (!tiles[floor(matrixPosition.y)][floor(matrixPosition.x)].eaten ) {//if that tile has not been eaten 
          tiles[floor(matrixPosition.y)][floor(matrixPosition.x)].eaten =true;//eat it
          score +=1;
          ttl = 600;

          if (tiles[floor(matrixPosition.y)][floor(matrixPosition.x)].bigDot && bigDotsActive) {//big dot eaten
            //set all ghosts as frightened
            if (!blinky.returnHome && !blinky.deadForABit) {


              blinky.frightened = true;
              blinky.flashCount = 0;
            }
            if (!clyde.returnHome && !clyde.deadForABit) {


              clyde.frightened = true;
              clyde.flashCount = 0;
            }
            if (!pinky.returnHome && !pinky.deadForABit) {


              pinky.frightened = true;
              pinky.flashCount = 0;
            }
            if (!inky.returnHome && !inky.deadForABit) {


              inky.frightened = true;
              inky.flashCount = 0;
            }
          }
        }
      }
      if (turnTo.x + vel.x == 0 && vel.y + turnTo.y ==0) {//if turning chenging directions entirely i.e. 180 degree turn
        vel = new PVector(turnTo.x, turnTo.y);//turn
        //vel.mult(3);
        return true;
      }
      return true;//if not on a critical postion then continue forward
    }
  }
}