$fn= $preview ? 32 : 128; // render more accurately than preview
segments = $preview ? 32 : 512;  // render some curves more accurately still

// VARIABLES DEFINING WHAT TO BUILD (and where)
RIGHT = true;             // whether to print right side components
LEFT  = true;             // whether to print left side components
MAIN  = true;             // whether to print main stand
THUMB = "print";          // "print", "inplace", "folded"
LEG   = "print";          // "print", "inplace", "folded"
MCU   = "print";          // "print", "inplace"
CLIP  = false;            // whether to print string clip
FINAL = true;             // Don't render everything when false!

switchHoleSide = 14.5;    // size of square hole in mm
switchClipSide = 13.8;    // size of square hole in mm
switchClipDepth = 1.3;    // thickness of clips on switches
switchHoleDepth = 2.2;    // depth of switch hole
switchAngle = [0, 0, 25]; // angle to rotate thumb switches
keyHeight = 18;           // space devoted to each key
keyWidth = 19;
keyFromTop = 3;           // distance of key from top of block
keyFromBottom = 1;        // distance of key from bottom of block

keyMinDepth = 5;          // minimum depth of key (and of top support)
topThickness = 4;         // thickness of top

screwDiameter = 2.2;      // diameter of screws
screwHeadDiameter = 6.3;  // diameter of screw head
screwHeadThickness = 1.1; // thickness of screw head
screwLength = 6;          // length of screw shaft
pcbThickness = 1.6;       // thickness of PCB
nutThickness = 1.2;       // thickness of nut
nutDiameter = 5.08;       // diameter of nut, point to point (actually 5.0mm)
standoffDiameter = 3.2;   // diameter of standoff
standoffHeight = 10;      // height needed for MCU under stand

hingeGap = .1;  // gap between hinges
hingeDia = 5.5;
hingeHoleDia = 1.7277;  // = 14 gauge (use copper wire): 1.6277mm

bumperDia = 12.1;         // Diameter of bumpers + 2.1mm

keyboardLength = 106;     // length of keyboard to front surface of thumb

stringHoleRadius = 2;     // radius of hole for string
stringHoleThickness = topThickness;  // thickness of string holder
stringHolderLength = 3;  // length of string holder attached to top

archAngle = 15;           // angle of rotation of arch under keys
archFudge = 12;           // amount to move arch left

niceNanoSize = [18.5, 36];  // dimensions of nice!nano cutout; nicenano: 18 mm wide by 34 long
MCUCoverTopThickness = 1.5;  // thickness of top cover for MCU cover
MCUCoverWallThickness = 1 + (standoffDiameter + screwHeadDiameter) / 2;
MCUCoverSize = [niceNanoSize.x + MCUCoverWallThickness * 2,  // dimensions of MCU cover
             niceNanoSize.y + MCUCoverWallThickness + .6,
             standoffHeight + MCUCoverTopThickness];
MCUCoverScrewOffset = screwHeadDiameter / 2;
usbHoleSize = [13, 10, 8]; // Size of hole for USB plug

// Locking Bumps
lockBumpSize = .8;         // how much locking bump projects out
lockBumpRadius = 2;        // size of cylinder for locking bump

// CLIP VARIABLS
clipThickness = 7.0;       // Thickness of clip in mm
clipToothDepth = .15;      // thickness of tooth at front of slot
clipToothWidth = 1;        // thickness of front teeth
clipSlotDepth = 2.7;       // depth of slot; PCB is 1.6mm, plus 1mm for stand
clipSlotLength = 14;       // length of slot
clipSlotGap = 0.5;         // gap between slot and string hole
clipTipAngle = 9;          // angle of opening of slot
clipTipLength = 3.5;       // length of (angled) tip
clipRidgeHeight = 0.5;     // height of ridge above and below
clipWidth = stringHoleRadius * 4;           // width of clip
clipRidgeWidth = clipWidth/3;                   // width of ridge on top and bottom

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
          [140.5,  115.0,-105],
          [144.5,  116.3, -15],
          [149.0,   98.8, -15],
          [159.2,  125.5,  65],
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
            translate([5.9, 0, 4]) {
                cylinder(h=8, r=1.5, center=true);
                // translate([0, 0, 1]) rotate([0, 45, 0]) cube([2, 2, 8], center=true);
            }
            translate([3.8, side * 5, 4]) {
                cylinder(h=8, r=1.5, center=true);
                // translate([2.1, 0, 1]) rotate([0, 45, 0]) cube([2, 2, 8], center=true);
                // translate([2.1, 0, 1]) cube([2, 2, 8], center=true);
            }
            // translate([18, 0, 7])
            //     cube([18, 1.5, 1], center=true);
        }
    }
}

module screwHole() {
    rotate([0, 180, 0]){
        // screw shaft
        translate([0, 0, -17.5])
            cylinder(h=5+.01, d=screwDiameter, center=true);
        // screw head
        translate([0, 0, -17.5 + screwLength - pcbThickness - nutThickness - 1])
            cylinder(h=5, d=nutDiameter, $fn=6, center=true);
    }
}

