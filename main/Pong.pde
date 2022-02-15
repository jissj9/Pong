
Player thePlayer;
Ball theBall;
Player computerPlayer;
int delay = 0;
int oldMouse;
  void settings(){
    size(SCREENX, SCREENY);
  }
  
  void setup(){
    thePlayer = new Player(SCREENY-MARGIN-PADDLEHEIGHT);
    theBall = new Ball();
    computerPlayer = new Player(SCREENY-MARGIN-PADDLEHEIGHT);
    ellipseMode(RADIUS);
    
    
  }
  
  void draw() {
    frameRate(300);
    if (delay%100 == 0)
      oldMouse = mouseX;
    background(0);
    thePlayer.move(mouseX, theBall, thePlayer);
    theBall.move();
    computerPlayer.moveComp(theBall);
    theBall.collide(thePlayer);
    theBall.collideComp(computerPlayer);    
    thePlayer.draw(); //<>//
    theBall.draw();
    thePlayer.reset(theBall);
    thePlayer.lifeCount(theBall);
    delay++; 
    
  }