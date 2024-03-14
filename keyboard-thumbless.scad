$fn= $preview ? 32 : 128; // render more accurately than preview
segments = $preview ? 32 : 512;  // render some curves more accurately still
FINAL = true;             // Don't render everything when false!

switchHoleSide = 14.5;    // size of square hole in mm
switchClipSide = 13.8;    // size of square hole in mm
switchClipDepth = 1.3;    // thickness of clips on switches
switchHoleDepth = 2.2;    // depth of switch hole
switchAngleZ = 25;        // Angle to rotate thum switches on Z axis
switchAngle = [0, 0, switchAngleZ];  // angle to rotate thumb switches
thumbDisplacement = -0;   // Amount thumb keys are displaced from bottom of board
keyHeight = 18;           // space devoted to each key
keyWidth = 19;
keyFromTop = 3;           // distance of key from top of block
keyFromBottom = 1;        // distance of key from bottom of block

keyMinDepth = 5;          // minimum depth of key (and of top support)
topThickness = 4;         // thickness of top

screwDiameter = 2.2;      // diameter of screws
screwLength = 6;          // length of screw shaft
pcbThickness = 1.6;       // thickness of PCB
nutThickness = 1.3;       // thickness of nut
screwHeadDiameter = 6.3;  // diameter of screw head
nutDiameter = 5.2;        // diameter of nut, point to point (actually 5.0mm)
standoffDiameter = 3.2;   // diameter of standoff
standoffHeight = 6;       // height of standoff

bumperDia = 12.1;         // Diameter of bumpers + 2.1mm
clipSlotLength = 14;      // length of slot in string clip
clipThickness = 8.0;      // thickness of string clip + 1 mm

keyboardLength = 106;     // length of keyboard to front surface of thumb

stringHoleRadius = 2;     // radius of hole for string
/* stringHoleThickness = 5;  // thickness of string holder */
stringHoleThickness = topThickness;  // thickness of string holder
stringHolderLength = 3;  // length of string holder attached to top

archAngle = 15;           // angle of rotation of arch under keys
archFudge = 12;           // amount to move arch left

// MCU Cover dimensions
MCUCover = [25.65, 41.15, 2.5]; // dimensions of MCU cover

// PCB Coordinates
PCBTopPoint = 72.07;      // Top y-coord on PCB
PCBBottomPoint = 159.79;  // Bottom y-coord on PCB  8.51
PCBTopEdge = 78.63;       // y-coord of top edge of PCB
PCBLeftPoint = 81.0;      // x-coord of left-most point on PCB
PCBRightPoint = 181.0;    // x-coord of right-most point on PCB

// PCB bottom left corner coordinate
// Note: in KiCad, y-coordinates are reversed from in OpenSCAD
PCBOrigin = [81.0, 159.79, 0];

// Calculated constants
block = [PCBRightPoint - PCBLeftPoint,               // length of block in contact with keyboard
         PCBBottomPoint - PCBTopPoint,               // total width of block
         keyHeight*2 + keyFromTop + keyFromBottom];  // total height of block
sliceAngle = 90 - atan2(keyboardLength, block.z);    // angle at which to slice off bottom of feet

// PCB keyhole positions
keys =                         // Location of key switches
       [[ 88.7,  90.0,  0],
        [107.7,  88.0,  0],
        [130.5,  82.0, -5],
        [ 88.7, 108.0,  0],
        [107.7, 106.0,  0],
        [128.9,  99.9, -5],
        [151.8, 108.9,-15],
        [ 88.7, 126.0,  0],
        [107.7, 124.0,  0],
        [127.4, 117.8, -5],
        [147.1, 126.3,-15],
        [156.4,  91.6,-15],
        [171.0, 122.2,-25],
        [163.5, 138.6,-25],
       ];
diodes =                       // Location of diodes
         [[ 84.5,  99.1,    0],  // 83.6, 99.1
          [ 91.7,  99.1,    0],
          [ 84.5, 117.0,    0],  // 83.6, 117.0
          [ 96.4, 117.0,  180],
          [ 88.6,  81.6,    0],  // 88.6, 80.95
          [114.86, 144.75, 90],
          [105.14, 133.32,  0],
          [101.46, 144.75, 90],
          [121.5,  126.4,  -5],
          [133.1,  109.3, 175],
          [134.7,   91.4, 175],
          [145.5,   95.9,-105],
          [139.5,  115.0, -15],
          [149.1,   98.6, -15],
          [163.5,  116.3,-115],
          [157.0,  130.6,-115],
         ];
