PImage window;
PImage plant1;
PImage plant2;
PImage plant3;

long last_time;
float delta_time;

void setup() {
  size(1680, 1050, P2D);
  
  last_time = System.nanoTime();
  
  plant1 = loadImage("plant_01.png");
  plant2 = loadImage("plant_02.png");
  plant3 = loadImage("plant_03.png");
  //window = l
  
  frameRate(60);
}

int scrollX = 0;

void draw() {
  // timing code
  long time = System.nanoTime();
  long delta_time_ns = time - last_time;
  last_time = time;
  delta_time = delta_time_ns / 1e9;

  background(#DF694B);
  
  image(plant1, scrollX, height - plant1.height);
    image(plant2, scrollX, height - plant1.height);
      image(plant3, scrollX, height - plant1.height);
  
  scrollX += 10;
  
  if (scrollX > width)
  scrollX = 0;
}
