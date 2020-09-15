class Tile {
  boolean wall = false;
  boolean dot = false;
  boolean bigDot = false;
  boolean eaten = false;
  PVector pos;
  //-------------------------------------------------------------------------------------------------------------------------------------------
  //constructor
  Tile(float x, float y) {
    pos = new PVector(x, y);
  }
  //-----------------------------------------------------------------------------------------------------------------------------------------------
  //draw a dot if there is one in this tile
  void show() {
    rectMode(CENTER);
    if (dot) {
      if (!eaten) {//draw dot
        fill(255, 255, 0);
        noStroke();
        rect(pos.x, pos.y, 4, 4);
      }
    } else if (bigDot) {
      if (!eaten) {//draw big dot
        fill(255, 255, 0);
        noStroke();
        if (bigDotsActive) {
          rect(pos.x, pos.y, 9, 9);
        } else {
          rect(pos.x, pos.y, 4, 4);
        }
      }
    }
  }
//-------------------------------------------------------------------------------------------------------------------------------------------------------
//returns a copy of this tile
  Tile clone() {
    Tile clone = new Tile(pos.x, pos.y);
    clone.wall = wall;
    clone.dot = dot;
    clone.bigDot  = bigDot;
    clone.eaten = eaten;
    return clone;
  }
}