module sunkenScrew(x, y, z, r) {
    translate([x, y, z - .02]) {
        // screw shaft
        cylinder(h=z + .01, d=r + .01);
        // screw head
        translate([0, 0, z - screwHeadThickness + 0.02])
            cylinder(h=screwHeadThickness + .01, d=screwHeadDiameter + .01);
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
            translate([-2, 0, 0])
                cube([stringHolderLength+stringHoleRadius, stringHoleRadius*8, stringHoleThickness], center=true);
            translate([-stringHolderLength/2 - stringHoleRadius, 0, 0])
                rotate([0, 0, 90])
                    cylinder(h=stringHoleThickness, r=2*stringHoleRadius, center=true);
        }
        // cut off angle on sides
        rotate([0, 0, 24])
            translate([4, 9.4, 0])
                cube([stringHoleRadius*8, stringHoleRadius*4, stringHoleThickness + .1], center=true);
        rotate([0, 0, -24])
            translate([4, -9.4, 0])
                cube([stringHoleRadius*8, stringHoleRadius*4, stringHoleThickness + .1], center=true);
        // drill hole for string
        translate([-stringHolderLength/2 - stringHoleRadius, 0, 0])
            rotate([0, 0, 90])
                cylinder(h=stringHoleThickness + 1, r=stringHoleRadius, center=true);
    }
}

module MCUCover() {
    // MCU cover -- basically a block with screw holes
    translate([-MCUCoverSize.x-9, 0, block.z - MCUCoverSize.z]) {
        difference() {
            // Main block
            // Use only 2 screws to hold the cover on, so this adjusts walls
            // where there are no screws.
            offset = MCUCoverWallThickness - MCUCoverTopThickness;
            union() {
                hull() {
                    // Bottom left
                    translate([screwHeadDiameter/2 + offset - 1, screwHeadDiameter/2 + offset - 1, MCUCoverSize.z - 2])
                        sphere(2);
                    translate([screwHeadDiameter/2 + offset - 1, screwHeadDiameter/2 + offset - 1, 0])
                        cylinder(h=1, r=2);
                    // Bottom right
                    translate([MCUCoverSize.x - screwHeadDiameter/2 + 1, screwHeadDiameter/2 - 1, MCUCoverSize.z - 2])
                        sphere(2);
                    translate([MCUCoverSize.x - screwHeadDiameter/2 + 1, screwHeadDiameter/2 - 1, 0])
                        cylinder(h=1, r=2);
                    // Top left
                    translate([screwHeadDiameter/2 - 1,
                               MCUCoverSize.y - screwHeadDiameter/2 + 1 + topThickness,
                               MCUCoverSize.z - 2])
                        sphere(2);
                    translate([screwHeadDiameter/2 - 1,
                               MCUCoverSize.y - screwHeadDiameter/2 + 1 + topThickness,
                               0])
                        cylinder(h=1, r=2);
                    // Top right
                    translate([MCUCoverSize.x - screwHeadDiameter/2 + 1,
                               MCUCoverSize.y - screwHeadDiameter/2 + 1 + topThickness,
                               MCUCoverSize.z - 2])
                        sphere(2);
                    translate([MCUCoverSize.x - screwHeadDiameter/2 + 1,
                               MCUCoverSize.y - screwHeadDiameter/2 + 1 + topThickness,
                               0])
                        cylinder(h=1, r=2);
                }

                // bump for locking folding leg in place (standing)
                translate([MCUCoverSize.x - 0.14 - .9,
                           MCUCoverSize.y + 1 - .5,
                           8])
                rotate([0, 90, 0])
                    cylinder(r=lockBumpRadius - .1, h=lockBumpSize + .9);

                // bump for locking folding leg in place (folded)
                translate([MCUCoverSize.x - 0.14 - .9,
                           MCUCoverSize.y + 1 + .55 - 11.75,
                           9.10])
                rotate([0, 90, 0])
                    cylinder(r=lockBumpRadius - .1, h=lockBumpSize + .9);

            } // union

            // Hinge hole
            translate([MCUCoverSize.x - 0.14 - 3,
                    MCUCoverSize.y - 5.4,
                    3.14])
                rotate([0, 90, 0])
                cylinder(d=hingeHoleDia, h=4);

            // Cut out interior
            translate([MCUCoverWallThickness, MCUCoverWallThickness + .01, -.01])
                cube([niceNanoSize.x, MCUCoverSize.y - 1.91 - topThickness, MCUCoverSize.z - MCUCoverTopThickness]);

            // Cut out USB hole
            translate([MCUCoverSize.x/2 - screwHeadDiameter + usbHoleSize.x/2, MCUCoverSize.y, 4.99])
                cube([usbHoleSize.x, usbHoleSize.y, 10], center=true);

            // Cut out screws
            translate([0, 0, -MCUCoverSize.z]){
                // Top left
                sunkenScrew(MCUCoverScrewOffset, MCUCoverSize.y - MCUCoverScrewOffset + topThickness, MCUCoverSize.z, standoffDiameter+.3);
                // Bottom right
                sunkenScrew(MCUCoverSize.x - MCUCoverScrewOffset, MCUCoverScrewOffset, MCUCoverSize.z, standoffDiameter+.3);
            }

        }
    }
}

module hinge(hingeThickness) {
    // Thumb Hinge
    difference(){
        union(){
            cylinder(d=hingeDia, h=hingeThickness);
            translate([-hingeDia/2 - .4, -hingeDia/2, 0]) cube([hingeDia/2 + .4, hingeDia*2, hingeThickness]);
            // Add extra support to base
            cube([hingeDia/4, hingeDia, hingeThickness]);
        }
        // Cut off excess extra support
        translate([-5, 8.7, -.05])
            rotate([0, 0, -45])
            cube([12, 5, hingeThickness+.1]);
        // Cut hole through hinge
        cylinder(d=hingeHoleDia, h=hingeThickness*2 + .1, center=true);
    }
}

