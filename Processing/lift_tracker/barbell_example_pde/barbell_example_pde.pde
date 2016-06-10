import processing.serial.*;
import processing.opengl.*;

int aligned = 0;
int interval = 0;


void setup() {
    // 300px square viewport using OpenGL rendering
    size(600,600,P3D);
    //cam = new PeasyCam(this, 50);
    //cam.setMinimumDistance(50);
    //cam.setMaximumDistance(300);
    
    // setup lights and antialiasing
    lights();
    smooth();
  
}

void draw() {
    
    // set background
    background(0);
    
    // centering of the viewport
    translate(width / 2, height / 2);

    // rotate around the center of the sketch
    //rotateY(radians(frameCount/2));
    rotateY(radians(mouseX));
    
    stroke(255,255,255);
    line(-1000,0,1000,0);
    line(-170,-1000,-170,1000);
    line(170,-1000,170,1000);
    line(-170,0,-1000,-170,0,1000);
    line(170,0,-1000,170,0,1000);
    
    translate(0, -50+frameCount/2%100);
    
    // Show path
    pushMatrix();
    rotate(PI/2);
    translate(0, 170);
    stroke(255,150,0);
    sphere(5);
    translate(0, -340);
    stroke(255,150,0);
    sphere(5);
    noStroke();
    popMatrix();
    
    // Draw barbell
    // Bar
    fill(255, 255, 255, 180);
    translate(150, 0);
    rotate(PI/2);
    drawCylinder(6, 6, 300, 8);
    
    // Left plates
    translate(0, 30);
    fill(255, 0, 0, 180);
    drawCylinder(60, 60, 5, 8);
    translate(0, 5);
    fill(0, 255, 0, 180);
    drawCylinder(60, 60, 5, 8);
    translate(0, 5);
    fill(100, 100, 255, 180);
    drawCylinder(60, 60, 5, 8);
    translate(0, -20);
    
    // Right plates
    translate(0, 240);
    fill(255, 0, 0, 180);
    drawCylinder(60, 60, 5, 8);
    translate(0, -5);
    fill(0, 255, 0, 180);
    drawCylinder(60, 60, 5, 8);
    translate(0, -5);
    fill(100, 100, 255, 180);
    drawCylinder(60, 60, 5, 8);
    translate(0, -260);
    
}



void drawCylinder(float topRadius, float bottomRadius, float tall, int sides) {
    float angle = 0;
    float angleIncrement = TWO_PI / sides;
    beginShape(QUAD_STRIP);
    for (int i = 0; i < sides + 1; ++i) {
        vertex(topRadius*cos(angle), 0, topRadius*sin(angle));
        vertex(bottomRadius*cos(angle), tall, bottomRadius*sin(angle));
        angle += angleIncrement;
    }
    endShape();
    
    // If it is not a cone, draw the circular top cap
    if (topRadius != 0) {
        angle = 0;
        beginShape(TRIANGLE_FAN);
        
        // Center point
        vertex(0, 0, 0);
        for (int i = 0; i < sides + 1; i++) {
            vertex(topRadius * cos(angle), 0, topRadius * sin(angle));
            angle += angleIncrement;
        }
        endShape();
    }
  
    // If it is not a cone, draw the circular bottom cap
    if (bottomRadius != 0) {
        angle = 0;
        beginShape(TRIANGLE_FAN);
    
        // Center point
        vertex(0, tall, 0);
        for (int i = 0; i < sides + 1; i++) {
            vertex(bottomRadius * cos(angle), tall, bottomRadius * sin(angle));
            angle += angleIncrement;
        }
        endShape();
    }
}