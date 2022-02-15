class Ball {
  float x; 
  float y;
  float dx; 
  float dy;
  int radius;
  float ballSpeed = 0.01;
  int ballSpeedCount = 0;
  color ballColor = color(200, 100, 50);
  Ball(){
    x = random(SCREENX/4, SCREENX/2);
    y = random(SCREENY/4, SCREENY/2);
    dx = random(1, 1.3); 
    dy = random(1, 1.3);
    radius=10;
    
  }
  
  void move(){
    if (dx < 0)
    {
    x = x+((dx - ballSpeed)/1.5); 
    }
    else x = x+((dx + ballSpeed)/1.5); 
    if (dy < 0)
    {
    y = y+((dy - ballSpeed)/1.5);
    }
    else y = y+((dy + ballSpeed)/1.5);
    if (ballSpeedCount%1000 == 0)
    {
        ballSpeed = ballSpeed + 0.00005;
    }  
    text("Current speed = ", 0, SCREENY - 10); 
    text(ballSpeed, 90, SCREENY - 10); 
  }
  
  void draw(){
    fill(ballColor);
    ellipse(int(x), int(y), radius,
    radius);
  }
  
  void collide(Player tp){
    //Hits Wall
    if(x-radius <= 0) dx=-dx;
    else if(x+radius >= SCREENX) dx=-dx;
    
    //Hits Wall Safety
    if(x-radius <= -2) x= 1 + radius;
    else if(x+radius >= SCREENX+1) x=(SCREENX-2)-radius;
    
    if(y+radius >= tp.ypos &&          //if the y position of ball is greater than the paddle i.e lower down  
    y-radius<tp.ypos+PADDLEHEIGHT &&   // and if the y minus the size of the ball is less than the top of the paddle 
    x >=tp.xpos && x <=                // and x of ball is greater than/ equal to the paddle position start
    tp.xpos+PADDLEWIDTH){              // and x of ball is greater than/ equal to the paddle position end .these last two comments are asking if its between the paddle, i.e on the paddle
    println("Collided!");              // think the first two lines are asking if the ball is at the same height as the paddle
    dy=-(dy+ballSpeed);
    }
    
    // Runs through paddle Safety Net
    if(y+radius >= tp.ypos &&         
    y-radius<tp.ypos+(PADDLEHEIGHT/1.3) &&   
    x >=tp.xpos && x <=                
    tp.xpos+PADDLEWIDTH){            
    y= y - (PADDLEHEIGHT/2);
    }
  }
  
  void collideComp(Player tp){

    //Hits Paddle
    if(y+radius >= tp.compy &&          
    y-radius<tp.compy+PADDLEHEIGHT &&  
    x >=tp.compx && x <=                
    tp.compx+PADDLEWIDTH){             
    println("Collided!");              
    dy = -(dy+ballSpeed);
    }
    
    // Runs through paddle Safety Net
    if(y+radius >= tp.compy &&         
    y-radius<tp.compy+(PADDLEHEIGHT/1.3) &&   
    x >=tp.compx && x <=                
    tp.compx+PADDLEWIDTH){            
    y= y + (PADDLEHEIGHT/2);
    }
  }
}