raiseThumbBlock = .2;  // Amount thumb block gets raised by hinge

module thumb(side) {
    thumbBlockThickness = 7;
    side = side == "left" ? -1 : 1;

        // flip the board if on the left side
        mirror([0, -(side - 1) / 2, 0]){
            translate([0, 0, -raiseThumbBlock]){
                difference() {
                    union() {
                        difference() {
                            // ADD ROTATED THUMB BLOCK
                            translate([0, 0, -3 - topThickness])
                                rotate(switchAngle)
                                cube([11.8, keyWidth-.06, block.z + 3 + raiseThumbBlock]);

                            // TOP KEY HOLE
                            translate([-.05, 0, 0])
                                rotate(switchAngle)
                                translate([0, keyWidth/2, block.z - keyFromTop - (keyHeight)/2])
                                keyhole(side);

                            // BOTTOM KEY HOLE
                            translate([-.05, 0, 0])
                                rotate(switchAngle)
                                translate([0, keyWidth/2, keyFromBottom + keyHeight/2])
                                keyhole(side);

                            // EXCESS BEHIND KEY HOLE
                            // Undercut the bumper
                            translate([2, 0, 0])
                                rotate(switchAngle)
                                translate([thumbBlockThickness - 1.81, 0, 5])
                                cube([block.x/2, keyWidth+1, block.z - topThickness - 3]);

                            // CUT OUT ARCH BEHIND KEYS (EXTRUDING OVAL OF CORRECT SIZE)
                            if (FINAL) {
                                translate([block.x + archFudge,
                                        block.y/2,
                                        -1.5 + raiseThumbBlock]) // make sure to leave minimum thickness
                                    rotate([90+archAngle, 90, 0]) // archAngle
                                    linear_extrude(height=2*block.y, center=true)
                                    resize([2*block.z, 2*(block.x - keyMinDepth)])
                                    circle($fn=segments);
                                }

                            //  rotate([0, 21, -16])
                            //      translate([1.2,
                            //                 0,
                            //                 0]) // make sure to leave minimum thickness
                            //          cube([20, 20, 30]);

                            // CUT OUT RECTANGLE WITH KEYS
                            translate([block.x/2,
                                    (PCBOrigin.y - PCBTopEdge)/2 + keyWidth/2 - topThickness/2,
                                    block.z/2 - topThickness])
                                cube([block.x + 10, PCBOrigin.y - PCBTopEdge - keyWidth - topThickness, block.z + 1], center=true);

                            // SLICE ANGLE OFF BOTTOM OF FEET
                            translate([0, -.05, -10])
                                rotate([0, -sliceAngle, 0])
                                translate([-10, 0, raiseThumbBlock - 10])
                                cube([block.x*2 + .1, block.y + .1, 20], center=false);

                            // Bumper
                            rotate([0, -sliceAngle, 0]) translate([bumperDia/2-5, bumperDia/2+6.5, .69])
                                cylinder(d=bumperDia-2, h=2, center=true);

                        } // difference

                        // HINGE PIECES
                        rotate([90, 0, switchAngle.z]){
                            translate([4.3 + hingeDia, block.z - topThickness - hingeDia/2, 0]){
                                rotate([180, 0, 0])
                                    // Need to put hinges in different spots to avoid the switch wires
                                    if (side == 1){  // if right side
                                        // translate([0, 0,  0]) hinge(2);
                                        // translate([0, 0, 5.7]) hinge(2.9);
                                        // translate([0, 0, 13.6]) hinge(2);
                                        translate([0, 0,  14.9]) hingeTEST(2.8, -1, -1);
                                        translate([0, 0,  7.8]) hingeTEST(2.9, -1, -1);
                                        translate([0, 0,  0.6]) hingeTEST(4.5, -1, -1);
                                    } else {         // if left side
                                        // translate([0, 0,  2.1]) hinge(2.8);
                                        // translate([0, 0, 10.0]) hinge(2);
                                        // translate([0, 0, 15.7]) hinge(2);
                                        translate([0, 0, 1.8]) hingeTEST(2.5, -1, -1);
                                        translate([0, 0,  7.0]) hingeTEST(7.6, -1, -1);
                                        // translate([0, 0,  2.1]) hingeTEST(2.8, -1, -1);
                                        // translate([0, 0, 8.0]) hingeTEST(3.2, -1, -1);
                                        // translate([0, 0, 13.6]) hingeTEST(4.1, -1, 0);
                                    }
                            }
                        }

                    } // union

                    // GROOVES FOR WIRES: THUMB FIXME
                    rotate(switchAngle)
                        if (side == 1) {                                // RIGHT SIDE
                            // top switch
                            translate([4.8, 3.7, block.z - topThickness - 3.5])
                                rotate([-45, 0, 0]) {
                                    cube([2.01, 2.0, 8]);
                                    translate([-1.4, 0, 0]) rotate([0, 12, 0]) cube([2.01, 2.0, 7]);
                                }
                            // center
                            translate([4.8, 7.9, block.z - topThickness - 2.2])
                                cube([2, 2.0, 3]);
                            // bottom switch
                            rotate([0, 90, 0]) {
                                // translate([-27, 14.5, 6.26])
                                // outer hole
                                translate([-16.6, 3.3, 5.26])
                                    cube([2, 2.5, 2.0]);
                                translate([-17.3, 1.7, 5.26])
                                    rotate([0, 0, 45])
                                    cube([3.5, 2, 2.0]);
                                // center hole
                                translate([-18.6, 8.3, 5.26])
                                    cube([2, 2.5, 2.0]);
                                translate([-24, 1.8, 5.26])
                                    rotate([0, 0, 45])
                                    cube([10, 2, 2.0]);
                                // main channel
                                translate([-37.2, 1.5, 5.26])
                                    cube([20, 2.5, 2.0]);
                            }
                        } else {                                        // LEFT SIDE
                            // top switch
                            translate([4.8, 14.0, block.z - topThickness - 4.3])
                                rotate([45, 0, 0]) {
                                    cube([2.01, 2.0, 8]);
                                    translate([-1.2, 0, 0]) rotate([0, 12, 0]) cube([2.01, 2.0, 8]);
                                }
                            // center
                            translate([4.8, 9.6 + (side - 1)*.65, block.z - topThickness - 2.2])
                                cube([2.01, 2.2, 3]);
                            // bottom switch
                            rotate([0, 90, 0]) {
                                // center hole
                                translate([-19, 8.7, 5.76])
                                    cube([2, 1.5, 1.5]);
                                translate([-22, 4.7, 5.76])
                                    rotate([0, 0, 45])
                                    cube([6, 1.5, 1.5]);
                                // outer hole
                                translate([-18, 13.9, 5.76])
                                    cube([4, 1.5, 1.5]);
                                translate([-18, 15.3, 5.76])
                                    rotate([0, 0, -135])
                                    cube([13, 1.5, 1.5]);
                                // main channel
                                translate([-33.4, 4.45, 5.26])
                                    cube([11.5, 2.5, 2.0]);
                                translate([-38, 1.3, 5.26])
                                    rotate([0, 0, 30])
                                    cube([7, 2.5, 2.0]);
                            }
                        }

                    // bump for locking folding leg in place
                    rotate(switchAngle)
                        translate([4.0, lockBumpSize, block.z - topThickness - 10])
                        rotate([90, 0, 0])
                        cylinder(r=lockBumpRadius, h=lockBumpSize + .1);

                    // Cut off corner to avoid lock bump when folded
                    rotate(switchAngle)
                        translate([-.1, -.5, 33])
                        rotate([70, 0, 0])
                        cube([5, 5, 1]);

                } // difference
            } // translate
        } // mirror
}

