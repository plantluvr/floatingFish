Plant[] plants;

class Plant {
  PImage art;
  float x = 0;
  float x_velocity = 0; // pixels per second
  float delay_for = 0; 

  Plant(String name) {
    art = loadImage(name);
  }

  void draw() {
    if (delay_for > 0) delay_for -= delta_time;
    else {
      image(art, x, height - art.height);

      x += x_velocity * delta_time;

      if (x > width || x < -art.width)
        reset();
    }
  }

  void reset() {
    x = -art.width + 1;
    x_velocity = random(100, 300);
    delay_for = random(0.5, 5);
  }
}

long time;
float delta_time;

void setup() {
  size(1680, 1050, P2D);

  plants = new Plant[] {
    new Plant("plant_02.png"), 
    new Plant("floral_01.png"), 
    new Plant("plant_01.png"), 
    new Plant("floral_02.png"), 
    new Plant("plant_03.png"), 
    new Plant("floral_03.png"), 
    new Plant("plant_04.png"),
  };

  for (Plant plant : plants)
    plant.reset();

  time = System.nanoTime();
}

void draw() {
  // timing code
  long current_time = System.nanoTime();
  delta_time = (current_time - time) / 1e9;
  time = current_time;

  background(#DF694B);

  for (Plant plant : plants) {
    plant.draw();
  }
}

