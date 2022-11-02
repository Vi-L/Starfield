Particle[] parts = new Particle[253]; // 250 particles, 3 stars
void setup()
{
  background(0);
  noStroke();
  size(1000, 750);
  for (int i = 0; i < parts.length; i++) {
    parts[i] = new Particle();
  }
  for (int i = 0; i < 3; i++) {
    parts[i] = new ShootingStar();
  }
}
void draw()
{
  // sky
  fill(0, 0, 0, 80); 
  rect(0, 0, width, height);
  // moon
  fill(255, 255, 0);
  ellipse(100, 100, 80, 80);
  fill(0, 0, 0);
  ellipse(120, 110, 60, 60);
  
  
  for (int i = 0; i < parts.length; i++) {
    parts[i].move();
    parts[i].fall();
    parts[i].show();
  }
  
  // ground
  fill(0, 128, 0);
  rect(0, 700, width, height); 
}

void mouseClicked() {
  fill(255);
  ellipse(mouseX, mouseY, 30, 30); // "flash" at center
  
  for (int i = 3; i < parts.length; i++) { // start at 3 so stars don't get reinitialized
    parts[i] = new Particle(mouseX, mouseY);
  }
}

class Particle
{
  double myGravity;
  double myX, myY, mySpeed, myAngle;
  int myColor, mySize;
  
  Particle() {
    myGravity = 0.05;
    myX = width/2;
    myY = height/2;
    mySpeed = ( Math.random() * 4 ) + 1;
    myAngle  = ( Math.random() * 2 * Math.PI); // 0 to 2pi
    myColor = color( (int)(Math.random()*256), (int)(Math.random()*256), (int)(Math.random()*256));
    mySize = 10;
  }
  Particle(double x, double y) {
    myGravity = 0.05;
    myX = x;
    myY = y;
    mySpeed = ( Math.random() * 4 ) + 1;
    myAngle  = ( Math.random() * 2 * Math.PI); // 0 to 2pi
    myColor = color( (int)(Math.random()*256), (int)(Math.random()*256), (int)(Math.random()*256));
    mySize = 10;
  }
  Particle(double x, double y, double speed, double angle, int colour, int sz) {
    myGravity = 0.05;
    myX = x;
    myY = y;
    mySpeed = speed;
    myAngle = angle;
    myColor = colour; // "color" is a reserved keyword, but "colour" isn't
    mySize = sz; // "sz" instead of "size"
  }
  
  void move() {
    myX += mySpeed * Math.cos(myAngle);
    myY += mySpeed * Math.sin(myAngle);
  }
  void fall() {
    // math below makes gravity work
    // speed is Pythagorean theorem to get new speed based on vertical gravity
    // angle is arctan to get new angle based on vertical gravity
    boolean addPi = ( (myAngle > (Math.PI/2)) && (myAngle < (3*Math.PI/2)) ); // if the angle in is Quardrants II or III (i.e. facing left)
    mySpeed = Math.sqrt( (mySpeed*Math.cos(myAngle)* mySpeed*Math.cos(myAngle)) + 
                          ((mySpeed*Math.sin(myAngle)+myGravity)*(mySpeed*Math.sin(myAngle)+myGravity)) ); 
    myAngle = Math.atan( (mySpeed*Math.sin(myAngle)+myGravity) / (mySpeed*Math.cos(myAngle)));
    if (addPi) myAngle += Math.PI; // this is necessary because arctan normally forces everything to be in Quadrants I and IV (i.e. facing right)
  }
  void show() {
    fill(myColor);
    ellipse((float)myX, (float)myY, mySize, mySize);
  }
}

class ShootingStar extends Particle //inherits from Particle
{
  ShootingStar() {
    myGravity = 0;
    myX = (Math.random() * 1000); // height
    myY = (Math.random() * 750); //width
    mySpeed = 10;
    myAngle = (int)(Math.random() * 2 * Math.PI);
    myColor = color(255, 255, 0);
    mySize = 30;
  }
  ShootingStar(double x, double y) {
    myGravity = 0;
    myX = x;
    myY = y;
    mySpeed = 10;
    myAngle = (int)(Math.random() * 2 * Math.PI);
    myColor = color(255, 255, 0);
    mySize = 30;
  }
  
  void fall() { // overwrite inherited fall method  
    // change directions
    if (myX < -400) myAngle = ( Math.random() * Math.PI - (Math.PI / 2) );
    if (myX > width + 400) myAngle = ( Math.random() * Math.PI + (Math.PI / 2) );
    
    if (myY < -400) myAngle = ( Math.random() * Math.PI );
    if (myY > height) {
      myY = -100;
      myAngle = ( Math.random() * Math.PI );
    }
  }
  
  void show() { // overwrite inherited show method
    fill(myColor);
    // shows a star made of two triangles
    triangle( (float)myX - mySize/1.5, (float)myY - mySize/1.5+10, (float)myX + mySize/1.5, (float)myY - mySize/1.5+10, (float)myX, (float)myY + mySize/1.5+10);
    triangle( (float)myX - mySize/1.5, (float)myY + mySize/1.5-5, (float)myX + mySize/1.5, (float)myY + mySize/1.5-5, (float)myX, (float)myY - mySize/1.5-5);
  }
}