module leg(side){
    side = side == "left" ? -1 : 1;

        // flip the board if on the left side
        mirror([0, -(side - 1) / 2, 0])

        difference(){
            union(){
                translate([0, 75.16, -raiseThumbBlock])
                    cube([11.64, topThickness + 2, block.z - topThickness + raiseThumbBlock]);

                // BUMPERS
                // Cylinder for bumper
                rotate([0, -sliceAngle, 0]){
                    translate([bumperDia/2 + 1, PCBTopEdge-3.5, 0.643])
                        cylinder(d=bumperDia, h=stringHoleThickness);
                    // Fill in around bumper
                    translate([1.12, 74, .643])
                        rotate([0, 0, 13])
                        cube ([5, 4, 4]);
                }

                // Hinge
                translate([.55, block.y - 15.9, block.z - topThickness - hingeDia/2 - 2*raiseThumbBlock]){
                    rotate([-90, 0, 0]) rotate([0, 90, 0]){
                        translate([0, 0, 2.15]) hingeTEST(2.0, -1, -1);
                        translate([0, 0, 6.35]) hingeTEST(2.0, -1, -1);
                        // translate([0, 0, 2.45]) hingeTEST(5.8, -1, -1);
                    }
                }

            }

            // Slice off edge of bumper cylinder
            translate([11.65, 76.16 - 5, 0])
                cube([1, 10, 10]);

            // // bump for locking folding leg in place
            // translate([-1.64 - lockBumpSize,
            //         77.15 + .55,
            //         block.z - topThickness - 8])
            //     rotate([0, 90, 0])
            //     cylinder(r=lockBumpRadius, h=20 + lockBumpSize + .1);

            // bump for locking folding leg in place
            translate([11.64 - lockBumpSize,
                    77.15 + .55,
                    block.z - topThickness - 8])
                rotate([0, 90, 0])
                cylinder(r=lockBumpRadius, h=lockBumpSize + .1);

            // Round corner
            difference() {
                translate([2.5, PCBOrigin.y - PCBTopEdge - 2.49, block.z/2])
                    cube([5.01, 5.01, block.z+1], center=true);
                translate([5, PCBOrigin.y - PCBTopEdge - 5, block.z/2])
                    rotate([0, 0, 90])
                    cylinder(h=block.z+2, r=5, center=true);
            }

            // Hollow out spot for bumper inside cylinder
            rotate([0, -sliceAngle, 0]) translate([bumperDia/2 + 1, PCBTopEdge-3.5, 0.69]) cylinder(d=bumperDia-2, h=2, center=true);
            // Slice off front edge
            translate([-bumperDia, PCBTopEdge-bumperDia/2-3, -bumperDia/2])
                cube([bumperDia, bumperDia, 2*bumperDia]);
            // Slice off bottom (of sphere)
            rotate([0, -sliceAngle, 0])
                translate([-1, PCBTopEdge-bumperDia+1.5, -bumperDia+0.65])
                cube([bumperDia + 3, bumperDia + 3, bumperDia]);

            // Cut off corner to avoid lock bump when folded
            translate([11.65 - 1.3, 74.16 - .5, 37])
                rotate([0, 70, 0])
                cube([5, 8, 1]);

        }
}

