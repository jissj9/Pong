class Player {
  int xpos; 
  int ypos;
  float compx;
  float compy = MARGIN;
  color paddlecolor = color(100);
  color opponentpaddlecolor = color(255, 0, 0);
  float compImprovement = 0.001;
  int compWins = 0;
  int playerWins = 0;
  boolean gameFinished = false;
  boolean printDone = false;
  boolean gameOver = false;
  float swing = 0.003;
  float difference;
  int winCount = 501;
  int playerWinCount = 501;
  int index = 1;
  Player(int screen_y)
  {
    xpos=SCREENX/2;
    ypos=screen_y;
    compx=SCREENX/2;
  }
  
  void move(int x, Ball tb, Player tp){
    if(x>SCREENX-PADDLEWIDTH) xpos = SCREENX-PADDLEWIDTH;
    else xpos=x;
    if (winCount <= 500){
      text("Game Over!", SCREENX/2 - 30, SCREENY/2); 
      winCount++;
    }
    if (playerWinCount <= 500){
      text("Player Wins!", SCREENX/2 - 30, SCREENY/2); 
      playerWinCount++;
    }
    
    if (oldMouse > mouseX && tb.y+tb.radius >= tp.ypos &&          
        tb.y-tb.radius<tp.ypos+PADDLEHEIGHT &&   
        x >=tp.xpos && x <=                
        tp.xpos+ (PADDLEWIDTH))
    {
       difference = oldMouse - mouseX;
       tb.dx = Math.round(((difference/6) * swing) + tb.dx);
       //tb.dx = -tb.dx;
       tb.ballSpeed = tb.ballSpeed + 0.05;
    }
    else if (oldMouse < mouseX && tb.y+tb.radius >= tp.ypos &&          
        tb.y-tb.radius<tp.ypos+PADDLEHEIGHT &&   
        x >=tp.xpos && x <=                
        tp.xpos+PADDLEWIDTH)
    {
       difference =  mouseX - oldMouse;
       tb.dx = Math.round(((difference/6) * swing) + tb.dx);
       //tb.dx = -tb.dx;
       tb.ballSpeed = tb.ballSpeed + 0.05;
    }
  }
  
  void moveComp (Ball tp){
     
    if(tp.x -(PADDLEWIDTH/2) <= compx) 
    {
      compx = compx - (0.5 + compImprovement); 
    }
    else 
    {
      compx = compx + (0.5 + compImprovement);
    }
    if (compImprovement <= 1)
    {
      compImprovement = compImprovement + 0.00005;
      if (compWins == 3 )
      {
        compImprovement = 0;
      }
      else if (playerWins == 3 )
      {
        compImprovement = 0;
      }
    } else 
    if (compWins == 3 )
    {
      compImprovement = 0;
    }
    else if (playerWins == 3 )
    {
      compImprovement = 0;
    }
    
    if(compx>SCREENX-PADDLEWIDTH) compx = SCREENX-PADDLEWIDTH;
    if(compx<0) compx = 0;
    fill(opponentpaddlecolor);
    rect(compx, compy, PADDLEWIDTH, PADDLEHEIGHT);
    text("Computer Level = ", 0, 10); 
    text(compImprovement, 110, 10);
    
  }
   //<>//
  void draw()
  {
    fill(paddlecolor);
    rect(xpos, ypos, PADDLEWIDTH, PADDLEHEIGHT);
  }
  
  void reset(Ball tp){
    if (tp.y <= -1) 
    {
       gameFinished = true; 
    }
    else if (tp.y >= SCREENY )
    {
      gameFinished = true; 
    }  
    if (gameFinished == true && mousePressed == true)
    {
      tp.x = random(SCREENX/4, SCREENX/2);
      tp.y = random(SCREENY/4, SCREENY/2);
      tp.dx = random(1, 2); 
      tp.dy = random(1, 2);
      gameFinished = false;
      printDone = false;
      gameOver = false;
      tp.ballSpeed = 0;
      
    }      
  }
  
  void lifeCount(Ball tp)
  {
    text("Player Score =" , 0, SCREENY/2);
    text(playerWins, 85, SCREENY/2);
    text("Computer Score =" , SCREENX - 115, SCREENY/2);
    text(compWins, SCREENX - 10, SCREENY/2);
    if (tp.y <= 0 && printDone == false) 
    {
      playerWins = playerWins + 1; 
      println("Player Score! Score is " + playerWins + " to Player and " + compWins + " to Computer");
      printDone = true;
    }
    else if (tp.y >= SCREENY && printDone == false)
    {
      compWins = compWins + 1;
      println("Computer Score! Score is " + playerWins + " to Player and " + compWins + " to Computer");
      printDone = true;
    }
    if (playerWins >= 3 && gameOver == false)
    {
      println("Player Wins! Resetting Score.");
      compWins = 0;
      playerWins = 0;
      println("Score is " + playerWins + " to Player and " + compWins + " to Computer");
      gameOver = true;
      compImprovement = 0;
      playerWinCount = 0;
    }
    if (compWins >= 3 && gameOver == false)
    {
      println("Game Over! Resetting Score.");
      winCount = 0;
      compWins = 0;
      playerWins = 0;
      println("Score is " + playerWins + " to Player and " + compWins + " to Computer");
      gameOver = true;
      compImprovement = 0;
    }
  }
}