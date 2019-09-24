import java.util.Random;
PFont f;

PImage img;
PImage bg;
PImage end;
PImage acornIm;

int leafCount = 0;
boolean even = true;
double timeSinceAnimation = 0;
double startTime = 0;

//straight falling leaves
Leaf leaf1;
Leaf leaf2;
Leaf leaf3;
Leaf leaf4;
Leaf randLeaf;

//Zig Zag leaf
Leaf leaf5;
Leaf leaf6;
Leaf leaf7;

//Acorns
Leaf acorn;
Leaf acorn2;
Leaf acorn3;

public class Leaf{
  //Leaf starting position
  float y;
  float x;
  boolean clicked;
  String name;
  int speed;
  boolean zig;
  boolean isAcorn;
  
  public Leaf(float x, float y, String name){
    this.x = x;
    this.y = y;
    this.name = name;
    this.clicked = false;
    this.speed = 0;
  }
}

void setup() {
  size(1076, 636, P3D);
  img = loadImage("dry_leaf08_diff.png");
  bg = loadImage("Fall_background.PNG");
  acornIm = loadImage("acorn.png");
  end = loadImage("success.png");
  createLeaves();
  startTime = millis();
  f = createFont("Arial",16,true);
  textFont(f,30);
  
}

//Initialize leaves with their names and starting locations
void createLeaves(){
  //Straight leaves
  leaf1 = new Leaf(0, 0, "leaf1");
  leaf1.speed = 2;
  leaf1.isAcorn = false;
  leaf2 = new Leaf(100, 0, "leaf2");
  leaf2.speed = 4;
  leaf2.isAcorn = false;
  
  leaf3 = new Leaf(300, 0, "leaf3");
  leaf3.speed = 3;
  leaf3.isAcorn = false;
  leaf4 = new Leaf(500, 0, "leaf4");
  leaf4.speed = 4;
  leaf4.isAcorn = false;
  
  Random rand = new Random(); 
  int randStart = rand.nextInt(1000) + 1;
  randLeaf = new Leaf(randStart, 0, "randLeaf");
  randLeaf.speed = 2;
  randLeaf.isAcorn = false;
  
  //Zig Zag leaves
  leaf5 = new Leaf(250, 0, "zigzag1");
  leaf5.isAcorn = false;
  leaf5.speed = 8;
  leaf6 = new Leaf(120, 0, "zigzag2");
  leaf6.isAcorn = false;
  leaf6.speed = 9;
  leaf7 = new Leaf(460, 0, "zigzag3");
  leaf7.isAcorn = false;
  leaf7.speed = 8;
  
  
  //Acorns
  acorn = new Leaf(150, 0, "acorn");
  acorn.speed = 5;
  acorn.isAcorn = true;
  acorn2 = new Leaf(150, 0, "acorn2");
  acorn2.speed = 6;
  acorn2.isAcorn = true;
  acorn3 = new Leaf(300, 0, "acorn3");
  acorn3.speed = 7;
  acorn3.isAcorn = true;
}

