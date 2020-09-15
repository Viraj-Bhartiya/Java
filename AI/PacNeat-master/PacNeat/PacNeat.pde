//Pacman AI
//this program requires a desktop screen 1920 x 1080 to look sexy


//import stuff for pathfinding
import java.util.Deque;
import java.util.Iterator;
import java.util.LinkedList;

//Pacman pacman;
PImage img;//background image 
PImage pac;//background image 
PImage blinkySprite;
PImage pinkySprite;
PImage inkySprite;
PImage clydeSprite;
PImage frightenedSprite;
PImage frightenedSprite2;
PImage deadSprite;

int nextConnectionNo = 1000;
Population pop;
int speed = 60;


boolean showBest = true;//true if only show the best of the previous generation
boolean runBest = false; //true if replaying the best ever game
boolean humanPlaying = false; //true if the user is playing

Player humanPlayer;

boolean runThroughSpecies = false;
int upToSpecies = 0;
Player speciesChamp;

boolean showBrain = false;

boolean showBestEachGen = false;
int upToGen = 0;
Player genPlayerTemp;


boolean blinkyActive = false;
boolean pinkyActive = false;
boolean inkyActive = false;
boolean clydeActive = false;

boolean bigDotsActive = false;

int usingInputsStart = 4;
int usingInputsEnd = 11;

int upToStage = 1;

boolean showNothing = false;

