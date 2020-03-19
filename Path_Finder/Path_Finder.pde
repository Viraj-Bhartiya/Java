/*
   Viraj Bhartiya
   Code Freak
   Path Finder
   
*/
float heuristic(Spot a, Spot b) {
  float d = dist(a.i, a.j, b.i, b.j);
  return d;
}

int cols = 50;
int rows = 50;

Spot[][] grid = new Spot[cols][rows];

List<Spot> openSet = new ArrayList<Spot>();
List<Spot> closedSet = new ArrayList<Spot>();

Spot start;
Spot end;
Spot current;

float w, h;

List<Spot> path = new ArrayList<Spot>();

void setup() {
  size(900, 800);
  println("A*");

  w = float(width) / cols;
  h = float(height) / rows;

  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      grid[i][j] = new Spot(i, j);
    }
  }

  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      grid[i][j].addNeighbors(grid);
    }
  }

  start = grid[0][0];
  end = grid[cols - 1][rows - 1];
  start.wall = false;
  end.wall = false;

  openSet.add(start);
}

void draw() {
  if (openSet.size() > 0) {

    int winner = 0;
    for (int i = 0; i < openSet.size(); i++) {
      if (openSet.get(i).f < openSet.get(winner).f) {
        winner = i;
      }
    }
    current = openSet.get(winner);

    if (current == end) {
      noLoop();
      println("DONE!");
    }

    openSet.remove(current);
    closedSet.add(current);

    List<Spot> neighbors = current.neighbors;
    for (int i = 0; i < neighbors.size(); i++) {
      Spot neighbor = neighbors.get(i);

      if (!closedSet.contains(neighbor) && !neighbor.wall) {
        float tempG = current.g + heuristic(neighbor, current);

        boolean newPath = false;
        if (openSet.contains(neighbor)) {
          if (tempG < neighbor.g) {
            neighbor.g = tempG;
            newPath = true;
          }
        } else {
          neighbor.g = tempG;
          newPath = true;
          openSet.add(neighbor);
        }

        if (newPath) {
          neighbor.heuristic = heuristic(neighbor, end);
          neighbor.f = neighbor.g + neighbor.heuristic;
          neighbor.previous = current;
        }
      }
    }
  } else {
    println("no solution");
    noLoop();
    return;
  }

  background(0);

  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      grid[i][j].show();
    }
  }

  for (int i = 0; i < closedSet.size(); i++) {
    closedSet.get(i).show(color(255, 0, 0, 50));
  }

  for (int i = 0; i < openSet.size(); i++) {
    openSet.get(i).show(color(0, 255, 0, 50));
  }

  List<Spot> path = new ArrayList<Spot>();
  Spot temp = current;
  path.add(temp);
  while (temp.previous != null) {
    path.add(temp.previous);
    temp = temp.previous;
  }

  noFill();
  stroke(255, 0, 200);
  strokeWeight(w / 2);
  beginShape();
  for (int i = 0; i < path.size(); i++) {
    vertex(path.get(i).i * w + w / 2, path.get(i).j * h + h / 2);
  }
  endShape();
}
