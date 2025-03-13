include <BOSL2/std.scad>

// TODO: Draw the pokeball design
// TODO: Set up the letter in the pokeball
// TODO: Set up the parameterization

EXPORT="all";
TEXT=["SWCCDC", "2025"];
BADGE_COLOR="gray";
OMIT_CLIP=false;

BADGE_T=4;

BADGE_W=45;
BADGE_H=45;

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

BALL_COLOR_TOP="red";
BALL_COLOR_BOTTOM="white";
BALL_COLOR_INSET="black";
BALL_COLOR_BUTTON="white";
BALL_COLOR_TEXT="black";
BALL_TEXT="R";
BALL_TEXT_SIZE=10;

BALL_SEAM_Y=5;
BALL_SEAM_INSET_RATIO=0.9;
BUTTON_RATIO=0.2;
BUTTON_PROMINENCE=0.5;

module pokeball() {
  // Draw the pokeball

  if (EXPORT == "all" || EXPORT == "top") {
    // Top of the ball
    up(EXPORT == "all" ? 0.1 : 0) diff() { 
      color(BALL_COLOR_TOP) sphere(d=BADGE_W, $fn=128) {
        tag("remove") back(BALL_SEAM_Y/2) ycyl(d=BADGE_W*1.5, h=BADGE_W, anchor=BACK, $fn=128);
      }
      tag("remove") cuboid([BADGE_W, BADGE_H, BADGE_W], anchor=TOP);
    }
  }

  if (EXPORT == "all" || EXPORT == "bottom") {
    // Bottom of the ball
    diff() {
      color(BALL_COLOR_BOTTOM) sphere(d=BADGE_W, $fn=128) {
        tag("remove") fwd(BALL_SEAM_Y/2) ycyl(d=BADGE_W*1.5, h=BADGE_W, anchor=FRONT, $fn=128);
      }
      tag("remove") cuboid([BADGE_W, BADGE_H, BADGE_W], anchor=TOP);
    }
  }

  if (EXPORT == "all" || EXPORT == "inset") {
    // The inset seam:
    diff() color(BALL_COLOR_INSET) ycyl(d=BADGE_W*BALL_SEAM_INSET_RATIO, h=BALL_SEAM_Y, $fn=128) {
      tag("remove") cuboid([BADGE_W, BADGE_H, BADGE_W], anchor=TOP);
    }
  }

  if (EXPORT == "all" || EXPORT == "button") {
    // The button:
    color(BALL_COLOR_BUTTON) zcyl(h=BADGE_W/2 + BUTTON_PROMINENCE, d=BADGE_W*BUTTON_RATIO, anchor=BOTTOM, $fn=128);
  }

  if (EXPORT == "all" || EXPORT == "letter") {
    // Draw the text
    diff() {
      color(BALL_COLOR_TEXT) back(BADGE_H/4) text3d(BALL_TEXT, font="Arial Black:style=Regular", size=BALL_TEXT_SIZE, h=BADGE_W/2, atype="ycenter", anchor=CENTER+BOTTOM);
      if (EXPORT != "all") {
        tag("remove")
          sphere(d=BADGE_W, $fn=128);
      }
    }
  }
}

module badge_top() {
  // if (REBEL) {
  //   rebel_logo();
  // } else {
  //   pips();
  // }
  translate([BADGE_W/2, -BADGE_H/2, 0])
    scale([1, 1, 0.25])
      pokeball();
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
    recolor(BADGE_COLOR) tag("badge") cuboid([BADGE_W, BADGE_H, BADGE_T], rounding=2, edges=[FRONT+LEFT, BACK+LEFT, BACK+RIGHT, FRONT+RIGHT], anchor=TOP+BACK+LEFT) {
      force_tag("remove") position(TOP+BACK+LEFT) badge_top();
      
      // Lanyard clip
      position(BACK+SIDE_ON_BED) cuboid([LAN_W+LAN_T, LAN_H+LAN_T, LAN_T], anchor=FRONT+SIDE_ON_BED)
        tag("remove") cuboid([LAN_W, LAN_H, LAN_T]);
      
      if (!OMIT_CLIP) {
        // ID tag clip
        position(FRONT+SIDE_IN_AIR) cuboid([ID_CLIP_W, ID_CLIP_L, BADGE_T/3], anchor=BACK+SIDE_IN_AIR)
          position(SIDE_ON_BED+FRONT) cuboid([ID_CLIP_W, BADGE_T/2, 2*BADGE_T/3], anchor=SIDE_IN_AIR+FRONT)
            position(BACK+SIDE_ON_BED) prismoid([ID_CLIP_W, ID_CLIP_L/4], [ID_CLIP_W, BADGE_T/3], BADGE_T/3, anchor=FRONT+SIDE_ON_BED, shift=[0,(BADGE_T/3 - ID_CLIP_L/4)/2]);
        position(FRONT+SIDE_ON_BED) prismoid([ID_CLIP_W, BADGE_T/3], [ID_CLIP_W, ID_CLIP_L/4], BADGE_T/3, anchor=BACK+SIDE_ON_BED, shift=[0,(BADGE_T/3 - ID_CLIP_L/4)/2]);
      }
      
      // Text?
      tag("txt") recolor("black") position(BOTTOM+CENTER) orient(DOWN) txt();
    }
  }
}

if (EXPORT == "all" || EXPORT == "badge" || EXPORT == "text")
  badge();
if (EXPORT == "all" || EXPORT == "top" || EXPORT == "bottom" || EXPORT == "inset" || EXPORT == "button" || EXPORT == "letter")
  badge_top();