int previousBest = 0;
Tile[][] originalTiles = new Tile[31][28]; //note it goes y then x because of how I inserted the data
int[][] tilesRepresentation = { 
  {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
  {1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1}, 
  {1, 8, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 8, 1}, 
  {1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1}, 
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
  {1, 0, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 0, 1}, 
  {1, 0, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 0, 1}, 
  {1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 6, 1, 1, 6, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 6, 1, 1, 6, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 1, 1, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 1, 1, 0, 1, 1, 1, 1, 1, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 1, 1, 6, 1, 1, 1, 1, 1, 1, 1, 1, 6, 1, 1, 0, 1, 1, 1, 1, 1, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 1, 1, 6, 1, 1, 1, 1, 1, 1, 1, 1, 6, 1, 1, 0, 1, 1, 1, 1, 1, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 6, 6, 6, 1, 1, 1, 1, 1, 1, 1, 1, 6, 6, 6, 0, 1, 1, 1, 1, 1, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 1, 1, 6, 1, 1, 1, 1, 1, 1, 1, 1, 6, 1, 1, 0, 1, 1, 1, 1, 1, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 1, 1, 6, 1, 1, 1, 1, 1, 1, 1, 1, 6, 1, 1, 0, 1, 1, 1, 1, 1, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 1, 1, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 1, 1, 0, 1, 1, 1, 1, 1, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 1, 1, 6, 1, 1, 1, 1, 1, 1, 1, 1, 6, 1, 1, 0, 1, 1, 1, 1, 1, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 1, 1, 6, 1, 1, 1, 1, 1, 1, 1, 1, 6, 1, 1, 0, 1, 1, 1, 1, 1, 1}, 
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
  {1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1}, 
  {1, 8, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 8, 1}, 
  {1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1}, 
  {1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1}, 
  {1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1}, 
  {1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1}, 
  {1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1}, 
  {1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1}, 
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
  {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}};//its not sexy but it does the job
//--------------------------------------------------------------------------------------------------------------------------------------------------

void setup() {
  frameRate(100);
  //size(448, 496);
  fullScreen();
  img = loadImage("map.jpg");
  blinkySprite = loadImage("blinky20000.png");
  pinkySprite = loadImage("pinky20000.png");
  inkySprite = loadImage("inky20000.png");
  clydeSprite = loadImage("clyde20000.png");
  frightenedSprite = loadImage("frightenedGhost0000.png");
  frightenedSprite2 = loadImage("frightenedGhost20000.png");
  deadSprite = loadImage("deadGhost0000.png");
  //  blinkySprite = resizeBasic(blinkySprite, 2);
  //((PGraphicsOpenGL)g).textureSampling(3);
  img = resizeBasic(img, 2);
  pac = loadImage("pac.png");


  //img.resize(448 *3, 496 *3);
  //initiate tiles
  for (int i = 0; i< 28; i++) {
    for (int j = 0; j< 31; j++) {
      PVector tileCoords = tileToPixel(new PVector(i, j));
      originalTiles[j][i] = new Tile(tileCoords.x, tileCoords.y);
      switch(tilesRepresentation[j][i]) {
      case 1: //1 is a wall
        originalTiles[j][i].wall = true;
        break;
      case 0: // 0 is a dot
        originalTiles[j][i].dot = true;
        break;
      case 8: // 8 is a big dot
        //originalTiles[j][i].dot = true;
        originalTiles[j][i].bigDot = true;
        break;
      case 6://6 is a blank space
        originalTiles[j][i].eaten = true;
        break;
      }
    }
  }

  pop = new Population(500);
  humanPlayer = new Player();
}
//--------------------------------------------------------------------------------------------------------------------------------------------------
PImage resizeBasic(PImage in, int factor) {
  PImage out = createImage(in.width * factor, in.height * factor, RGB);
  in.loadPixels();
  out.loadPixels();
  for (int y=0; y<in.height; y++) {
    for (int x=0; x<in.width; x++) {
      int index = x + y * in.width;
      for (int h=0; h<factor; h++) {
        for (int w=0; w<factor; w++) {
          int outdex = x * factor + w + (y * factor + h) * out.width;
          out.pixels[outdex] = in.pixels[index];
        }
      }
    }
  }
  out.updatePixels();
  return out;
}
//--------------------------------------------------------------------------------------------------------------------------------------------------------
void draw() {
  drawToScreen();
  if (showBestEachGen) {//show the best of each gen
    if (!genPlayerTemp.dead) {//if current gen player is not dead then update it

      genPlayerTemp.look();
      genPlayerTemp.think();

      genPlayerTemp.update();
      genPlayerTemp.show();
    } else {//if dead move on to the next generation
      upToGen ++;
      if (upToGen >= pop.genPlayers.size()) {//if at the end then return to the start and stop doing it
        upToGen= 0;
        showBestEachGen = false;
        enterStage(upToStage);
      } else {//if not at the end then get the next generation
        println("STAGE", pop.genPlayers.get(upToGen).stage);
        enterStage(pop.genPlayers.get(upToGen).stage);
        genPlayerTemp = pop.genPlayers.get(upToGen).cloneForReplay();
      }
    }
  } else
    if (runThroughSpecies ) {//show all the species 
      if (!speciesChamp.dead) {//if best player is not dead
        speciesChamp.look();
        speciesChamp.think();
        speciesChamp.update();
        speciesChamp.show();
      } else {//once dead
        upToSpecies++;
        if (upToSpecies >= pop.species.size()) { 
          runThroughSpecies = false;
        } else {
          speciesChamp = pop.species.get(upToSpecies).champ.cloneForReplay();
        }
      }
    } else {
      if (humanPlaying) {//if the user is controling the ship[
        if (!humanPlayer.dead) {//if the player isnt dead then move and show the player based on input
          humanPlayer.look();
          humanPlayer.update();
          humanPlayer.show();
        } else {//once done return to ai
          humanPlaying = false;
        }
      } else 
      if (runBest) {// if replaying the best ever game
        if (!pop.bestPlayer.dead) {//if best player is not dead
          pop.bestPlayer.look();
          pop.bestPlayer.think();
          pop.bestPlayer.update();
          pop.bestPlayer.show();
        } else {//once dead
          runBest = false;//stop replaying it
          pop.bestPlayer = pop.bestPlayer.cloneForReplay();//reset the best player so it can play again
        }
      } else {//if just evolving normally
        if (!pop.done()) {//if any players are alive then update them
          pop.updateAlive();
        } else {//all dead
          //genetic algorithm 

          switch(pop.gen) {
          case 20:
            if (pop.bestScore < 200) {
              pop = new Population(500); 
              return;
            }
            upToStage = 3;
            enterStage(3);

            pop.newStage = true;
            break;
          case 60:

            upToStage = 4;
            enterStage(4);

            pop.newStage = true;
            break;

          case 120:
            if (pop.bestScore < 220) {
              pop = new Population(500);
              return;
            }
          }

          pop.naturalSelection();
        }
      }
    }
}

//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
void enterStage(int stageNo) {
  switch(stageNo) {
  case 1:
    usingInputsStart =  4;
    usingInputsEnd =  11;
    blinkyActive = false;
    inkyActive = false;
    pinkyActive = false;
    clydeActive  = false;
    bigDotsActive = false;

    break;
  case 2:
    usingInputsStart =  0;
    usingInputsEnd =  11;
    blinkyActive = true;
    inkyActive = false;
    pinkyActive = true;
    clydeActive  = false;
    bigDotsActive = false;
    break;
  case 3:
    usingInputsStart =  0;
    usingInputsEnd =  11;
    blinkyActive = true;
    inkyActive = true;
    pinkyActive = true;
    clydeActive  = true;
    bigDotsActive = false;
    break;
  case 4:
    usingInputsStart =  0;
    usingInputsEnd =  12;
    blinkyActive = true;
    inkyActive = true;
    pinkyActive = true;
    clydeActive  = true;
    bigDotsActive = true;
    break;
  }
}
//---------------------------------------------------------------------------------------------------------------------------------------------------
//reset population data when entering a new stage
void enterNewStage() {
  pop.bestScore = 0;
  for (int  i=  0; i < pop.species.size(); i++) {
    pop.species.get(i).bestFitness = 0;
  }
  for (int i  = 0; i< pop.pop.size(); i++) {
    pop.pop.get(i).bestScore = 0;
    pop.pop.get(i).fitness = 0;
    pop.pop.get(i).score = 0;
  }
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
//draws the display screen
void drawToScreen() {
  if (!showNothing) {
    noStroke();
    strokeWeight(10);
    background(10);
    fill(0);
    rectMode(CORNERS);
    rect(0, height/2 +100, width, height);
    rect(498, 0, 502 + 448*2, height - 496 *2);
    strokeWeight(10);
    stroke(29, 48, 137);
    line(0, height/2 + 100, width, height/2+100);
    stroke(32, 56, 178);
    strokeWeight(5);

    line(0, height/2 + 100, width, height/2+100);

    image(img, 500, height - 496 *2);
    strokeWeight(10);
    stroke(29, 48, 137);
    line(498, 0, 498, height);
    line(502 + 448 *2, 0, 502 + 448 *2, height);
    stroke(32, 56, 178);
    strokeWeight(5);

    line(498, 0, 498, height);
    line(502 + 448 *2, 0, 502 + 448 *2, height);
    
    
    drawBrain();
    writeInfo();
  }
}
//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
void drawBrain() {  //show the brain of whatever genome is currently shoeing
  if (runThroughSpecies) {
    speciesChamp.brain.drawGenome(502 + 448 *2, height/2 + 100, width -( 502 + 448 *2), height - (height/2 + 100));
  } else
    if (runBest) {
      pop.bestPlayer.brain.drawGenome(502 + 448 *2, height/2 + 100, width -( 502 + 448 *2), height - (height/2 + 100));
    } else
      if (humanPlaying) {
        showBrain = false;
      } else if (showBestEachGen) {
        genPlayerTemp.brain.drawGenome(502 + 448 *2, height/2 + 100, width -( 502 + 448 *2), height - (height/2 + 100));
      } else {
        pop.pop.get(0).brain.drawGenome(502 + 448 *2, height/2 + 100, width -( 502 + 448 *2), height - (height/2 + 100));
      }
}
//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//writes info about the current player
void writeInfo() {
  fill(200);
  textAlign(LEFT);
  textSize(30);
  if (showBestEachGen) {
    text("Score: " + genPlayerTemp.score, 650, 50);
    text("Gen: " + (genPlayerTemp.gen +1), 1150, 50);
    text("Stage: " + genPlayerTemp.stage, 50, height/2 + 200);
  } else
    if (runThroughSpecies) {
      text("Score: " + speciesChamp.score, 650, 50);
      text("Species: " + (upToSpecies +1), 1150, 50);
      text("Players in this Species: " + pop.species.get(upToSpecies).players.size(), 50, height/2 + 200);
    } else
      if (humanPlaying) {
        text("Score: " + humanPlayer.score, 650, 50);
      } else
        if (runBest) {
          text("Score: " + pop.bestPlayer.score, 650, 50);
          text("Gen: " + pop.gen, 1150, 50);
        } else {
          if (showBest) {          
            text("Score: " + pop.pop.get(0).score, 650, 50);
            text("Gen: " + pop.gen, 1150, 50);


            text("Species: " + pop.species.size(), 50, height/2 + 300);
            text("Global Best Score: " + pop.bestScore, 50, height/2 + 200);
          }
        }
}

//--------------------------------------------------------------------------------------------------------------------------------------------------

void keyPressed() {
  switch(key) {
  case ' ':
    //toggle showBest
    showBest = !showBest;
    break;
  case '+'://speed up frame rate
    speed += 10;
    frameRate(speed);
    println(speed);
    break;
  case '-'://slow down frame rate
    if (speed > 10) {
      speed -= 10;
      frameRate(speed);
      println(speed);
    }
    break;
  case 'b'://run the best
    runBest = !runBest;
    break;
  case 's'://show species
    runThroughSpecies = !runThroughSpecies;
    upToSpecies = 0;
    speciesChamp = pop.species.get(upToSpecies).champ.cloneForReplay();
    break;
  case 'g'://show generations
    showBestEachGen = !showBestEachGen;
    upToGen = 0;
    enterStage(pop.genPlayers.get(upToGen).stage);
    genPlayerTemp = pop.genPlayers.get(upToGen).clone();
    break;
  case 'n'://show absolutely nothing in order to speed up computation
    showNothing = !showNothing;
    break;
  case 'p'://play
    humanPlaying = !humanPlaying;
    humanPlayer = new Player();
    break; 
  case CODED://any of the arrow keys
    switch(keyCode) {
    case UP://the only time up/ down / left is used is to control the player
      humanPlayer.pacman.turnTo = new PVector(0, -1);
      humanPlayer.pacman.turn = true;
      break;
    case DOWN:
      humanPlayer.pacman.turnTo = new PVector(0, 1);
      humanPlayer.pacman.turn = true;
      break;
    case LEFT:
      humanPlayer.pacman.turnTo = new PVector(-1, 0);
      humanPlayer.pacman.turn = true;
      break;
    case RIGHT://right is used to move through the generations
      if (runThroughSpecies) {//if showing the species in the current generation then move on to the next species
        upToSpecies++;
        if (upToSpecies >= pop.species.size()) {
          runThroughSpecies = false;
        } else {
          speciesChamp = pop.species.get(upToSpecies).champ.cloneForReplay();
        }
      } else 
      if (showBestEachGen) {//if showing the best player each generation then move on to the next generation
        upToGen++;
        if (upToGen >= pop.genPlayers.size()) {//if reached the current generation then exit out of the showing generations mode
          showBestEachGen = false;
          enterStage(upToStage);
        } else {
          enterStage(pop.genPlayers.get(upToGen).stage);
          genPlayerTemp = pop.genPlayers.get(upToGen).cloneForReplay();
        }
      } else if (humanPlaying) {//if the user is playing then move pacman right

        humanPlayer.pacman.turnTo = new PVector(1, 0);
        humanPlayer.pacman.turn = true;
      }
      break;
    }
    break;
  }
}
//--------------------------------------------------------------------------------------------------------------------------------------------------
//returns the nearest non wall tile to the input vector
//input is in tile coordinates
PVector getNearestNonWallTile(PVector target) {
  float min = 1000;

  int minIndexj = 0;
  int minIndexi = 0;
  for (int i = 0; i< 28; i++) {//for each tile
    for (int j = 0; j< 31; j++) {
      if (!originalTiles[j][i].wall) {//if its not a wall
        if (dist(i, j, target.x, target.y)<min) { //if its the current closest to target
          min =  dist(i, j, target.x, target.y);
          minIndexj = j;
          minIndexi = i;
        }
      }
    }
  }

  return (new PVector(minIndexi, minIndexj));//return a PVector to the tile
}

//----------------------------------------------------------------------------------------------------------------------------------------------
//converts tile coordinates to pixel coords

PVector tileToPixel(PVector tileCoord) {
  PVector pix = new PVector(tileCoord.x * 16 +8, tileCoord.y * 16 +8);
  pix.mult(2);//scaleUp
  pix.x += 500;
  pix.y +=  height - 496 *2.0;
  return pix;
}

//---------------------------------------------------------------------------------------------------------------------------------------------------
//converts pixel coordinates to tile coordinates

PVector pixelToTile(PVector pix) {

  PVector tileCoord = new PVector(pix.x - 500, pix.y - (height - 496 *2));
  tileCoord.x /= 2.0;
  tileCoord.y /= 2.0;

  PVector finalTileCoord = new PVector((tileCoord.x-8)/16, (tileCoord.y - 8)/16);
  return finalTileCoord;
}

//---------------------------------------------------------------------------------------------------------------------------------------------------
//checks whether the parameter position is in the center of a tile

boolean isCriticalPosition(PVector pos) {
  PVector tileCoord = new PVector(pos.x - 500, pos.y - height - 496 *2);
  tileCoord.x /= 2.0;
  tileCoord.y /= 2.0;
  return ((tileCoord.x-8)%16 == 0 && (tileCoord.y - 8)% 16 ==0);
}
//--------------------------------------------------------------------------------------------------------------------------------------------------
//returns the shortest path from the start node to the finish node
Path AStar(PathNode start, PathNode finish, PVector vel)
{
  LinkedList<Path> big = new LinkedList<Path>();//stores all paths
  Path extend = new Path(); //a temp Path which is to be extended by adding another node
  Path winningPath = new Path();  //the final path
  Path extended = new Path(); //the extended path
  LinkedList<Path> sorting = new LinkedList<Path>();///used for sorting paths by their distance to the target

  //startin off with big storing a path with only the starting node
  extend.addToTail(start, finish);
  extend.velAtLast = new PVector(vel.x, vel.y);//used to prevent ghosts from doing a u turn
  big.add(extend);


  boolean winner = false;//has a path from start to finish been found  

  while (true) //repeat the process until ideal path is found or there is not path found 
  {

    extend = big.pop();//grab the front path form the big to be extended
    if (extend.path.getLast().equals(finish)) //if goal found
    {
      if (!winner) //if first goal found, set winning path
      {
        winner = true;
        winningPath = extend.clone();
      } else { //if current path found the goal in a shorter distance than the previous winner 
        if (winningPath.distance > extend.distance)
        {
          winningPath = extend.clone();//set this path as the winning path
        }
      }
      if (big.isEmpty()) //if this extend is the last path then return the winning path
      {
        return winningPath.clone();
      } else {//if not the current extend is useless to us as it cannot be extended since its finished
        extend = big.pop();//so get the next path
      }
    } 


    //if the final node in the path has already been checked and the distance to it was shorter than this path has taken to get there than this path is no good
    if (!extend.path.getLast().checked || extend.distance < extend.path.getLast().smallestDistToPoint)
    {     
      if (!winner || extend.distance + dist(extend.path.getLast().x, extend.path.getLast().y, finish.x, finish.y)  < winningPath.distance) //dont look at paths that are longer than a path which has already reached the goal
      {

        //if this is the first path to reach this node or the shortest path to reach this node then set the smallest distance to this point to the distance of this path
        extend.path.getLast().smallestDistToPoint = extend.distance;

        //move all paths to sorting form big then add the new paths (in the for loop)and sort them back into big.
        sorting = (LinkedList)big.clone();
        PathNode tempN = new PathNode(0, 0);//reset temp node
        if (extend.path.size() >1) {
          tempN = extend.path.get(extend.path.size() -2);//set the temp node to be the second last node in the path
        }

        for (int i =0; i< extend.path.getLast().edges.size(); i++) //for each node incident (connected) to the final node of the path to be extended 
        {
          if (tempN != extend.path.getLast().edges.get(i))//if not going backwards i.e. the new node is not the previous node behind it 
          {     

            //if the direction to the new node is in the opposite to the way the path was heading then dont count this path
            PVector directionToPathNode = new PVector( extend.path.getLast().edges.get(i).x -extend.path.getLast().x, extend.path.getLast().edges.get(i).y - extend.path.getLast().y );
            directionToPathNode.limit(vel.mag());
            if (directionToPathNode.x == -1* extend.velAtLast.x && directionToPathNode.y == -1* extend.velAtLast.y ) {
            } else {//if not turning around
              extended = extend.clone();
              extended.addToTail(extend.path.getLast().edges.get(i), finish);
              extended.velAtLast = new PVector(directionToPathNode.x, directionToPathNode.y);
              sorting.add(extended.clone());//add this extended list to the list of paths to be sorted
            }
          }
        }


        //sorting now contains all the paths form big plus the new paths which where extended
        //adding the path which has the higest distance to big first so that its at the back of big.
        //using selection sort i.e. the easiest and worst sorting algorithm
        big.clear();
        while (!sorting.isEmpty())
        {

          float max = -1;
          int iMax = 0;
          for (int i = 0; i < sorting.size(); i++)
          {
            if (max < sorting.get(i).distance + sorting.get(i).distToFinish)//A* uses the distance from the goal plus the paths length to determine the sorting order
            {
              iMax = i;
              max = sorting.get(i).distance + sorting.get(i).distToFinish;
            }
          }
          big.addFirst(sorting.remove(iMax).clone());//add it to the front so that the ones with the greatest distance end up at the back
          //and the closest ones end up at the front
        }
      }
      extend.path.getLast().checked = true;
    }
    //if no more paths avaliable
    if (big.isEmpty()) {
      if (winner ==false) //there is not path from start to finish
      {
        //print("FUCK!!!!!!!!!!");//error message 
        return null;
      } else {//if winner is found then the shortest winner is stored in winning path so return that
        return winningPath.clone();
      }
    }
  }
}