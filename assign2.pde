PImage title, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage bg,skyImage,titleImage,lifeImage,cabbageImage,groundhogImage,stone1Image,stone2Image,groundhogLeft,groundhogRight,groundhogDown,soilImage,soldierImage;


boolean upPressed, downPressed, rightPressed, leftPressed;

final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_OVER = 2;
int gameState = GAME_START;

final int STOP=0; 
final int DOWNWARD=1;
final int LEFTWARD=2; 
final int RIGHTWARD=3;
int movement=STOP;

int soldierX=-80;
int soldierY=floor(random(2,6))*80;

float robotX=floor(random(3,8))*80;
int robotY=floor(random(2,6))*80;

float cabbageX=floor(random(0,8))*80;
float cabbageY=floor(random(2,6))*80;

float groundhogX=320;
float groundhogY=80;

int lifeX=10;




void setup() {
	size(640, 480, P2D);
	size(640, 480, P2D);

  skyImage=loadImage("img/bg.jpg");
  soilImage=loadImage("img/soil.png");
  lifeImage=loadImage("img/life.png");
  soldierImage = loadImage("img/soldier.png");
  titleImage = loadImage("img/title.jpg");
  startNormal = loadImage("img/startNormal.png");
  startHovered = loadImage("img/startHovered.png");
  cabbageImage = loadImage("img/cabbage.png");
  groundhogImage=loadImage("img/groundhogIdle.png");
  groundhogDown=loadImage("img/groundhogDown.png");
  groundhogLeft=loadImage("img/groundhogLeft.png");
  groundhogRight=loadImage("img/groundhogRight.png");
  gameover=loadImage("img/gameover.jpg");
  restartNormal=loadImage("img/restartNormal.png");
  restartHovered=loadImage("img/restartHovered.png");
  
}

void draw() {
  
  
  
	// Switch Game State
switch(gameState){
  
    case GAME_START:
    
    
      if(mouseX > 248 && mouseX < 392
      && mouseY > 360 && mouseY < 420){
        image(titleImage,0,0);
        image(startHovered,248,360);
        if(mousePressed){
          gameState = GAME_RUN;
        }
      }else{
        image(titleImage,0,0);
        image(startNormal,248,360);
        
      }
    break;
    
    case GAME_RUN:
    //sky
    image(skyImage,0,0);
    
    //soil
    image(soilImage,0,160);
    
    //life
    image(lifeImage,lifeX-70,10);
    image(lifeImage,lifeX,10);
    image(lifeImage,lifeX+70,10);
    
    
    //grass
    noStroke();
    fill(124,204,25);
    rect(0,145,640,15);
    
    //sun
    fill(253, 184, 19);
    stroke(255,255,0);
    strokeWeight(5);
    ellipse(590,50,120,120);
    
    //cabbage
    image(cabbageImage,cabbageX,cabbageY);
    
    //soldier
    image(soldierImage,soldierX,soldierY);
    soldierX+=3;
    if(soldierX>640){
      soldierX=-80;
    }
  
    switch(movement){
        case STOP:
          groundhogImage = loadImage("img/groundhogIdle.png");
          groundhogY+=0;
        break;
        case DOWNWARD:
          groundhogY+=5;
          groundhogImage = loadImage("img/groundhogDown.png");
          if(groundhogY%80==0){movement=STOP;}
        break;
        case LEFTWARD:
          groundhogX-=5;
          groundhogImage = loadImage("img/groundhogLeft.png");
          if(groundhogX%80==0){movement=STOP;}
        break;
        case RIGHTWARD:
          groundhogX+=5;
          groundhogImage = loadImage("img/groundhogRight.png");
          if(groundhogX%80==0){movement=STOP;}
        break;
     }
    //groundhog
    image(groundhogImage,groundhogX,groundhogY);
    
    
    
    
   
      if(downPressed){        
        if(groundhogY >=400) groundhogY = 400;
      }
      
      if(leftPressed){       
        if(groundhogX <=0) groundhogX = 0;
      }
      if(rightPressed){
        if(groundhogX >=560) groundhogX = 560;
      }
      
      if(soldierX<groundhogX+80 && soldierX+80>groundhogX && soldierY<groundhogY+80 && soldierY+80>groundhogY){
        groundhogX=320;
        groundhogY=80;
        lifeX=lifeX-70;
        
      }
      
      if(cabbageX<groundhogX+80 && cabbageX+80>groundhogX && cabbageY<groundhogY+80 &&cabbageY+80>groundhogY){
       
        lifeX=lifeX+70;
        cabbageX=800;
        cabbageY=800;
        
        
        
      }
      
      if(lifeX<-70){
       gameState = GAME_OVER;
      }
      break;
        
    
    
    
    case GAME_OVER:
    if(mouseX > 248 && mouseX < 392
      && mouseY > 360 && mouseY < 420){
        image(gameover,0,0);
        image(restartHovered,248,360);
        if(mousePressed){
          gameState = GAME_RUN;
          lifeX=10;
          cabbageX=floor(random(0,8))*80;
          cabbageY=floor(random(2,6))*80;
          soldierY=floor(random(2,6))*80;
          movement=STOP;
        }
      }else{
        image(gameover,0,0);
        image(restartNormal,248,360);
      }

    break;
        
      }

   
      
}
	

void keyPressed(){
  if(groundhogX%80==0 && groundhogY%80==0){
  switch(keyCode){
    case DOWN:
    downPressed = true;
    if(groundhogY+80<height){movement=DOWNWARD;}
    break;
    case RIGHT:
    rightPressed = true;
    if(groundhogX+80<width){movement=RIGHTWARD;}
    break;
    case LEFT:
    leftPressed = true;
    if(groundhogX>0){movement=LEFTWARD;}
    break;
  }
  }
}

void keyReleased(){
  switch(keyCode){
    case DOWN:
    downPressed = false;
    break;
    case RIGHT:
    rightPressed = false;
    break;
    case LEFT:
    leftPressed = false;
    break;
  }
}
