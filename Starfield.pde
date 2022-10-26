Particle[] parts = new Particle[250];
void setup()
{
  background(0);
  noStroke();
  size(1000, 750);
  for (int i = 0; i < parts.length; i++) {
    parts[i] = new Particle();
  }
}
void draw()
{
  fill(0, 0, 0, 80); // sky
  rect(0, 0, width, height);
  fill(255, 255, 0);
  ellipse(100, 100, 80, 80);
  fill(0, 0, 0);
  ellipse(120, 110, 60, 60);
  
  for (int i = 0; i < parts.length; i++) {
    parts[i].move();
    parts[i].show();
  }
  
  fill(0, 128, 0);
  rect(0, 700, width, height); // ground
}

void mouseClicked() {
  fill(255);
  ellipse(mouseX, mouseY, 30, 30); // flash at epicenter
  
  for (int i = 0; i < parts.length; i++) {
    parts[i] = new Particle(mouseX, mouseY);
  }
}

class Particle
{
  double myGravity;
  double myX, myY, mySpeed, myAngle;
  int myColor;
  
  Particle() {
    myGravity = 0.05;
    myX = width/2;
    myY = height/2;
    mySpeed = ( Math.random() * 4 ) + 1;
    myAngle  = ( Math.random() * 2 * Math.PI); // 0 to 2pi
    myColor = color( (int)(Math.random()*256), (int)(Math.random()*256), (int)(Math.random()*256));
  }
  Particle(double x, double y) {
    myGravity = 0.05;
    myX = x;
    myY = y;
    mySpeed = ( Math.random() * 4 ) + 1;
    myAngle  = ( Math.random() * 2 * Math.PI); // 0 to 2pi
    myColor = color( (int)(Math.random()*256), (int)(Math.random()*256), (int)(Math.random()*256));
  }
  Particle(double x, double y, double speed, double angle, int colour) {
    myGravity = 0.05;
    myX = x;
    myY = y;
    mySpeed = speed;
    myAngle = angle;
    myColor = colour; // "color" is a reserved keyword, but "colour" isn't
  }
  
  void move() {
    myX += mySpeed * Math.cos(myAngle);
    myY += mySpeed * Math.sin(myAngle);
    
    // some ugly math below to get gravity     
    // speed is Pythagorean theorem to get a change in speed based on vertical gravity
    // angle is arctan to get change in angle based on vertical gravity
    boolean addPi = ( (myAngle > (Math.PI/2)) && (myAngle < (3*Math.PI/2)) ); // if the angle in is Quardrants II or III (i.e. facing left)
    mySpeed = Math.sqrt( (mySpeed*Math.cos(myAngle)* mySpeed*Math.cos(myAngle)) + 
                          ((mySpeed*Math.sin(myAngle)+myGravity)*(mySpeed*Math.sin(myAngle)+myGravity)) ); 
    myAngle = Math.atan( (mySpeed*Math.sin(myAngle)+myGravity) / (mySpeed*Math.cos(myAngle)));
    if (addPi) myAngle += Math.PI; // this is necessary because arctan normally forces everything to be in Quadrants I and IV (i.e. facing right)
  }
  void show() {
    fill(myColor);
    ellipse((float)myX, (float)myY, 10, 10);
  }
}

class ShootingStar extends Particle //inherits from Particle
{
  
}
