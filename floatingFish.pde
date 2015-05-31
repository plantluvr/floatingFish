PImage moon;
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
    if (random(1) < 0.03) {
      x = width;
      x_velocity = -(500 + random(100, 300));
    } else {
      x = -art.width;
      x_velocity = random(100, 300);
    }
    delay_for = random(0.5, 5);
  }
}

long start_time_ns, time_ns;
float time;
float delta_time;

void setup() {
  size(1680, 1050, P3D);

  moon = loadImage("moon.png");

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
  {
    plant.reset();
    plant.x = random(-plant.art.width, width);
    plant.delay_for = 0;
  }

  start_time_ns = time_ns = System.nanoTime();
}

void draw() {
  // timing code
  long current_time_ns = System.nanoTime();
  delta_time = (current_time_ns - time_ns) / 1e9;
  time_ns = current_time_ns;
  time = time_ns / 1e9;

  background(#DF694B);
  
  float beats = time * 2;
  tint(255, abs((beats - (int)beats) * 510 - 255));
  image(moon, 50, 50);
  tint(255);

  for (Plant plant : plants) {
    plant.draw();
  }
}

