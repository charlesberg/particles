ArrayList ballCollection;

int n = 99;

void setup() {
  size(window.innerWidth, window.innerHeight); 
  smooth();
  
  ballCollection = new ArrayList();
  
  noLoop();
  
}
      
void draw() {
  background(51,153,255);
  noStroke();
  translate(width/2,height/2);
  
  for(int i=0; i < ballCollection.size(); i++) {
    Ball mb = (Ball) ballCollection.get(i);
    mb.run();
  }
  
  if(ballCollection.size() < n) {
    PVector origin = new PVector(random(-width/4, width/4),random(-height/4, height/4),0);
    Ball myBall = new Ball(origin);
    ballCollection.add(myBall);
  }
}
class Ball {
  PVector loc = new PVector();
  PVector speed = new PVector();
  PVector acc = new PVector();
  
  Ball(PVector _loc) {
    loc = _loc;
  }
  
  void run() {
    display();
    moveBall();
    lineBetween();
    flock();
  }
  
  void flock() {
    seperate(3);
    cohesion(0.0001);
  }
  
  void cohesion(float magnitude) {
    PVector sum = new PVector();
    int count = 0;
  
    for(int i=0; i < ballCollection.size(); i++) {
      Ball other = (Ball) ballCollection.get(i);
      float distance = loc.dist(other.loc);
      
      if(distance > 0 && distance < 50) {
        sum.add(other.loc);
        count++;
      }
    }
  
    if(count > 0) {
      sum.mult(0.5/count);
    }
  
    PVector steer = PVector.sub(sum, loc);
    steer.mult(magnitude);
    acc.add(steer);
  }
          
  void seperate(float magnitude) {
    PVector steer = new PVector();
    int count = 0;
  
    for(int i=0; i < ballCollection.size(); i++) {
      Ball other = (Ball) ballCollection.get(i);
      float distance = loc.dist(other.loc);
      
      if(distance > 0 && distance < 25) {
        PVector diff = PVector.sub(loc, other.loc);
        diff.normalize(diff);
        diff.mult(1.0/distance);
        
        steer.add(diff);
        count++;
      }
    }
  
    if(count > 0) {
      steer.mult(1.0/count);
    }
    
    steer.mult(magnitude);
    acc.add(steer);
  }
          
  void lineBetween() {
    for(int i=0; i<ballCollection.size(); i++) {
      Ball other = (Ball) ballCollection.get(i);
      float distance = loc.dist(other.loc);
      
      if(distance > 0 && distance < 50) {
        float opacity = map(distance, 0, 50, 255, 0);
        stroke(255,255,255,opacity);
        strokeWeight(0);
        line(loc.x, loc.y, other.loc.x, other.loc.y);
      }
    }
  }
          
  void display() {
    noStroke();
    ellipse(loc.x,loc.y,6,6);
  }
          
  void moveBall() {
    speed.add(acc);
    speed.limit(3);
    loc.add(speed);
    acc.set(0,0,0);
  }
          
  void bounce() {
    if(loc.x >= width) {
      speed.x = speed.x * -1;
    }
    if(loc.x <= 0) {
      speed.x = speed.x * -1;
    }
    if(loc.y >= height) {
      speed.y = speed.y * -1;
    }
    if(loc.y <= 0) {
      speed.y = speed.y * -1;
    }
  }
        
}

