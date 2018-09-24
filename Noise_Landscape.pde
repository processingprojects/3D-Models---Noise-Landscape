float r=4;
int side=70;/*prev:50*/
int ratio=4;
PVector[] node;
PVector[] lines;
void setup() {
  size(600, 600);
  float xoff=0.0, yoff=10000.0;
  background(150, 150, 150);
  noStroke();
  fill(69, 128, 100);
  node=new PVector[side*side+6];
  int k=0;
  lines=new PVector[3];
  node[side*side+0]=new PVector(0, 200, 0);
  node[side*side+1]=new PVector(0, -200, 0);
  node[side*side+2]=new PVector(200, 0, 0);
  node[side*side+3]=new PVector(-200, 0, 0);
  node[side*side+4]=new PVector(0, 0, 200);
  node[side*side+5]=new PVector(0, 0, -200);
  lines[0]=new PVector(0, 1);
  lines[1]=new PVector(2, 3);
  lines[2]=new PVector(4, 5);
  for (int i=-floor(side/2); i<floor(side/2); i++) {
    yoff=10000.0;
    for (int j=-floor(side/2); j<floor(side/2); j++) {
      node[k]=new PVector(ratio*i, ratio*j, map(noise(xoff, yoff), 0, 1, -200, 200));
      k++;
      yoff+=0.01;
    }
    xoff+=0.01;
  }
  //rotateX3D(90);
}
void drawStuff() {
  pushMatrix();
  translate(width/2, height/2);
  background(150, 150, 150);
  //fill(40, 168, 107);
  noStroke();//node
  for (int i=0; i<side*side; i++) {
    float abc=node[i].z;
    //choose color mode. 1:blue & orange 2:blue & purple & yellow
    fill(map(abc, -200, 200, 0, 255), map(abc, -200, 200, 160, 90), map(abc, -200, 200, 255, 0));
    //fill(map(abc,-200,200,0,255),map(min(abc,abs(abc-255)),0,128,0,255),map(abc,-200,200,255,0));
    ellipse(node[i].x, node[i].y, r, r);
  };
  popMatrix();/*Draw Axis*/
  stroke(0, 0, 0, 50);
  fill(0, 0, 0, 50);
  pushMatrix();
  translate(width/2, height/2);
  for (int i=0; i<3; i++) {
    line(node[side*side+int(lines[i].x)].x, node[side*side+int(lines[i].x)].y, node[side*side+int(lines[i].y)].x, node[side*side+int(lines[i].y)].y);
  }
  textSize(10);
  text("x", node[side*side+1].x, node[side*side+1].y, node[side*side+1].z);
  text("y", node[side*side+3].x, node[side*side+3].y, node[side*side+3].z);
  text("z", node[side*side+5].x, node[side*side+5].y, node[side*side+5].z);
  popMatrix();
}
void rotateZ3D(float theta) {
  float s=sin(radians(theta));
  float c=cos(radians(theta));
  for (int i=0; i<side*side+6; i++) {
    float x=node[i].x;
    float y=node[i].y;
    node[i].x=x*c-y*s;
    node[i].y=y*c+x*s;
  }
}
void rotateY3D(float theta) {
  float s=sin(radians(theta));
  float c=cos(radians(theta));
  for (int i=0; i<side*side+6; i++) {
    float x=node[i].x;
    float z=node[i].z;
    node[i].x=x*c-z*s;
    node[i].z=z*c+x*s;
  }
}
void rotateX3D(float theta) {
  float s=sin(radians(theta));
  float c=cos(radians(theta));
  for (int i=0; i<side*side+6; i++) {
    float z=node[i].z;
    float y=node[i].y;
    node[i].z=z*c-y*s;
    node[i].y=y*c+z*s;
  }
}
void mouseDragged() {
  rotateY3D(mouseX-pmouseX);
  rotateX3D(-(mouseY-pmouseY));
}
void draw() {
  drawStuff();
}/**/
void keyTyped() {
  if (str(key).equals(" ")) {
    saveFrame("frame.png");
  }
}
