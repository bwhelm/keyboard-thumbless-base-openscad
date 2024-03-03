$fn= $preview ? 32 : 64;  // render more accurately than preview
FINAL = true;             // Don't render everything when false!

switchHoleSide = 14.5;    // size of square hole in mm
switchClipSide = 13.8;    // size of square hole in mm
switchClipDepth = 1.3;    // thickness of clips on switches
switchHoleDepth = 2.2;    // depth of switch hole
switchAngleZ = 25;        // Angle to rotate thum switches on Z axis
switchAngle = [0, 0, switchAngleZ];         // angle to rotate thumb switches
thumbDisplacement = -0;  // Amount thumb keys are displaced from bottom of board
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
nutDiameter = 4.9;        // diameter of nut, point to point
standoffDiameter = 3.2;   // diameter of standoff  FIXME!
standoffHeight = 6;       // height of standoff  FIXME!!

bumperDia = 12.1;         // Diameter of bumpers + 2.1mm
clipSlotLength = 14;      // length of slot in string clip
clipThickness = 8.0;      // thickness of string clip + 1 mm

keyboardLength = 102;     // length of keyboard to front surface of thumb

stringHoleRadius = 2;     // radius of hole for string
/* stringHoleThickness = 5;  // thickness of string holder */
stringHoleThickness = topThickness;  // thickness of string holder
stringHolderLength = 3;  // length of string holder attached to top