module main(side) {
    side = side == "left" ? -1 : 1;
    // flip the board if on the left side
    mirror([0, -(side - 1) / 2, 0])
        translate([0, 0, 0]) {
            union() {

                difference() {
                    union() {

                        // MAIN BLOCK
                        cube([block.x, PCBOrigin.y - PCBTopEdge, block.z]);
                        translate([0, 0, block.z - topThickness])
                            cube([block.x, block.y, topThickness]);

                    }

                    // SLICE OFF BACK EDGE (to height of folded thumb block)
                    translate([-2, -2, .2]) cube([100, 92, 23]);

                    // EXCESS BEHIND KEY HOLE
                    translate([2, 0, 0])
                        rotate(switchAngle)
                        translate([-6, .5, 0])
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
                            (PCBOrigin.y - PCBTopEdge)/2 + keyWidth/2 - topThickness/2,
                            block.z/2 - topThickness])
                        cube([block.x + 10, PCBOrigin.y - PCBTopEdge - keyWidth - topThickness, block.z], center=true);

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
                    // Terminal block holes
                    if (FINAL) {
                        // Cut out main hole for terminal block. Adjust the position depending on which side
                        translate([108.16 - PCBOrigin.x - side * 1.25, PCBOrigin.y - 140.71, block.z - 1])
                            cube([8, 12, 18], center=true);
                        // Cut a "ramp" to make it easier to insert wires into terminal block hole
                        translate([102.81 - PCBOrigin.x - side * 1.25, PCBOrigin.y - 140.71, block.z - 3.8])
                            rotate([0, -20, 0])
                            cube([10, 12, 3.01], center=true);
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
                            cube([clipSlotLength + 1, clipWidth + 2, 6], center=false);  // 5+ means open slot
                            // cut slight angle at end of slot
                            translate([6, 0, 0.25])
                                rotate([0, -15, 0])
                                    cube([10, clipWidth + 2, 2]);
                        }
                        // ethernet jack
                        translate([88.0 - PCBOrigin.x, PCBOrigin.y - 143.8 - (side - 1) / 2 * 7.5, block.z - 1.3])
                            cube([6, 5.75, 2.8], center=true);
                        translate([88.0 - PCBOrigin.x, PCBOrigin.y - 155.6 - (side - 1) / 2 * 7.5, block.z - 1.3])
                            cube([6, 5.75, 2.8], center=true);
                        translate([97.0 - PCBOrigin.x, PCBOrigin.y - 149.7 - (side - 1) / 2 * 7.5, block.z - 1.3])
                            cube([5, 11, 2.8], center=true);
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
                        translate([107.65 - PCBOrigin.x - niceNanoSize.x/2,
                                PCBOrigin.y - 82.70 - 1,
                                block.z/2+24])
                            rotate([180, 0, 0])
                            cube([niceNanoSize.x, niceNanoSize.y - 1, 18], center=false);
                        // screws
                        translate([107.65 - PCBOrigin.x, PCBOrigin.y - 103.13 + 2, -block.z]) {
                            sunkenScrew(-niceNanoSize.x/2 - standoffDiameter/2 - 1,    // bottom left
                                    -niceNanoSize.y/2 - standoffDiameter/2 - 1,
                                    block.z,
                                    screwDiameter);
                            sunkenScrew(niceNanoSize.x/2 + standoffDiameter/2 + 1,    // top right
                                    niceNanoSize.y/2 - screwHeadDiameter/2 + topThickness + .55,
                                    block.z,
                                    screwDiameter);
                        }
                        // Cut out gap for MCU Cover
                        translate([107.65 - PCBOrigin.x - MCUCoverSize.x/2,
                                PCBOrigin.y - 82.70 - 2,
                                -topThickness]) {
                            cube([MCUCoverSize.x, 8, block.z]);
                        }
                        // Cut out battery attachment pad
                        translate([114.2 - PCBOrigin.x, PCBOrigin.y - 84.6, block.z])
                            cube([5.5, 4.5, 2.5], center=true);
                    }

                    // Cut off back leg
                    translate([107.65 - PCBOrigin.x - 1*MCUCoverSize.x/2 - 15 + .1,
                            PCBOrigin.y - 82.70 - 2,
                            -topThickness]) {
                        cube([15, 8, block.z]);
                    }

                    // CUT OUT BUMPERS -- do it here, and then again later
                    // 3. Outside close bumper
                    translate([100-bumperDia/2-.5, bumperDia+4, 35.0])
                        cylinder(d=bumperDia-2, h=4);
                        // cylinder(d=bumperDia-2, h=6);
                    // 4. Outside far bumper
                    translate([100-bumperDia/2-.5, PCBTopEdge-bumperDia-1, 35.0])
                        cylinder(d=bumperDia-2, h=4);
                        // cylinder(d=bumperDia-2, h=6);

                    // Cut out hole in side wall for access to thumb hinge
                    rotate([90, 0, switchAngle.z])
                        translate([4.3 + hingeDia, block.z - topThickness - hingeDia/2 - raiseThumbBlock, 0])
                            cylinder(d=hingeHoleDia, h=16 + .1, center=true);

