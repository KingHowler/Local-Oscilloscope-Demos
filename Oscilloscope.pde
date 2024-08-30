GraphPlotter GPD;
GraphPlotter GPA;
GraphPlotter GPJ;

float[] a;
float[] b;
float[] c;
float[] d;
float x;
float y;
int s;

import processing.serial.*;
int index = 0;
Serial myPort;

void setup() {
  size(1900, 900);
  
  CreatePlotters();
  
  myPort = new Serial(this, "COM3", 9600);
  myPort.bufferUntil('\n');
}

void draw() {
  background(255);
  
  GPD.DrawGrid();
  GPA.DrawGrid();
  GPJ.DrawGrid();
  
  GPD.DrawGraph(a, color(255,0,0));
  GPD.DrawGraph(b, color(0,255,0));
  GPA.DrawGraph(c, color(0,0,255));
  GPA.DrawGraph(d, color(255,190,0));
  
  if (s == 1) {
    stroke(0,255,190);
  } else {
  stroke(255,0,255);
  }
  GPJ.DrawSegment(true, GPJ.xCo(x - 512), GPJ.yCo(y - 512), GPJ.xCo(x - 512), GPJ.yCo(y - 512));
  GPJ.DrawSegment(false, GPJ.xCo(0), GPJ.yCo(0), GPJ.xCo(x - 512), GPJ.yCo(y - 512));
}

void CreatePlotters() {
  GPD = new GraphPlotter();
  GPA = new GraphPlotter();
  GPJ = new GraphPlotter();
  
  GPD.GraphSetup(false, true, "Digital", "");
  GPA.GraphSetup(false, true, "Analog", "");
  GPJ.GraphSetup(false, true, "Joystick", "");
  
  GPD.GridSetup(0, 2, 1, 0, 1000, 100);
  GPA.GridSetup(0, 1050, 200, 0, 1000, 100);
  GPJ.GridSetup(-600, 600, 100, -600, 600, 100);
  
  GPD.SizeSetup(width/2,height/2);
  GPA.SizeSetup(width/2,height/2);
  GPJ.SizeSetup(width/2,height);
  
  GPA.Offset(0, height/2);
  GPJ.Offset(width/2, 0);
  
  a = new float[GPD.totalPoints];
  b = new float[GPD.totalPoints];
  c = new float[GPA.totalPoints];
  d = new float[GPA.totalPoints];
}

void serialEvent(Serial port) {
  String inString = port.readStringUntil('\n');  // Read the serial data as a string
  if (inString.indexOf('a') == 0) {
    inString = trim(inString);
    //print(inString.substring(inString.indexOf('a') + 1, inString.indexOf('b')) + "  " + inString.substring(inString.indexOf('b') + 1, inString.indexOf('c')) + "  " + inString.substring(inString.indexOf('c') + 1, inString.indexOf('d')) + "  " + inString.substring(inString.indexOf('d') + 1, inString.indexOf('x')) + "  " + inString.substring(inString.indexOf('x') + 1, inString.indexOf('y'))+ "  " + inString.substring(inString.indexOf('y') + 1) + '\n');
    
    a[index] = float(inString.substring(inString.indexOf('a') + 1, inString.indexOf('b')));
    b[index] = float(inString.substring(inString.indexOf('b') + 1, inString.indexOf('c')));
    c[index] = float(inString.substring(inString.indexOf('c') + 1, inString.indexOf('d')));
    d[index] = float(inString.substring(inString.indexOf('d') + 1, inString.indexOf('s')));
    s = int(inString.substring(inString.indexOf('s') + 1, inString.indexOf('x')));
    x = float(inString.substring(inString.indexOf('x') + 1, inString.indexOf('y')));
    y = float(inString.substring(inString.indexOf('y') + 1));
    
    index = (index + 1) % 1001;
  }
}
