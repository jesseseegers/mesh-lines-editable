import processing.dxf.*;
import processing.opengl.*;
import processing.pdf.*;
PGraphicsPDF pdf;

PFont fontA;

void setup () {
  size(800,600,OPENGL);
  //hint(ENABLE_NATIVE_FONTS);   //enable font to be vector
  //fontA = loadFont("AkzidenzGroteskBE-Bold-24.vlw");   //specify fontA
  //textFont(fontA, 20);   // Set the font and its size (in units of pixels)
}

//define variables initally
float l=8; //l is the length of the line, or short width diamond "SWD"
float d=2; //d is the distance between the lines, which, added to the SWD, equals the long width diamond "LWD"
float v=3; //v is the vertical distance, or strand width, "SW," thickness of the mesh
boolean offset = false;
boolean r = false;


void draw () {
  background (255);
  translate (-(.5),0);   // moves entire screen over so pattern starts at half of L

  //record to DXF
  if (r== true) {
    beginRaw(DXF, "output_l"+int(l)+"_d"+int(d)+"_v"+int(v)+".dxf"); // Start recording to the file "output_lxx_dxx_v_.dxf"
  }

  //DRAW LINES
  offset = false;
  for (int j=-1; j<height/v; j++) { //j is the y-values from 0 to the maximum y pixel value
    if (offset == true ) {    
      for (int i=0; i<=width/(l+d); i++) {  //i is the x-values from 0 to the max x pixel value
        strokeWeight(2);
        stroke(random(0,255),random(0,255),random(0,255));
        line(i*(l+d)+(l+d)/2,v*j,i*(l+d)+l+(l+d)/2,v*j);
      }
      offset = false;
    }
    else {
      for (int i=0; i<=width/(l+d); i++) {
        strokeWeight(2);
        stroke(random(0,255),random(0,255),random(0,255));
        line(i*(l+d),v*j,i*(l+d)+l,v*j);
      }
      offset = true;
    }
  }
    //display text labeling every dxf file
    //fill(0);
    


  if (r == true) {
    endRaw();
    r = false; // Stop recording to the file
  }
}

//CHANGING L,D, AND V VARIABLES WITH KEYSTROKES
void keyPressed() {
  if (keyCode == 82) {
    r=true;
  }
  else if (keyCode == UP) {  //up arrow increases vertical distance, "strand width"
    v+=2;
  }
  else if ((keyCode == DOWN)&&(v>3)) { //down arrow decrease strand width
    v-=2;
  }
  else if (keyCode == LEFT) { //left arrow increases l length, "short width diamond"
    l-=10;
  }
  else if (keyCode == RIGHT) { //right arrow decreases l length, "short width diamond"
    l+=10;
  }
  else if (keyCode == 68) { //d key increases distance between l cuts, "long width diamond"
    d+=2;
  }
  else if (keyCode == 83) { //s key decreases distance between l cuts, "long width diamond"
    d-=2;
  }
  else { 
    println ("keycoooooode izzzz: "+keyCode);
  }
  if(d<l*.875) {
    //r=true;
  
  }
      //text("L"+(int (l))+"-D"+(int (d))+"-V"+(int (v)), l, height);
}
