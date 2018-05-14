boolean reset;//when reset turns true, the game resets and reset is turned false
boolean w, l;//booleans for winning and loosing
PImage wface, lface, nface;//images for faces

int timer;//timer variable

void setup () {//void setup
  size (400, 500);//frame size
  frameRate(30);//how many times the program executes a second
  imageMode(CENTER);//all images are drawn in the center

  wface = loadImage("smiley face with sunglasses.png");//face for winning
  lface = loadImage("sad smiley face.png");//face for losing
  nface = loadImage("smiley face.png");//resting face
}//end of set up

void draw () {//void draw
  background(255);//fills in the background

  //faces below+reset button
  ////////////////////////////////////////////////////////////////////////////
  fill(255);//fills in the images 

  if (mouseX>180 && mouseX < 220 && mouseY > 30 && mouseY < 70) {//detects mouse over the button
    fill(255, 255, 0);//changes the buttons colour
    if (mousePressed)//if the user clicks the game resets
      reset=true;//resets the game
  }

  rectMode(CENTER);
  rect(200, 50, 40, 40);//reset button

  if (w==false && l==false) {//if the player is playing the game the face stays neutral
    image(nface, 200, 50, 30, 30);//has the neutral face
  }
  if (w==true) {//w goes true if they win
    image(wface, 200, 50, 30, 30);//has the winning face on
  }
  if (l==true) {//l goes true if they lose
    image(lface, 200, 50, 30, 30);//has the losing face on
  }
  ////////////////////////////////////////////////////////////////////////////

  //timer below
  /////////////////////////////////////////////////////////////////////////////
  fill(255);//fills text
  timer=timer+1;//increases timer
  rect(345, 45, 40, 14);//border of timer
  fill(255, 0, 0);//fills text
  text(""+int(timer/30), 330, 50);//displays timer and only displays whole numbers, every second. the /30 is because of the frame rate
  /////////////////////////////////////////////////////////////////////////////
}//end of void draw
