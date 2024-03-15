include <BOSL2/std.scad>

EXPORT="all";
TEXT=["SWCCDC", "2024"];

BADGE_T=4;

PIP_X=12;
PIP_Y=19;
PIP_Z=3;
PIP_RECESS=0;

PIP_DX=3;
PIP_DY=6;

PIP_COLS = 2;
PIP_ROWS = 1;

LAN_W = 14;
LAN_H = 3;
LAN_T = 2.5;

ID_CLIP_L=12;
ID_CLIP_W=10;
//ID_CLIP_T=2;

TXT_Z=0.5;
TXT_SIZE=4.75;

SIDE_ON_BED=BOTTOM;
SIDE_IN_AIR = (SIDE_ON_BED==BOTTOM)? TOP : BOTTOM;

PIP_COLORS=["blue",];

REBEL=false;

module pips() {
  for (i = [0:PIP_COLS-1]) for (j = [0:PIP_ROWS-1]) {
      
      // Select color:
      index = j*PIP_COLS + i;
      lengt = len(PIP_COLORS);
      c = index >= lengt ? PIP_COLORS[lengt-1] : PIP_COLORS[index];
      
      
      // Draw:
      down(PIP_RECESS) right(PIP_DX + (PIP_X+PIP_DX)*i) fwd(PIP_DY + (PIP_Y+PIP_DY)*j)  recolor(c) cuboid([PIP_X,PIP_Y,PIP_Z+PIP_RECESS], rounding=1, edges=[FRONT+LEFT, BACK+LEFT, BACK+RIGHT, FRONT+RIGHT], anchor=BOTTOM+BACK+LEFT, $fn=128);
  }
}

module rebel_logo() {
  wid = PIP_COLS*(PIP_X+PIP_DX)+PIP_DX;
  lng = PIP_ROWS*(PIP_Y+PIP_DY)+PIP_DY;
  logo_fill = 0.9;
  logo_dim = min(wid, lng) * logo_fill;
  
  color("red") translate([wid/2, -lng/2, -PIP_RECESS]) linear_extrude(PIP_RECESS+PIP_Z) scale([0.0125*logo_dim, 0.0125*logo_dim]) import("rebel.svg", center=true);
}

module badge_top() {
  if (REBEL) {
    rebel_logo();
  } else {
    pips();
  }
}

module txt() {
  LINE_SPACE=TXT_SIZE+1.25;
  for (t = [0 : len(TEXT)-1]) {
    back(LINE_SPACE*(len(TEXT)-1)/2) fwd(t*LINE_SPACE) text3d(TEXT[t], font="Arial Black:style=Regular", size=TXT_SIZE, h=TXT_Z, atype="ycenter", anchor=CENTER+TOP);
  }
}

module badge() {
  k = EXPORT=="badge"? "" : "txt";
  r = EXPORT=="text"? "remove badge" : "txt remove";
  diff(r, k) {
    recolor("gray") tag("badge") cuboid([PIP_COLS*(PIP_X+PIP_DX)+PIP_DX, PIP_ROWS*(PIP_Y+PIP_DY)+PIP_DY, BADGE_T], rounding=2, edges=[FRONT+LEFT, BACK+LEFT, BACK+RIGHT, FRONT+RIGHT], anchor=TOP+BACK+LEFT) {
      force_tag("remove") position(TOP+BACK+LEFT) badge_top();
      
      // Lanyard clip
      position(BACK+SIDE_ON_BED) cuboid([LAN_W+LAN_T, LAN_H+LAN_T, LAN_T], anchor=FRONT+SIDE_ON_BED)
        tag("remove") cuboid([LAN_W, LAN_H, LAN_T]);
      
      // ID tag clip
      position(FRONT+SIDE_IN_AIR) cuboid([ID_CLIP_W, ID_CLIP_L, BADGE_T/3], anchor=BACK+SIDE_IN_AIR)
        position(SIDE_ON_BED+FRONT) cuboid([ID_CLIP_W, BADGE_T/2, 2*BADGE_T/3], anchor=SIDE_IN_AIR+FRONT)
          position(BACK+SIDE_ON_BED) prismoid([ID_CLIP_W, ID_CLIP_L/4], [ID_CLIP_W, BADGE_T/3], BADGE_T/3, anchor=FRONT+SIDE_ON_BED, shift=[0,(BADGE_T/3 - ID_CLIP_L/4)/2]);
      position(FRONT+SIDE_ON_BED) prismoid([ID_CLIP_W, BADGE_T/3], [ID_CLIP_W, ID_CLIP_L/4], BADGE_T/3, anchor=BACK+SIDE_ON_BED, shift=[0,(BADGE_T/3 - ID_CLIP_L/4)/2]);
      
      // Text?
      tag("txt") recolor("black") position(BOTTOM+CENTER) orient(DOWN) txt();
    }
  }
}

if (EXPORT == "all" || EXPORT == "badge" || EXPORT == "text")
  badge();
if (EXPORT == "all" || EXPORT == "pips")
  badge_top();