                    // GROOVES FOR WIRES: BASE FIXME
                    if (side==1) {  // Right side
                        rotate(switchAngle){
                            translate([2.4, 1.5, block.z - topThickness - .01])
                                cube([14.1, 2.5, 2.01]);
                            translate([5.4, 8.2, block.z - topThickness - .01])
                                cube([11.1, 2.5, 2.01]);
                        }
                        translate([0.3, 8.3, block.z - topThickness - .01])
                            cube([2.5, 3.7, 2.01]);
                    } else {        // Left side
                        rotate(switchAngle){
                            // for top switch
                            translate([6.6, 8.3, block.z - topThickness - .01])
                                cube([9.6, 2.5, 2.01]);
                            // for bottom switch
                            translate([4.4, 1.8, block.z - topThickness - .01])
                                cube([12.1, 2.5, 2.01]);
                            translate([6.5, 2.2, block.z - topThickness - .01])
                                rotate([0, 0, 45])
                                    cube([2.6, 3, 2.01]);
                        }
                        translate([0.6, 10.5, block.z - topThickness - .01])
                            cube([2.5, 3.7, 2.01]);
                    }

                }  // difference

                // bump for locking thumb folding leg in place (upright)
                rotate(switchAngle)
                    translate([4.0, -.33 + lockBumpSize, block.z - topThickness - 10.2])
                    rotate([90, 0, 0])
                    cylinder(r=lockBumpRadius - .1, h=lockBumpSize + .1);

                // bump for locking thumb folding leg in place (folded)
                rotate(switchAngle)
                    translate([17.05,
                            -.33 + lockBumpSize,
                            block.z - topThickness - 8.83])
                    rotate([90, 0, 0])
                    cylinder(r=lockBumpRadius - .1, h=lockBumpSize + 1);

                // bump for locking back folding leg in place (standing)
                if (side == -1) { // Left side only; right side goes on MCU Cover
                    translate([11.74 - lockBumpSize, 77.18 + .55, block.z - topThickness - 8])
                        rotate([0, 90, 0])
                        cylinder(r=lockBumpRadius - .1, h=lockBumpSize + 1);
                }

                // Build up support for hinge
                if (side == -1) { // Left side only; right side goes on MCU Cover
                    difference(){
                        // build up where bump goes on inside wall
                        union(){
                            translate([11.75, 64.4, block.z - topThickness - 12.80])
                                cube([3.15, 12.8, 12.9]);
                        // bump for locking back folding leg in place (folded)
                        translate([11.06, 67.0, block.z - topThickness - 9.1])
                            rotate([0, 90, 0])
                            cylinder(r=lockBumpRadius - .1, h=lockBumpSize);
                        }
                        // Drill hole through hinge
                        translate([-1, 71.8, block.z - topThickness - 3.2])
                            rotate([0, 90, 0])
                            cylinder(d=hingeHoleDia, h=17);
                        // Cut support on angle to smooth out
                        translate([12.5, 65, block.z - topThickness - 14])
                            rotate([45, 0, 0])
                            cube([5, 4, 10], center=true);
                    }
                }

                // Add bump to make USB hole the right size (on right side only)
                if  (side == 1) {
                    translate([109.55 - PCBOrigin.x - 1*(MCUCoverSize.x - usbHoleSize.x)/2,
                            PCBOrigin.y - 82.63,
                            block.z - topThickness - (9.99 - usbHoleSize.z)]) {
                        cube([usbHoleSize.x-.1, topThickness, 1 + 9.99 - usbHoleSize.z]);
                    }
                }

                // ADD STRING CONNECTOR
                translate([stringHoleThickness/2, .6*block.y, block.z - stringHoleThickness/1.5])
                    rotate([0, -90, 0])
                    stringConnector();

                // HINGE PIECES
                // Thumb block
                rotate([90, 0, switchAngle.z]){
                    translate([4.3 + hingeDia, block.z - topThickness - hingeDia/2 - raiseThumbBlock, 0]){
                        rotate([0, 0, -90]){
                            // Need to put hinges in different spots to avoid the switch wires
                            if (side == 1) { // if right side
                                // translate([0, 0, -13.5]) hinge(2.5);
                                // translate([0, 0, -4.1]) hinge(2);
                                translate([0, 0, -14.8]) hingeTEST(4.0, 0, 5.15);
                                translate([0, 0, -7.7]) hingeTEST(2.5, 0, 5.15);
                                translate([0, 0, -0.5]) hingeTEST(1.5, 0, 5.15);
                            } else { // if left side
                                // translate([0, 0,  -2.0]) hinge(3);
                                // translate([0, 0,  -7.9]) hinge(2.9);
                                // translate([0, 0,  -14.1]) hinge(2);
                                translate([0, 0,  -1.7]) hingeTEST(2.7, 1.4, 0);
                                translate([0, 0,  -6.9]) hingeTEST(2.5, 2.05, 1.7);
                                difference(){
                                    translate([0, 0, -18.2]) hingeTEST(3.5, 0, 5.15);
                                    rotate([switchAngle.z, 0, 0])
                                        translate([-7, -18.88, -20]) cube([10, 10, 10]);
                                }
                                // translate([0, 0,  -2.0]) hingeTEST(3, 1.4, 0);
                                // translate([0, 0,  -7.9]) hingeTEST(2.9, 1.6, 1.4);
                                // translate([0, 0,  -13.5]) hingeTEST(2.2, 2.05, 1.7);
                            }
                        }
                    }
                }

                // Back leg
                translate([11, block.y - 14, block.z - topThickness - hingeDia/2 - 2*raiseThumbBlock]){
                    rotate([0, 90, 180]){
                        translate([0, 1.9, -0.8]) hingeTEST(2.8, 0, .95);
                        translate([0, 1.9, 4.2]) hingeTEST(2, .95, .95);
                        translate([0, 1.9, 8.4]) hingeTEST(2.6, .95, 0);
                        // translate([0, 1.9, -0.8]) hingeTEST(2.9, 0, 2.9);
                        // translate([0, 1.9, 8.1]) hingeTEST(2.9, 2.9, 0);
                    }
                }

            }  // union

        }  // translate

}  // main module


