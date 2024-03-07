include <BOSL2/std.scad>

BADGE_T=4;

PIP_X=12;
PIP_Y=19;
PIP_Z=3;
PIP_RECESS=1.5;

PIP_DX=3;
PIP_DY=6;

PIP_COLS = 3;
PIP_ROWS = 2;

LAN_W = 14;
LAN_H = 3;
LAN_T = 2.5;

ID_CLIP_L=10;
ID_CLIP_W=10;
//ID_CLIP_T=2;

SIDE_ON_BED=BOTTOM;
SIDE_IN_AIR = (SIDE_ON_BED==BOTTOM)? TOP : BOTTOM;

module pips() {
  for (i = [0:PIP_COLS-1]) for (j = [0:PIP_ROWS-1]) {
      down(PIP_RECESS) right(PIP_DX + (PIP_X+PIP_DX)*i) fwd(PIP_DY + (PIP_Y+PIP_DY)*j)  color("blue") cuboid([PIP_X,PIP_Y,PIP_Z], rounding=1, edges=[FRONT+LEFT, BACK+LEFT, BACK+RIGHT, FRONT+RIGHT], anchor=BOTTOM+BACK+LEFT, $fn=128);
  }
}

module badge() {
  diff() {
    color("gray") cuboid([PIP_COLS*(PIP_X+PIP_DX)+PIP_DX, PIP_ROWS*(PIP_Y+PIP_DY)+PIP_DY, BADGE_T], rounding=2, edges=[FRONT+LEFT, BACK+LEFT, BACK+RIGHT, FRONT+RIGHT], anchor=TOP+BACK+LEFT) {
      tag("remove") position(TOP+BACK+LEFT)  pips();
      
      // Lanyard clip
      position(BACK+SIDE_ON_BED) cuboid([LAN_W+LAN_T, LAN_H+LAN_T, LAN_T], anchor=FRONT+SIDE_ON_BED)
        tag("remove") cuboid([LAN_W, LAN_H, LAN_T]);
      
      // ID tag clip
      position(FRONT+SIDE_IN_AIR) cuboid([ID_CLIP_W, ID_CLIP_L, BADGE_T/3], anchor=BACK+SIDE_IN_AIR)
        position(SIDE_ON_BED+FRONT) cuboid([ID_CLIP_W, BADGE_T/2, 2*BADGE_T/3], anchor=SIDE_IN_AIR+FRONT)
          position(BACK+SIDE_ON_BED) prismoid([ID_CLIP_W, ID_CLIP_L/4], [ID_CLIP_W, BADGE_T/3], BADGE_T/3, anchor=FRONT+SIDE_ON_BED, shift=[0,(BADGE_T/3 - ID_CLIP_L/4)/2]);
      //cuboid([ID_CLIP_W, ID_CLIP_L/4, BADGE_T/3]);
          //position(BACK+SIDE_ON_BED) cuboid([ID_CLIP_W, ID_CLIP_L/4, BADGE_T/3], anchor=FRONT+SIDE_ON_BED);
      position(FRONT+SIDE_ON_BED) prismoid([ID_CLIP_W, BADGE_T/3], [ID_CLIP_W, ID_CLIP_L/4], BADGE_T/3, anchor=BACK+SIDE_ON_BED, shift=[0,(BADGE_T/3 - ID_CLIP_L/4)/2]);
    }
  }
}

badge();
pips();
