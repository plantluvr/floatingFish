PImage portal;
float portal_x, portal_y;
float portal_x_velocity;

PImage fish, real_fish, robot_fish;
float fish_x, fish_y;
float fish_x_velocity;
boolean fish_visible;
float robot_fish_chance = 0.25;

PImage portal_exit;
float portal_exit_x, portal_exit_y;

PImage moon;
Plant[] plants;

class Plant {
  PImage art;
  PImage art_main;
  PImage art_alt;
  float alt_chance = 0.5;
  float x = 0;
  float x_velocity = 0; // pixels per second
  float delay_for = 0; 
  float angle = 0;

  Plant(String name) {
    art = art_main = loadImage(name);
    art_alt = null;
    alt_chance = 0.00;
  }

  Plant(String name, String alt_name) {
    art = art_main = loadImage(name);
    art_alt = loadImage(alt_name);
  }

  void draw() {
    if (delay_for > 0) delay_for -= delta_time;
    else {
      pushMatrix();
      translate(x + art.width / 2, height);
      rotate(radians(angle));
      image(art, -art.width / 2, -art.height);
      popMatrix();

      x += x_velocity * delta_time;

      if (x > width || x < -art.width)
        reset();
    }
  }

  void reset() {
    
    if (random(1) < alt_chance) art = art_alt; 
    else art = art_main;
    
    
    if (random(1) < 0.03) {
      x = -art.width;
      x_velocity = (500 + random(100, 300));
    } else {
      x = width;
      x_velocity = -random(100, 300);
    }
    delay_for = random(0.5, 5);
    
  }
}

long start_time_ns, time_ns;
float time;
float delta_time;

void setup() {
  //size(1680, 1050, P3D);
  size(1280, 1024, P3D);

  portal = loadImage("portal_a.png");
  portal_x = 40;
  portal_y = 400;
  portal_x_velocity = -500;

  real_fish = loadImage("fish.png");
  robot_fish = loadImage("robotfish.png");
  fish = real_fish;
  fish_x = 450;
  fish_y = 400;
  fish_x_velocity = 0;

  portal_exit = loadImage("portal_b.png");
  portal_exit_x = portal_x + portal.width + fish.width;
  portal_exit_y = 400;

  moon = loadImage("moon.png");

  plants = new Plant[] {
    new Plant("plant_02.png"), 
    new Plant("floral_01.png"), 
    new Plant("plant_01.png"), 
    new Plant("floral_02.png"), 
    new Plant("plant_03.png"), 
    new Plant("floral_03.png"), 
    new Plant("plant_04.png", "plantmp_04.png"),
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
  time = (time_ns - start_time_ns) / 1e9;

  color building = #DF694B;
  background(building);

  image(portal, (int)portal_x, portal_y);
  image(portal_exit, (int)portal_exit_x, portal_exit_y);

  if (fish_visible)
  {
    image(fish, (int)fish_x, fish_y);

    noStroke();
    fill(building);

    if (portal_x < portal_exit_x) 
    {
      rect((int)portal_x + portal.width, 0, portal_exit_x - portal_x - portal_exit.width, height);
    } else
    {
      rect(0, 0, portal_exit_x, height);
      rect(portal_x + portal.width, 0, width - portal_x, height);
    }
  }

  portal_x += portal_x_velocity * delta_time;
  portal_exit_x += portal_x_velocity * delta_time;
  fish_x += fish_x_velocity * delta_time;

  if (fish_x > portal_x + portal.width) {
    fish_visible = false;
    fish_y = portal_exit_y + portal_exit.height / 2 - fish.height / 2;
    
    if (random(1) < robot_fish_chance) {
      fish = robot_fish;
    }
    else {
      fish = real_fish;
    }

  }

  if (fish_x + fish.width >= portal_exit_x)
    fish_visible = true;

  if (portal_exit_x < width - fish.width - portal.width && portal_x < -portal.width * 2)
  {
    portal_x = width + random(50, 550);
    portal_y = fish_y + fish.height / 2 - portal.height / 2;
  }

  if (portal_x < width - fish.width - portal.width && portal_exit_x < -portal_exit.width * 2)
  {
    portal_exit_x = width + random(50, 550);
    portal_exit_y = 50 + (int)random(5) * 100;
  }

  float beats = time * 2;
  tint(255, abs((beats - (int)beats) * 510 - 255));
  image(moon, 50, 50);
  tint(255);

  for (Plant plant : plants) {
    plant.draw();
  }
}