module clip(clipNumber){  // clipNumber = how many clips to produce
    for (i = [0:clipNumber - 1]) {
        translate([-clipSlotLength-clipWidth - 1, -40 -(clipThickness + 2) * i - 2, block.z - clipWidth]) {
            rotate([90, 0, 0]) {
                difference(){
                    union(){
                        difference(){
                            union(){
                                translate([clipTipLength,0,0])  // Main body
                                    cube([clipSlotLength-clipTipLength + clipSlotGap + stringHoleRadius, clipWidth, clipThickness], center=false);
                                // add front angle
                                translate([clipTipLength, clipWidth, (clipThickness + clipSlotDepth)/2])
                                    rotate([0,-clipTipAngle,180])
                                    cube([clipTipLength, clipWidth, (clipThickness-clipSlotDepth)/2]);
                                // add front angle
                                translate([clipTipLength, 0, (clipThickness - clipSlotDepth)/2])
                                    rotate([180,clipTipAngle,180])
                                    cube([clipTipLength, clipWidth, (clipThickness-clipSlotDepth)/2]);
                                // string end
                                translate([clipSlotLength + stringHoleRadius + clipSlotGap, clipWidth/2, 0])
                                    cylinder(h=clipThickness, r=clipWidth/2, center=false);
                            }
                            // remove slot
                            translate([clipSlotLength + stringHoleRadius + clipSlotGap, clipWidth/2, -.1])
                                cylinder(h=clipThickness + .2, r=stringHoleRadius, center=false);
                            // remove string hole
                            translate([-.1,-.1,(clipThickness-clipSlotDepth)/2])
                                cube([clipSlotLength + .1, clipWidth + .2, clipSlotDepth], center=false);
                            // shave off bottom
                            translate([0,-.1,-clipSlotDepth])
                                cube([clipSlotLength, clipWidth + .2, clipSlotDepth], center=false);
                            // shave off top
                            translate([0,-.1,clipThickness])
                                cube([clipSlotLength, clipWidth + .2, clipSlotDepth], center=false);
                        }

                        // Add teeth
                        translate([clipTipLength + (clipSlotLength-clipTipLength)*.67, 0, (clipThickness - clipSlotDepth)/2])
                            cube([1, clipWidth, clipToothDepth], center=false);
                        translate([clipTipLength + (clipSlotLength-clipTipLength)*.67, 0, (clipThickness + clipSlotDepth)/2 - clipToothDepth])
                            cube([clipToothWidth, clipWidth, clipToothDepth], center=false);
                        translate([clipTipLength + (clipSlotLength-clipTipLength)*.33, 0, (clipThickness - clipSlotDepth)/2])
                            cube([1, clipWidth, clipToothDepth], center=false);
                        translate([clipTipLength + (clipSlotLength-clipTipLength)*.33, 0, (clipThickness + clipSlotDepth)/2 - clipToothDepth])
                            cube([clipToothWidth, clipWidth, clipToothDepth], center=false);
                        translate([clipTipLength, 0, (clipThickness - clipSlotDepth)/2])
                            cube([1, clipWidth, clipToothDepth], center=false);
                        translate([clipTipLength, 0, (clipThickness + clipSlotDepth)/2 - clipToothDepth])
                            cube([clipToothWidth, clipWidth, clipToothDepth], center=false);

                        // Add ridge on top and bottom
                        // ridge on top
                        translate([clipTipLength - stringHoleRadius*3/2 - clipSlotGap/3.4,
                                clipRidgeWidth,
                                clipThickness])
                            cube([clipSlotLength, clipRidgeWidth, clipRidgeHeight], center=false);
                        // ridge on bottom
                        translate([clipTipLength - stringHoleRadius*3/2 - clipSlotGap/3.4,
                                clipRidgeWidth,
                                -clipRidgeHeight])
                            cube([clipSlotLength, clipRidgeWidth, clipRidgeHeight], center=false);

                    }
                }
            }
        }
    }
}


// GENERATE MODEL

module build() {

    // // BEGIN SLICE OFF CHUNK OF MODEL
    // difference(){
    //     union(){

    // RIGHT SIDE
    if (RIGHT) {
        side = 1;

        // MAIN STAND
        if (MAIN)
            main("right");

        // THUMB LEG
        if (THUMB == "print")
            // put on baseplate for printing
            rotate([90, -90, 0])
                translate([27.45, 1.5, -36.5])
                rotate([0, 0, side * -switchAngle.z])
                thumb("right");
        else if (THUMB == "inplace")
            thumb("right");
        else if (THUMB == "folded")
            // flip to folded position (approximate)
            rotate([0, -90, side * switchAngle.z])
                translate([23.25, 0, -42.9])
                rotate([0, 0, side * -switchAngle.z])
                thumb("right");

        // BACK LEG
        if (LEG == "print")
            // put on baseplate for printing
            translate([-22, 0, -block.z - 1.16])
                rotate([0, 90, 0])
                rotate([0, 0, side * 90])
                rotate([0, 90, 0])
                leg("right");
        else if (LEG == "inplace")
            leg("right");
        else if (LEG == "folded")
            // flip to folded position (approximate)
            rotate([side * -90, 0, 0])
                translate([0, -104.67, 38.98])
                leg("right");

        // MCU COVER
        if (MCU == "print") {
            // put on baseplate for printing
            translate([-41, 86, 0]) {
                rotate([0, 0, 180]) {
                    MCUCover();
                }
            }
        } else if (MCU == "inplace") {
            translate([2.7, 34.85, block.z*2-MCUCoverSize.z-topThickness]) {
                rotate([180, 0, 180]) {
                    MCUCover();
                }
            }
        }

    }