void draw() {
  background(bg);
  
  if(leafCount == 50){
     //Game ends. Show end screen  
     endScreen();
     
     
  }
  
  
  
  
  //Level 1: Straight falling leaves
  if(leafCount < 10){
    
    genericStraightFall(randLeaf, true, true, img);   
    genericStraightFall(leaf1, true, false, img);
    genericStraightFall(leaf2, true, false, img);
    genericStraightFall(leaf3, true, true, img);
    genericStraightFall(leaf4, false, false, img);
    
  }
  //Level 2: Straight falling, one zig zag, one acorn
  else if(leafCount >= 10 && leafCount < 20){
      
    genericStraightFall(randLeaf, true, true, img);
    leaf2.speed = 6;
    genericStraightFall(leaf2, true, false, img);
    leaf3.speed = 5;
    genericStraightFall(leaf3, true, false, img);
    zigZagFall(leaf5, false, img, 2);
    genericStraightFall(acorn, true, false, acornIm);
    
    
  }
  //Level 3: Straight, Zig Zag and acorns
  else if(leafCount >= 20 && leafCount < 30){
    genericStraightFall(acorn, true, false, acornIm);
    genericStraightFall(acorn2, true, true, acornIm);
    genericStraightFall(randLeaf, true, true, img);
    leaf2.speed = 7;
    genericStraightFall(leaf2, true, false, img);
    leaf3.speed = 6;
    genericStraightFall(leaf3, true, false, img);
    zigZagFall(leaf5, true, img, 3);
    zigZagFall(leaf6, false, img, 4);
    
  }
  //Level 4: Mostly zig zag and acorns
  else if(leafCount >= 30 && leafCount < 40){
    zigZagFall(leaf5, true, img, 5);
    zigZagFall(leaf6, false, img, 6);
    zigZagFall(leaf7, true, img, 6);
    leaf3.speed = 7;
    genericStraightFall(leaf3, true, false, img);
    genericStraightFall(acorn, true, true, acornIm);
    genericStraightFall(acorn2, true, true, acornIm);
    
    
  }
  //Level 5: Zig zagging leaves and acorns
  else if(leafCount >= 40){
    zigZagFall(leaf5, true, img, 6);
    zigZagFall(leaf6, true,  img, 6);
    zigZagFall(acorn, true, acornIm, 6);
    zigZagFall(acorn2, true, acornIm, 6);
    genericStraightFall(acorn3, true, true, acornIm);
    
    
    
  }
  
  text("Leaf Count " + leafCount, 860, 575);
}

void genericStraightFall(Leaf leaf,  boolean randomStart, boolean randomSpeed, PImage im){
  
  //Leaf falls straight down
  if(leaf.y < 500){
    
    drawLeaf(leaf.x, leaf.y+leaf.speed, leaf, im);
    
  }
  //Leaf fell to the ground
  else{
  
    if(randomStart){
      Random rand = new Random(); 
      int randStart = rand.nextInt(1000) + 1;
      leaf.x = randStart;
    
    }
    if(randomSpeed){
      Random rand = new Random(); 
      int randSpeed = rand.nextInt(6) + 1;
      leaf.speed = randSpeed;
      
    }
    leaf.y = 0;
    leaf.clicked = false;
  }
  
}

void zigZagFall(Leaf leaf, boolean randomStart, PImage im, float speed){
  
  Random rand = new Random(); 
   
  int zig = rand.nextInt(35); 
  
  //Still falling down
  if(leaf.y < 500){
    if(leaf.zig){
      //Go to the left
      drawLeaf(leaf.x - zig, leaf.y+speed, leaf, im);
      leaf.zig = false;
     
    }
    //zag
    else{
      //Go to the right
      drawLeaf(leaf.x + zig, leaf.y+speed, leaf, im);
      leaf.zig = true;
    }
  }
  //Goes to the top on next iteration
  else{
    
    if(randomStart){
      int randStart = rand.nextInt(1000) + 1;
      leaf.x = randStart;
    }
    
    leaf.y = 0;
    leaf.clicked = false;
  }
    
}


//x and y here are the new locations of the leaf
//leaf.x and leaf.y are the current positions
void drawLeaf(float x, float y, Leaf leaf, PImage im){
  
  //Hasn't been clicked before
  if(!leaf.clicked){
    //currently being clicked?
    boolean xRange = (mouseX >= leaf.x) && (mouseX <= (leaf.x + (im.width / 8)));
    boolean yRange = (mouseY >= leaf.y) && (mouseY <= (leaf.y + (im.height / 8)));
    
    if(mousePressed == true && xRange && yRange){
      if(leaf.isAcorn){
        if(leafCount > 0){
          leafCount = leafCount - 3;
        }
        leaf.clicked = true;
        
      }else{     
        leafCount++;
        leaf.clicked = true;
        
      }
  
    }else{
      pushMatrix();
      translate(x, y);
      image(im, 0, 0, im.width / 8, im.height / 8);
      popMatrix();
    }
  }
  leaf.x = x;
  leaf.y = y;
  
}

void endScreen(){
  image(end, 0, 0, end.width, end.height);
  noLoop();
}