screws = [[103.6, 149.06, 0],  // Location of mounting screws
          [151.5, 139.50, 0],
          [166.3,  95.50, 0],
          [ 97.96, 81.80, 0],
         ];

module keyhole(side) {
    // side: -1 for left keyboard half, 1 for right
    // lower: 1 for lower key, 0 for upper

    // Key clip
    translate([switchClipDepth/2, 0, 0])
        cube([switchClipDepth+.01, switchClipSide, switchClipSide], center=true);
    // Key body hole
    translate([switchClipDepth + switchHoleDepth/2, 0, 0])
        cube([switchHoleDepth, switchHoleSide, switchHoleSide], center=true);
    /* rotate([0, 90, 0]) { */
    rotate([0, 90, 0]) {
        // holes for tabs
        translate([0, 0, 0])
            cylinder(h=11, r=1.7, center=true);
        translate([0, 5.5, 0])
            cylinder(h=11, r=.95, center=true);
        translate([0, -5.5, 0])
            cylinder(h=11, r=.95, center=true);
        // holes for pins/wires
        rotate([0, 0, 180]) {
            translate([5.9, 0, 0])
                cylinder(h=40, r=1.5, center=true);
            translate([3.8, side * 5, 0])
                cylinder(h=40, r=1.5, center=true);
        }
    }
}

module screwHole() {
    rotate([0, 180, 0]){
        // screw shaft
        cylinder(h=block.z + .1, d=screwDiameter, center=true);
        // screw head
        translate([0, 0, screwLength - pcbThickness - nutThickness - 1])
            /* cylinder(h=block.z + .1, d=4.8, $fn=6, center=false); */
            cylinder(h=block.z + .1, d=nutDiameter, $fn=6, center=true);
    }
}

module sunkenScrew(x, y) {
    translate([x - PCBOrigin.x, PCBOrigin.y - y, block.z/2]) {
        // screw shaft
        cylinder(h=block.z + .1, d=screwDiameter, center=true);
        // screw head
        translate([0, 0, block.z/2 + 0.5])
            cylinder(h=4, d=screwHeadDiameter, center=true);
    }
}


module keySolderBumps() {  // Holes for bumps from solder joints/tabs of keys tabs
    translate([0, -2.5, 0])
        cube([12.5, 11, 2.5], center=true);
}

module diodeSolderBumps() {  // Holes for bumps from solder joints of diodes
    translate([2.54, 0, 0])
        cube([9, 4, 2.5], center=true);
}

module stringConnector() {
    difference(){
        union(){
            cube([stringHolderLength+2*stringHoleRadius + 0, stringHoleRadius*4, stringHoleThickness], center=true);
            translate([-stringHolderLength/2 - stringHoleRadius, 0, 0])
                rotate([0, 0, 90])
                cylinder(h=stringHoleThickness, r=2*stringHoleRadius, center=true);
        }
        // drill hole for string
        translate([-stringHolderLength/2 - stringHoleRadius, 0, 0])
                rotate([0, 0, 90])
                cylinder(h=stringHoleThickness + 1, r=stringHoleRadius, center=true);
    }
}

module MCUCover() {
    // MCU cover -- basically a block with screw holes
    translate([-MCUCover.x-9, 0, block.z - MCUCover.z]) {
        difference() {
            dim = screwDiameter * 1.5;
            hull() {
                translate([dim/2, dim/2, 0]) cylinder(h=MCUCover.z, d=dim);
                translate([MCUCover.x - dim/2, dim/2, 0]) cylinder(h=MCUCover.z, d=dim);
                translate([dim/2, MCUCover.y-dim/2, 0]) cylinder(h=MCUCover.z, d=dim);
                translate([MCUCover.x-dim/2, MCUCover.y-dim/2, 0]) cylinder(h=MCUCover.z, d=dim);
            }
            translate([ 2.6,  2.65, 0]) cylinder(h=2*MCUCover.z + .1, d=screwDiameter, center=true);
            translate([ 2.6, 38.7, 0]) cylinder(h=2*MCUCover.z + .1, d=screwDiameter, center=true);
            translate([23.2,  2.65, 0]) cylinder(h=2*MCUCover.z + .1, d=screwDiameter, center=true);
            //translate([23.2, 38.7, 0]) cylinder(h=2*MCUCover.z + .1, d=screwDiameter, center=true);
        }
    }
}