    // LEFT SIDE
    if (LEFT) {
        side = -1;

        translate([0,-1,0]) {
            if (MAIN)
                main("left");

            if (THUMB == "print")
                // put on baseplate for printing
                translate([side * 9.5 - 11, (1 + side) * 19.5 - 3, block.z - 12.55])
                    rotate([90, -90, 0])
                    rotate([0, 0, side * -switchAngle.z])
                    thumb("left");
            else if (THUMB == "inplace")
                thumb("left");
            else if (THUMB == "folded")
                // flip to folded position (approximate)
                rotate([0, -90, side * switchAngle.z])
                    translate([23.25, 0, -42.9])
                    rotate([0, 0, side * -switchAngle.z])
                    thumb("left");

            if (LEG == "print")
                // put on baseplate for printing
                translate([-22, 0, -block.z - 1.16])
                    rotate([0, 90, 0])
                    rotate([0, 0, side * 90])
                    rotate([0, 90, 0])
                    leg("left");
            else if (LEG == "inplace")
                leg("left");
            else if (LEG == "folded")
                // flip to folded position (approximate)
                // translate([0, side * 39.0, 104.60])
                    rotate([side * -90, 0, 0])
                    translate([0, 104.67, 38.98])
                    leg("left");

        }

    }

    // STRING CLIP
    if (CLIP)
        clip(2);

    // // END SLICE OFF CHUNK OF MODEL
    // }
    // translate([25, -100, 0]) cube([100, 200, 100]);
    // translate([0, -90, 0]) cube([100, 62, 100]);
    // }

}

build();

module hingeTEST(hingeThickness, x, y)
    hinge(hingeThickness);

// // hingeDia = 5.5;
// // hingeHoleDia = 1.7277;  // = 14 gauge (use copper wire): 1.6277mm
// module hingeTEST(hingeThickness, coneL, coneR) {
//     // Thumb Hinge
//     // coneL and coneR determine whether to add (>0) or subtract (-1) cones or do nothing (0).
//     // When coneL/coneR is >0, the number provides the height of the relevant cone.
//     // (Max for cone is 5mm.)
//     a = .5;  // distance from top to start cone
//     c = .5;  // distance from middle to end cone
//     maxConeHeight = 2;
//     difference(){
//         union(){
//             cylinder(d=hingeDia, h=hingeThickness);
//             if (coneL > 0) {
//                 mirror([0, 0, 1])
//                     cylinder(d1=hingeDia - 2*a - .1, d2=0, h=(coneL > maxConeHeight) ? maxConeHeight : coneL);
//                 translate([0, 0, (coneL > maxConeHeight) ? -maxConeHeight : -coneL - 1.5*hingeGap])
//                     cylinder(r=c - .1, h=(coneL > maxConeHeight) ? maxConeHeight : coneL + 1.5*hingeGap);  // adding hingeGap to ensure these connect from each side
//             }
//             if (coneR > 0) {
//                 translate([0, 0, hingeThickness]) {
//                     cylinder(d1=hingeDia - 2*a - .1, d2=0, h=(coneR > maxConeHeight) ? maxConeHeight : coneR);
//                     cylinder(r=c - .1, h=(coneR > maxConeHeight) ? maxConeHeight : coneR + 1.5*hingeGap);  // adding hingeGap to ensure these connect from each side
//                     }
//             }
//             translate([-hingeDia/2 - 1, -hingeDia/2, 0]) cube([hingeDia/2 + 1, hingeDia*2, hingeThickness]);
//             // Add extra support to base
//             cube([hingeDia/4, hingeDia, hingeThickness]);
//         }
//
//         if (coneL < 0) {
//             translate([0, 0, -0.01])
//             cylinder(d1=hingeDia - 2*a, d2=0, h=(hingeThickness > 2*maxConeHeight) ? maxConeHeight : hingeThickness/2);
//             // Cut hole through hinge
//             cylinder(r=c, h=(hingeThickness > 10) ? maxConeHeight + .01 + hingeGap : hingeThickness/2 + hingeGap + .01);
//         }
//
//         if (coneR < 0) {
//             translate([0, 0, hingeThickness + .01]) mirror([0, 0, 1]) {
//                 translate([0, 0, -0.01])
//                     cylinder(d1=hingeDia - 2*a, d2=0, h=(hingeThickness > 2*maxConeHeight) ? maxConeHeight : hingeThickness/2);
//                 // Cut hole through hinge
//                 cylinder(r=c, h=(hingeThickness > 10) ? maxConeHeight + .01 : hingeThickness/2 + hingeGap + .01);
//             }
//         }
//
//         // Cut off excess extra support
//         translate([-5, 8.7, -.05])
//             rotate([0, 0, -45])
//             cube([12, 5, hingeThickness+.1]);
//
//     }
// }
