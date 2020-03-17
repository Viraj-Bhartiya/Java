//this class is useless it just shows some dots on the ground

class Ground{
  float posX = width;
  float posY = height -floor(random(groundHeight-height ,groundHeight +30));
  int w = floor(random(1,10));
  
  Ground(){}
 
  void show(){
    stroke(255);
    strokeWeight(3);
    line(posX,posY, posX + w, posY);

  }
  void move(float speed) {
    posX -= speed;
  } 
}