module main(side) {
    side = side == "left" ? -1 : 1;
    // flip the board if on the left side
    mirror([0, -(side - 1) / 2, 0])
        translate([0, 0, 0]) {
            union () {
                difference() {
                    union() {

                        // MAIN BLOCK
                        cube([block.x, PCBOrigin.y - PCBTopEdge, block.z]);  // Don't go all the way to end
                        translate([0, 0, block.z - topThickness])
                            cube([block.x-4, block.y, topThickness]); // Don't go all the way to end

                        // ADD STRING CONNECTOR
                        translate([0, .6*block.y, block.z - stringHoleThickness / 2])
                            stringConnector();

                        // ADD ROTATED THUMB BLOCK
                        translate([0, thumbDisplacement, -5])
                            rotate(switchAngle)
                            cube([keyWidth+10, keyWidth-.06, block.z + 5]);

                    }

                    // TOP KEY HOLE
                    translate([-.05, thumbDisplacement, 0])
                        rotate(switchAngle)
                        translate([0, keyWidth/2, block.z - keyFromTop - (keyHeight)/2])
                        keyhole(side);

                    // BOTTOM KEY HOLE
                    translate([-.05, thumbDisplacement, 0])
                        rotate(switchAngle)
                        translate([0, keyWidth/2, keyFromBottom + keyHeight/2])
                        keyhole(side);

                    // EXCESS BEHIND KEY HOLE
                    translate([2, thumbDisplacement, 0])
                        rotate(switchAngle)
                        translate([10, 1, 0])
                        cube([block.x/2, keyWidth, block.z - topThickness]);

                    // CUT OUT ARCH BEHIND KEYS (EXTRUDING OVAL OF CORRECT SIZE)
                    translate([block.x + archFudge,
                            block.y/2,
                            -1.5]) // make sure to leave minimum thickness
                        rotate([90+archAngle, 90, 0]) // archAngle
                        linear_extrude(height=2*block.y, center=true)
                        resize([2*block.z, 2*(block.x - keyMinDepth)])
                        circle($fn=segments);

                    // CUT OUT RECTANGLE WITH KEYS
                    translate([block.x/2,
                            (PCBOrigin.y - PCBTopEdge)/2 + keyWidth/2 - keyMinDepth/2,
                            block.z/2 - topThickness])
                        cube([block.x + 10, PCBOrigin.y - PCBTopEdge - keyWidth - keyMinDepth, block.z], center=true);

                    // SLICE ANGLE OFF BOTTOM OF FEET
                    translate([0, -.05, -10])
                        rotate([0, -sliceAngle, 0])
                        translate([-10, 0, 0])
                        cube([block.x*2 + .1, block.y + .1, 10], center=false);

                    // ADD HOLES FOR SOLDER BUMPS
                    // Key switches
                    if (FINAL) {
                        for (location = keys) {
                            translate([(location.x - PCBOrigin.x), PCBOrigin.y - location.y, block.z])
                                rotate([0, 0, location[2]])
                                keySolderBumps();
                        }
                    }
                    // Diodes
                    if (FINAL) {
                        for (location = diodes) {
                            translate([(location.x - PCBOrigin.x), PCBOrigin.y - location.y, block.z])
                                rotate([0, 0, location[2]])
                                diodeSolderBumps();
                        }
                    }
                    // Screw holes
                    if (FINAL) {
                        for (location = screws) {
                            translate([(location.x - PCBOrigin.x), PCBOrigin.y - location.y, block.z/2])
                                rotate([0, 0, location[2]])
                                screwHole();
                        }
                    }
                    // Terminal holes
                    if (FINAL) {
                        translate([108.16 - PCBOrigin.x, PCBOrigin.y - 140.77, block.z - 9])
                            cube([10.5, 12, 20], center=true);
                    }

                    // CUT OUT LOCATIONS OF OTHER SURFACE COMPONENTS
                    if (FINAL) {
                        // switch
                        if (side == 1) {   // Switch goes on right side only
                            translate([145.61 - PCBOrigin.x, PCBOrigin.y - 80.0, block.z])
                                rotate([0, 0, 167])
                                cube([11, 5, 2.5], center=true);
                        }
                        // reset button
                        if (side == 1) {   // On right side, leave gap for solder bumps
                            translate([125.2 - PCBOrigin.x, PCBOrigin.y - 135.8, block.z])
                                cube([8.6, 6.6, 2.5], center=true);
                        }
                        // String clip:
                        translate([PCBOrigin.x+5.1 - 1, PCBOrigin.y - 111.9 - 1, block.z-5]){
                            cube([clipSlotLength + 1, clipThickness + 2, 10]);
                        }
                        // ethernet jack
                        translate([84 - PCBOrigin.x, PCBOrigin.y - 158.7, block.z-1.5])
                            cube([15.5, 25.5, 3]);
                        /* translate([64 - PCBOrigin.x, PCBOrigin.y - 153.80, block.z-1.5]) */
                        /*     cube([20.1, 14.88, 3]); // cut-out for plug */
                    }

                    // CUT ALL OTHER CURVES
                    // Top left corner
                    difference() {
                        translate([2.5, PCBOrigin.y - PCBTopEdge - 2.5, block.z/2])
                            cube([5.01, 5.01, block.z+1], center=true);
                        translate([5, PCBOrigin.y - PCBTopEdge - 5, block.z/2])
                            rotate([0, 0, 90])
                            cylinder(h=block.z+2, r=5, center=true);
                    }
                    // Top left edge
                    translate([-.1, PCBOrigin.y - PCBTopEdge, -.1])
                        cube([116.58 - PCBOrigin.x, 25, block.z+1], center=false);
                    translate([116.58 - PCBOrigin.x, PCBOrigin.y - PCBTopEdge + 5, block.z/2])
                        rotate([0, 0, 90])
                        cylinder(h=block.z+2, r=5, center=true);
                    // Transition to top arc
                    difference() {
                        translate([125.98 - PCBOrigin.x - 5, PCBOrigin.y - 77.07 + 1, -.5])
                            cube([5.1, 4.1, block.z+1], center=false);
                        translate([125.90 - PCBOrigin.x, PCBOrigin.y - 77.00, block.z/2])
                            rotate([0, 0, 90])
                            cylinder(h=block.z+2, r=5, center=true);
                    }
                    // Bottom left corner
                    translate([0, thumbDisplacement, 0])
                        rotate(switchAngle)
                        difference() {
                            translate([1, 1-sin(switchAngle.z), block.z/2])
                                cube([2.01, 2.01, block.z+1], center=true);
                            translate([1.95, 2.05 - 2*sin(switchAngle.z), block.z/2])
                                rotate([0, 0, 90])
                                cylinder(h=block.z+2, r=2, center=true);
                        }
                    // Top right arc
                    // r=89.27 x=126.72 y=161.34
                    // block: (126.18, 72.07) --> (181, 100)
                    difference() {
                        translate([126.18 - PCBOrigin.x, PCBOrigin.y - 100, 0])
                            cube([55, 28, block.z+1], center=false);
                        translate([126.72 - PCBOrigin.x, PCBOrigin.y - 161.34, block.z/2])
                            rotate([0, 0, 90])
                            cylinder(h=block.z+2, r=89.27, $fn=segments, center=true);
                    }
                    // Bottom arc
                    translate([141.1 - PCBOrigin.x, PCBOrigin.y - 203.9, block.z/2])
                        rotate([0, 0, 90])
                        cylinder(h=block.z+2, r=59.78, $fn=segments, center=true);
                    // Smoothing transition to top right edge
                    difference() {
                        translate([176.03 - PCBOrigin.x + 2.5, PCBOrigin.y - 93.02, -.5])
                            cube([5, 5, block.z+1], center=false);
                        translate([176.03 - PCBOrigin.x, PCBOrigin.y - 93.02, block.z/2])
                            rotate([0, 0, 90])
                            cylinder(h=block.z+2, r=5, center=true);
                    }
                    // Transition to bottom arc on left
                    difference() {
                        translate([102.9 - PCBOrigin.x-2.87, PCBOrigin.y - 156.92 -2.97, -.5])
                            cube([5.2, 0.9, block.z+1], center=false);
                        translate([100.04 - PCBOrigin.x, PCBOrigin.y - 156.96, block.z/2])
                            rotate([0, 0, 90])
                            cylinder(h=block.z+2, r=2.86, center=true);
                    }
                    // Bottom right flat part
                    translate([176 - PCBOrigin.x, PCBOrigin.y - 150.2 - 10, block.z/2])
                        cube([20, 20, block.z+2], center=true);
                    // Transition to bottom arc on right
                    difference() {
                        translate([168.08 - PCBOrigin.x-5.2, PCBOrigin.y - 145.11 -5.2, -.5])
                            cube([5.2, 1.0, block.z+1], center=false);
                        translate([168.08 - PCBOrigin.x, PCBOrigin.y - 145.11, block.z/2])
                            rotate([0, 0, 90])
                            cylinder(h=block.z+2, r=5.1, center=true);
                    }
                    // Bottom right corner
                    difference() {
                        translate([100 - 5, PCBOrigin.y - 145.1 - 5.2, -.5])
                            cube([5.1, 5.1, block.z+1], center=false);
                        translate([100 - 5, PCBOrigin.y - 145.2, block.z/2])
                            rotate([0, 0, 90])
                            cylinder(h=block.z+2, r=5, center=true);
                    }

                    // CUT-OUT FOR NICENANO
                    if (side==1) {  // right side
                        // nicenano: 20 mm wide by 34 long
                        translate([107.65 - PCBOrigin.x, PCBOrigin.y - 103.65 + 2, block.z/2])
                            cube([20, 36, block.z+1], center=true);
                        // screws
                        sunkenScrew( 95.0, 121.45);  // bottom left
                        sunkenScrew(115.75, 121.45);  // bottom right
                        sunkenScrew( 95.0,  85.2);  // top left
                        //sunkenScrew(115.75, 85.2);  // top right
                        // Cut-out for USB-C plug
                        translate([107.65 - PCBOrigin.x-6.5,
                                   PCBOrigin.y - PCBTopEdge - 15,
                                   block.z - 12.5])
                            cube([13, 30, 8.5]);
                    }

                    // CUT OUT BUMPERS -- do it here, and then again later
                    // 1. Inside close bumper
                    rotate([0, -sliceAngle, 0]) translate([bumperDia/2-5, bumperDia/2+6.5, .69])
                        cylinder(d=bumperDia-2, h=2, center=true);
                    // 2. Inside far bumper
                    rotate([0, -sliceAngle, 0]) translate([bumperDia/2+.3, PCBTopEdge-3.5, .69])
                        cylinder(d=bumperDia-2, h=2, center=true);
                    // 3. Outside close bumper
                    translate([100-bumperDia/2-.5, bumperDia+4, 35.0])
                        cylinder(d=bumperDia-2, h=4);
                    // 4. Outside far bumper
                    translate([100-bumperDia/2-.5, PCBTopEdge-bumperDia-1, 35.0])
                        cylinder(d=bumperDia-2, h=4);

                }  // difference

                // BUMPERS
                // 2. Inside far bumper: need to build this up
                difference(){
                    union(){
                        // Cylinder for bumper
                        rotate([0, -sliceAngle, 0])
                            translate([bumperDia/2+.3, PCBTopEdge-3.5, 0.643])
                            cylinder(d=bumperDia, h=stringHoleThickness);
                        // Sphere to go on top
                        rotate([0, -sliceAngle, 0])
                            translate([bumperDia/2+.35, PCBTopEdge-3.54, stringHoleThickness + 0.0])
                            rotate([-10, 0, 0])
                            sphere(d=bumperDia, $fn=128);
                    }
                    // Hollow out spot for bumper inside cylinder
                    rotate([0, -sliceAngle, 0]) translate([bumperDia/2+.3, PCBTopEdge-3.5, 0.643]) cylinder(d=bumperDia-2, h=2, center=true);
                    // Slice off inside corner
                    translate([-bumperDia/2, PCBTopEdge-2.4, -0.05]) {
                        cube([bumperDia, bumperDia, 2*bumperDia + .1]);
                    }
                    // Slice off front edge
                    translate([-bumperDia, PCBTopEdge-bumperDia/2-3, 0])
                        cube([bumperDia, bumperDia, 2*bumperDia]);
                    // Slice off bottom (of sphere)
                    rotate([0, -sliceAngle, 0])
                        translate([0, PCBTopEdge-bumperDia+2.5, -bumperDia])
                            cube([bumperDia, bumperDia, bumperDia]);
                }

            }  // union

        }  // translate

}  // main module

// right side
main("right");
MCUCover();
// left side
translate([0,-1,0]) main("left");
