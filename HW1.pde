import java.util.Random;

PImage img;
PImage bg;

int leafCount = 0;
boolean even = true;

//straight falling leaves
Leaf leaf;
Leaf leaf2;

//Zig Zag leaf
Leaf leaf3;

//Windy Leaves
Leaf leaf4;
Leaf leaf5;


public class Leaf{
  //Leaf starting position
  int y;
  int x;
  boolean clicked;
  
  public Leaf(int x, int y){
    this.x = x;
    this.y = y;
    clicked = false;
  }
}

void setup() {
  frameRate(4);
  size(1076, 636, P3D);
  img = loadImage("dry_leaf08_diff.png");
  bg = loadImage("Fall_background.PNG");
  createLeaves();
}

void createLeaves(){
  leaf = new Leaf(0, 0);
  leaf2 = new Leaf(100, 0);
  leaf3 = new Leaf(300, 0);
  leaf4 = new Leaf(500, 0);
}

void draw() {
  if(leafCount == 50){
     //Game ends. Show end screen 
  }
  
  background(bg);
  drawLeaf(leaf.x, leaf.y*10, leaf);
  /*
  //Level 1: Straight falling leaves
  if(leafCount < 10){
    genericStraightFall(leaf);
    genericStraightFall(leaf2);
    zigZagFall(leaf3);
    windyLeaf(leaf4);
  }
  //Level 2: Straight falling and zig zag
  else if(leafCount >= 10 && leafCount < 20){
    
  }
  //Level 3: Zig Zag and acorn
  else if(leafCount >= 20 && leafCount < 30){
    
  }
  //Level 4: Zig Zag and Windy, and acorns
  else if(leafCount >= 30 && leafCount < 40){
    
  }
  //Level 5: Windy and acorns
  else if(leafCount >= 40){
    
  }
  */
}

void genericStraightFall(Leaf leaf){
  
  //Leaf falls straight down
  if(leaf.y < 60){
    drawLeaf(leaf.x, leaf.y*10, leaf);
  }else{
    leaf.y = 0;
  }
  leaf.y++;
  
}

void zigZagFall(Leaf leaf){
  
  Random rand = new Random(); 
   
  int zig = rand.nextInt(100); 
  
  //Still falling down
  if(leaf.y < 60){
    //starting place
    if(leaf.y == 0){
      drawLeaf(leaf.x, leaf.y, leaf);
    }
    //zig
    else if(even){
      //Go to the left
      drawLeaf(leaf.x - zig, leaf.y*5, leaf);
     
    }
    //zag
    else{
      //Go to the right
      drawLeaf(leaf.x + zig, leaf.y*5, leaf);
      
    }
  }
  //Goes to the top on next iteration
  else{
    leaf.y = 0;
  }
    
  leaf.y++;
}

void windyLeaf(Leaf leaf){
   //leaves will actually blow up 
  Random rand = new Random(); 
  
  // Generate random integer in range 0 to 49 
  int rand_int1 = rand.nextInt(100); 
  int rand_int2 = 1 + rand.nextInt(10);
  
  //Still falling down
  if(leaf.y < 60){
    //starting place
    if(leaf.y == 0){
      drawLeaf(leaf.x, leaf.y, leaf);
    }
    //zig
    else if(even){
      //Go to the left
      drawLeaf(leaf.x - rand_int1, leaf.y*rand_int2, leaf);
      even = false;
    }
    //zag
    else{
      //Go to the right
      drawLeaf(leaf.x - rand_int1, leaf.y*rand_int2, leaf);
      even = true;
      
    }
  }
  //Goes to the top on next iteration
  else{
    leaf.y = 0;
  }
    
  leaf.y++;
   
}

void drawLeaf(int x, int y, Leaf leaf){
  //Hasn't been clicked before
  if(!leaf.clicked){
    //currently being clicked?
    boolean xRange = (mouseX >= x) && (mouseX <= (x + (img.width / 8)));
    boolean yRange = (mouseY >= x) && (mouseY <= (x + (img.height / 8)));
    if(mousePressed == true && xRange && yRange){
      System.out.println("Clicked");
      leafCount++;
      System.out.println("Leaf Count " + leafCount);
  
    }else{
      pushMatrix();
      translate(x, y);
      image(img, 0, 0, img.width / 8, img.height / 8);
      popMatrix();
    }
  }
  
}
