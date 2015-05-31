PImage window;
PImage plant1;
PImage plant2;
PImage plant3;

void setup() {
  size(1680, 1050);
  
  plant1 = loadImage("plant_01.png");
  plant2 = loadImage("plant_02.png");
  plant3 = loadImage("plant_03.png");
  //window = l
  
  frameRate(60);
}

int scrollX = 0;

void draw() {
  background(#DF694B);
  
  image(plant1, scrollX, height - plant1.height);
    image(plant2, scrollX, height - plant1.height);
      image(plant3, scrollX, height - plant1.height);
  
  scrollX += 10;
  
  if (scrollX > width)
  scrollX = 0;
}