archAngle = 15;           // angle of rotation of arch under keys
archFudge = 12;           // amount to move arch left

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
keys = [[ 88.7,  90.0,  0],
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
diodes = [[ 83.6,  99.1,  0],
          [ 91.7,  98.9,  0],
          [ 83.2, 117.1,  0],
          [ 96.4, 117.0,180],
          [ 97.8,  88.0,-90],
          [119.9, 134.9,180],
          [122.8, 133.9,-90],
          [133.1, 133.8,-90],
          [121.5, 126.4, -5],
          [133.1, 109.3,175],
          [134.7,  91.4,175],
          [145.5,  95.9,-105],
          [139.5, 115.0,-15],
          [149.1,  98.6,-15],
          [163.5, 116.3,-115],
          [157.0, 130.6,-115],
         ];
screws = [[103.8, 147.1, 0],
          [151.5, 139.5, 0],
          [166.3,  95.5, 0],
          [ 98.14, 83.93, 0],
         ];
terminals = [[126.1, 138.9, 180],
             [129.7, 138.9, 180],
            ];

module keyhole(side) {
    // side: -1 for left keyboard half, 1 for right
    // lower: 1 for lower key, 0 for upper

    /* rotate([90, 0, 0]) { */
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
/* } */

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

module keySolderBumps() {  // Holes for bumps from solder joints/tabs of keys
                               // tabs
    translate([0, -2.5, 0])
        cube([14, 11, 2.5], center=true);
    /* rotate([0, 0, 90]) { */
    /*     // Center tab hole */
    /*     cylinder(h=3, r=2.75, $fn=8, center=true); */
    /*     // Side tab holes */
    /*     translate([0, 5.5, 0]) */
    /*         cylinder(h=3, r=1.75, $fn=8, center=true); */
    /*     translate([0, -5.5, 0]) */
    /*         cylinder(h=3, r=1.75, $fn=8, center=true); */
    /*     // pin holes */
    /*     translate([-5.9, 0, 0]) */
    /*         cylinder(h=3, r=1.75, $fn=8, center=true); */
    /*     translate([-3.8, side * 5, 0]) */
    /*         cylinder(h=3, r=1.75, $fn=8, center=true); */
    /* } */
}

module diodeSolderBumps() {  // Holes for bumps from solder joints of diodes
    translate([2.54, 0, 0])
        cube([9, 4, 2.5], center=true);
    /* rotate([0, 0, 90]) { */
    /*     cylinder(h=3, r=2, $fn=8, center=true); */
    /*     translate([0, -5.08, 0]) */
    /*         cylinder(h=3, r=2, $fn=8, center=true); */
    /* } */
}

module terminalHoles(side) {  // Holes for bumps from solder joints of diodes
    translate([0, -2.54, 0]) {
        cylinder(h=block.z, r=1, center=true);
        translate([0, side*2.54, 0])
            cylinder(h=block.z, r=1, center=true);
    }
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

module solderHole() {
    rotate([0, 90, 0]) cylinder(h=2.1, d=3, center=true);
}

module thumbCluster(side) {
    side = side == "left" ? -1 : 1;
    // flip the board if on the left side
    mirror([0, -(side - 1) / 2, 0])
        translate([0, 0, 0]) {
            union () {
                difference() {
                    union() {

                        // Main block
                        cube([block.x, PCBOrigin.y - PCBTopEdge, block.z]);  // Don't go all the way to end
                        translate([0, 0, block.z - topThickness])
                            cube([block.x-4, block.y, topThickness]); // Don't go all the way to end

                        // Add string connector
                        translate([0, .6*block.y, block.z - stringHoleThickness / 2])
                            stringConnector();

                        // Add rotated thumb block
                        translate([0, thumbDisplacement, -5])
                            rotate(switchAngle)
                            cube([keyWidth+10, keyWidth-.06, block.z + 5]);

                    }

                    // Top key hole
                    translate([-.05, thumbDisplacement, 0])
                        rotate(switchAngle)
                        translate([0, keyWidth/2, block.z - keyFromTop - (keyHeight)/2])
                        keyhole(side);

                    // Bottom key hole
                    translate([-.05, thumbDisplacement, 0])
                        rotate(switchAngle)
                        translate([0, keyWidth/2, keyFromBottom + keyHeight/2])
                        keyhole(side);

                    // Excess behind key hole
                    translate([0, thumbDisplacement, 0])
                        rotate(switchAngle)
                        translate([10, 3, 0])
                        cube([block.x, keyWidth, block.z - topThickness]);

                    // Cut out arch behind keys (extruding oval of correct size)
                    translate([block.x + archFudge,
                            block.y/2,
                            -1.5]) // make sure to leave minimum thickness
                        rotate([90+archAngle, 90, 0]) // archAngle
                        linear_extrude(height=2*block.y, center=true)
                        resize([2*block.z, 2*(block.x - keyMinDepth)])
                        circle();

                    // Cut out rectangle with keys
                    translate([block.x/2,
                            (PCBOrigin.y - PCBTopEdge)/2 + keyWidth/2 - keyMinDepth/2,
                            block.z/2 - topThickness])
                        cube([block.x + 10, PCBOrigin.y - PCBTopEdge - keyWidth - keyMinDepth, block.z], center=true);

                    // Slice angle off bottom of feet
                    translate([0, -.05, -10])
                        rotate([0, -sliceAngle, 0])
                        translate([-10, 0, 0])
                        cube([block.x + .1, block.y + .1, 10], center=false);

                    // Add holes for solder bumps
                    // Keys
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
                        translate([127.9 - PCBOrigin.x, PCBOrigin.y - 136.36 - 1.27 * side, block.z - 9])
                            cube([6, 6, 20], center=true);
                    }

                    // Cut out locations of other surface components
                    if (FINAL) {
                        // switch
                        if (side == 1) {   // Switch goes on right side only
                            translate([145.1 - PCBOrigin.x, PCBOrigin.y - 80.0, block.z])
                                rotate([0, 0, 170])
                                cube([11, 5, 2.5], center=true);
                        }
                        // reset button FIXME: Position needs to be adjusted!
                        if (side == 1) {   // On right side, leave gap for solder bumps
                            translate([171.3 - PCBOrigin.x, PCBOrigin.y - 103.5, block.z])
                                rotate([0, 0, -25])
                                cube([8.6, 6.6, 2.5], center=true);
                        }
                        // String clip: FIXME: Position needs to be adjusted!
                        translate([PCBOrigin.x+5.1, 44, block.z-5]){
                            cube([clipSlotLength, clipThickness, 10]);
                        }
                        // ethernet jack
                        translate([84 - PCBOrigin.x, PCBOrigin.y - 158.4, block.z-1.5])
                            cube([15, 25.5, 3]);
                        /* translate([64 - PCBOrigin.x, PCBOrigin.y - 153.80, block.z-1.5]) */
                        /*     cube([20.1, 14.88, 3]); // cut-out for plug */
                    }

                    /* // cut off far right side for rubber feet/clip */
                    /* translate([block.x, block.y/2, block.z - 15]) { */
                    /*     rotate([0, 0, -25]) { */
                    /*         translate([3, -40, 0]) */
                    /*             cube([15, 50, 30]); */
                    /*         translate([-9.75, -5, 0]) */
                    /*             cube([15, 50, 30]); */
                    /*         translate([-19, 12, 0]) */
                    /*             cube([15, 50, 30]); */
                    /*         translate([-17, -5, 0]) */
                    /*             cube([10, 7, 30]); */
                    /*     } */
                    /*     translate([-14.5, -1, 0]) */
                    /*         cube([19, 10, 30]); */
                    /* } */

                    // Cut all other curves

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

                    // // Top corner of thumb
                    // translate([0, -thumbDisplacement*1+1, 0])
                    //     rotate(switchAngle)
                    //     difference() {
                    //         translate([-sin(switchAngle.z)*keyWidth+1, -sin(switchAngle.z)*thumbDisplacement-2.93, block.z/2])
                    //             cube([2.01, 2.01, block.z+1], center=true);
                    //         translate([-sin(switchAngle.z)*keyWidth+2, -sin(switchAngle.z)*thumbDisplacement-4, block.z/2])
                    //             rotate([0, 0, 90])
                    //             cylinder(h=block.z+2, r=2, center=true);
                    //     }

                    // Top right arc
                    // r=89.27 x=126.72 y=161.34
                    // block: (126.18, 72.07) --> (181, 100)
                    difference() {
                        translate([126.18 - PCBOrigin.x, PCBOrigin.y - 100, 0])
                            cube([55, 28, block.z+1], center=false);
                        translate([126.72 - PCBOrigin.x, PCBOrigin.y - 161.34, block.z/2])
                            rotate([0, 0, 90])
                            cylinder(h=block.z+2, r=89.27, center=true);
                    }

                    // Bottom arc
                    translate([141.1 - PCBOrigin.x, PCBOrigin.y - 203.9, block.z/2])
                        rotate([0, 0, 90])
                        cylinder(h=block.z+2, r=59.78, center=true);

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

                    if (side==1) {  // right side
                                    // cut-out for nicenano: 20 mm wide by 34 long ... but need thin layer for battery plus screws
                        translate([107.65 - PCBOrigin.x, PCBOrigin.y - 111.35 + 2, block.z/2])
                            cube([22, 39, block.z+1], center=true);
                        // screws
                        translate([115.27 - PCBOrigin.x, PCBOrigin.y - 130.42, block.z/2]) {
                            // screw shaft
                            cylinder(h=block.z + .1, d=screwDiameter, center=true);
                            // screw head
                            translate([0, 0, block.z/2 + 0.5])
                                cylinder(h=5, d=screwHeadDiameter, center=true);
                        }
                        translate([100.03 - PCBOrigin.x, PCBOrigin.y - 130.42, block.z/2]) {
                            // screw shaft
                            cylinder(h=block.z + .1, d=screwDiameter, center=true);
                            // screw head
                            translate([0, 0, block.z/2 + 0.5])
                                cylinder(h=5, d=screwHeadDiameter, center=true);
                        }
                        // Cut-out for USB-C plug
                        translate([107.65 - PCBOrigin.x, PCBOrigin.y - PCBTopEdge, block.z])
                            cube([13, 30, 23], center=true);
                    }

                    // Cut out bumpers -- do it here, and then again later
                    // 1. Inside close bumper
                    rotate([0, -sliceAngle, 0]) translate([bumperDia/2-5, bumperDia/2+5, .69])
                        cylinder(d=bumperDia-2, h=2, center=true);
                    // 2. Inside far bumper
                    rotate([0, -sliceAngle, 0]) translate([bumperDia/2+.3, PCBTopEdge-3, .69])
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
                    rotate([0, -sliceAngle, 0])
                        translate([bumperDia/2+.3, PCBTopEdge-3, 0.7])
                        cylinder(d=bumperDia, h=stringHoleThickness);
                    rotate([0, -sliceAngle, 0]) translate([bumperDia/2+.3, PCBTopEdge-3, 0.7]) cylinder(d=bumperDia-2, h=2, center=true);
                    translate([-bumperDia/2, PCBTopEdge-2.4, -0.05]) {
                        cube([bumperDia, bumperDia, bumperDia + .1]);
                    }
                    translate([-bumperDia, PCBTopEdge-bumperDia/2-3, 0])
                        cube([bumperDia, bumperDia, bumperDia]);
                }

            }  // union

        }  // translate

}  // thumbCluster module

// right side
thumbCluster("right");
// left side
// translate([0,-20,0]) thumbCluster("left");
