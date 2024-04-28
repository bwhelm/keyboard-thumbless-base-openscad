$fn= $preview ? 32 : 128; // render more accurately than preview
segments = $preview ? 32 : 512;  // render some curves more accurately still
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
nutThickness = 1.3;       // thickness of nut
nutDiameter = 5.2;        // diameter of nut, point to point (actually 5.0mm)
standoffDiameter = 3.2;   // diameter of standoff
//standoffHeight = 6;       // height of standoff
standoffHeight = 9;       // height needed for MCU under stand

bumperDia = 12.1;         // Diameter of bumpers + 2.1mm

keyboardLength = 106;     // length of keyboard to front surface of thumb

stringHoleRadius = 2;     // radius of hole for string
/* stringHoleThickness = 5;  // thickness of string holder */
stringHoleThickness = topThickness;  // thickness of string holder
stringHolderLength = 3;  // length of string holder attached to top

archAngle = 15;           // angle of rotation of arch under keys
archFudge = 12;           // amount to move arch left

niceNanoSize = [18.5, 36];  // dimensions of nice!nano cutout; nicenano: 18 mm wide by 34 long
MCUCoverTopThickness = 1.5;  // thickness of top cover for MCU cover
MCUCoverWallThickness = 1 + (standoffDiameter + screwHeadDiameter) / 2;
MCUCoverSize = [niceNanoSize.x + MCUCoverWallThickness * 2,  // dimensions of MCU cover
             niceNanoSize.y + MCUCoverWallThickness + .6,
             standoffHeight + 1 + MCUCoverTopThickness];
MCUCoverScrewOffset = screwHeadDiameter / 2;

// CLIP VARIABLS
clipThickness = 7.0;       // Thickness of clip in mm
clipToothDepth = .15;      // thickness of tooth at front of slot
clipToothWidth = 1;        // thickness of front teeth
clipSlotDepth = 1.7;       // depth of slot; PCB is 1.6mm
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
        translate([0, 0, -15])
            cylinder(h=10+.01, d=screwDiameter, center=true);
        // screw head
        translate([0, 0, -15 + screwLength - pcbThickness - nutThickness - 1])
            /* cylinder(h=block.z + .1, d=4.8, $fn=6, center=false); */
            cylinder(h=10, d=nutDiameter, $fn=6, center=true);
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

            // bump for locking folding leg in place
            translate([MCUCoverSize.x - 1.4,
                       MCUCoverSize.y + 1.7,
                       8])
                sphere(2);

            } // union

            // Cut out interior
            translate([MCUCoverWallThickness, MCUCoverWallThickness + .01, -.01])
                cube([niceNanoSize.x, MCUCoverSize.y - 1.91 - topThickness, MCUCoverSize.z - MCUCoverTopThickness]);

            // Cut out USB hole
            translate([MCUCoverSize.x/2 - screwHeadDiameter, MCUCoverSize.y-1, -0.1])
                cube([13, 10, 8.5]);

            // Cut out screws
            translate([0, 0, -MCUCoverSize.z]){
                /* // Bottom left */
                /* sunkenScrew(MCUCoverScrewOffset, MCUCoverScrewOffset, MCUCoverSize.z, standoffDiameter+.1); */
                // Top left
                sunkenScrew(MCUCoverScrewOffset, MCUCoverSize.y - MCUCoverScrewOffset + topThickness, MCUCoverSize.z, standoffDiameter+.1);
                // Bottom right
                sunkenScrew(MCUCoverSize.x - MCUCoverScrewOffset, MCUCoverScrewOffset, MCUCoverSize.z, standoffDiameter+.1);
                /* // Top right: This connects to screw on PCB! */
                /* sunkenScrew(MCUCoverSize.x - MCUCoverScrewOffset - 2, */
                /*             MCUCoverSize.y - MCUCoverScrewOffset + topThickness, */
                /*             MCUCoverSize.z, */
                /*             standoffDiameter+.1); */
            }

        }
    }
}

hingeDia = screwDiameter * 2.5;
hingeHoleDia = hingeDia / 2.5;
hingeThickness = 2;
module hinge() {
    // Thumb Hinge
    difference(){
        union(){
            cylinder(d=hingeDia, h=hingeThickness);
            translate([-hingeDia/2 - 1, -hingeDia/2, 0]) cube([hingeDia/2 + 1, hingeDia, hingeThickness]);
        }
        cylinder(d=hingeHoleDia, h=hingeThickness*2 + .1, center=true);
    }
}

raiseThumbBlock = .2;  // Amount thumb block gets raised by hinge

module wireClip(strands) {
    strandWidth = 1;
    wireThickness = 1;
    union() {
        cube([wireThickness + 1, 2, 3]);
        translate([wireThickness + 1, 0, 0]) cube([2, 2 + 1 + strands * strandWidth, 3]);
        translate([wireThickness, 2 + strands * strandWidth, 0]) cube([1.0, 1, 3]);
    }
}

module thumb(side) {
    thumbBlockThickness = 7;
    side = side == "left" ? -1 : 1;

    // put on baseplate for printing
    translate([(1 + side) * -9.5 - 1, (1 + side) * 19.5 - 3, block.z])
    rotate([90, 90, 0])
    rotate([0, 0, side * -switchAngle.z])

    /* // flip to folded position (approximate) */
    /* translate([38.5, side * 18, block.z-17]) */
    /* rotate([0, -90, side * switchAngle.z]) */
    /* rotate([0, 0, side * -switchAngle.z]) */

    // flip the board if on the left side
    mirror([0, -(side - 1) / 2, 0]){
        translate([0, 0, -raiseThumbBlock]){
            union() {
                difference() {
                    // ADD ROTATED THUMB BLOCK
                    translate([0, 0, -3 - topThickness])
                        rotate(switchAngle)
                        cube([11.8, keyWidth-.06, block.z + 3 + raiseThumbBlock]);

                    // bump for locking folding leg in place
                    rotate(switchAngle)
                    translate([4.5, -1.5, block.z - topThickness - 10])
                        sphere(2);

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
                        /* translate([5.6, 0, 5]) */
                        translate([thumbBlockThickness - 1.81, 0, 5])
                        cube([block.x/2, keyWidth+1, block.z - topThickness - 3]);

                    // CUT OUT ARCH BEHIND KEYS (EXTRUDING OVAL OF CORRECT SIZE)
                    translate([block.x + archFudge,
                            block.y/2,
                            -1.5 + raiseThumbBlock]) // make sure to leave minimum thickness
                        rotate([90+archAngle, 90, 0]) // archAngle
                        linear_extrude(height=2*block.y, center=true)
                        resize([2*block.z, 2*(block.x - keyMinDepth)])
                        circle($fn=segments);

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
                        // Need to put hinges in different spots to avoid the switch wires
                        if (side == 1){  // if right side
                            translate([0, 0,  -2.0]) hinge();
                            translate([0, 0,  -8.0]) hinge();
                            translate([0, 0, -15.6]) hinge();
                        } else {         // if left side
                            translate([0, 0,  -4.1]) hinge();
                            translate([0, 0, -17.7]) hinge();
                            translate([0, 0, -12.0]) hinge();
                        }
                    }
                }

                // WIRE CLIP
                rotate([0, 0, switchAngle.z]){
                    if (side == 1) {  // if right side
                        translate([thumbBlockThickness, 6.5, block.z - topThickness - 10]) wireClip(2);
                    } else {          // if left side
                        translate([thumbBlockThickness, 5.5, block.z - topThickness - 10]) wireClip(2);
                    }
                }

            } // union
        } // translate
    } // mirror
}

module leg(side){
    side = side == "left" ? -1 : 1;

    // put on baseplate for printing
    translate([-22, 0, -block.z - 1.16])
        rotate([0, 90, 0])
        rotate([0, 0, side * 90])
        rotate([0, 90, 0])

    /* // flip to folded position (approximate) */
    /* translate([0, side * 40.9, 106.50]) */
    /*     rotate([side * -90, 0, 0]) */

    // flip the board if on the left side
    mirror([0, -(side - 1) / 2, 0])

    difference(){
        union(){
            difference() {
                translate([0, 77.16, -raiseThumbBlock])
                    cube([11.64, topThickness, block.z - topThickness + raiseThumbBlock]);
            }

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
            translate([.55, block.y - 14, block.z - topThickness - hingeDia/2 - 2*raiseThumbBlock]){
                rotate([-90, 0, 0]) rotate([0, 90, 0]){
                    translate([0, 0, 2.1]) hinge();
                    translate([0, 0, 6.3]) hinge();
                }
            }


        }

        // bump for locking folding leg in place
        translate([13.0,
                78.9,
                block.z - topThickness - 8])
            sphere(2);

        // Round corner
        difference() {
            translate([2.5, PCBOrigin.y - PCBTopEdge - 2.5, block.z/2])
                cube([5.01, 5.01, block.z+1], center=true);
            translate([5, PCBOrigin.y - PCBTopEdge - 5, block.z/2])
                rotate([0, 0, 90])
                cylinder(h=block.z+2, r=5, center=true);
        }

        // Hollow out spot for bumper inside cylinder
        rotate([0, -sliceAngle, 0]) translate([bumperDia/2 + 1, PCBTopEdge-3.5, 0.69]) cylinder(d=bumperDia-2, h=2, center=true);
        // Slice off front edge
        translate([-bumperDia, PCBTopEdge-bumperDia/2-3, 0])
            cube([bumperDia, bumperDia, 2*bumperDia]);
        // Slice off bottom (of sphere)
        rotate([0, -sliceAngle, 0])
            translate([0, PCBTopEdge-bumperDia+2.5, -bumperDia+0.65])
            cube([bumperDia + 1, bumperDia + 1, bumperDia]);

    }
}

module main(side) {
    side = side == "left" ? -1 : 1;
    // flip the board if on the left side
    mirror([0, -(side - 1) / 2, 0])
        translate([0, 0, 0]) {
            union () {

                // Pin for thumb hinge
                translate([24, 1, block.z - 17.7]) cylinder(d=hingeHoleDia-.2, h=17.7, center=false);
                // Pin for back leg hinge
                translate([26.8, 1, block.z - 10.4]) cylinder(d=hingeHoleDia-.2, h=10.4, center=false);

                difference() {
                    union() {

                        // MAIN BLOCK
                        cube([block.x, PCBOrigin.y - PCBTopEdge, block.z]);  // Don't go all the way to end
                        translate([0, 0, block.z - topThickness])
                            cube([block.x-4, block.y, topThickness]); // Don't go all the way to end

                        // ADD STRING CONNECTOR
                        translate([0, .6*block.y, block.z - stringHoleThickness / 2])
                            stringConnector();

                    }

                    // SLICE OFF BACK EDGE (to height of folded thumb block)
                    translate([-2, -2, 0]) cube([100, 92, 23]);

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
                        /* translate([108.16 - PCBOrigin.x, PCBOrigin.y - 140.71, block.z - 1]) */
                        /*     cube([10.5, 12, 18], center=true); */
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
                            cube([clipSlotLength + 1, clipWidth + 2, 10]);
                        }
                        // ethernet jack
                        translate([84 - PCBOrigin.x, PCBOrigin.y - 158.7, block.z-2.8])
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
                            /* sunkenScrew(niceNanoSize.x/2 + standoffDiameter/2 + 1,    // bottom right */
                            /*               -niceNanoSize.y/2 - standoffDiameter/2 - 1, */
                            /*               block.z, */
                            /*               screwDiameter); */
                            /* sunkenScrew(-niceNanoSize.x/2 - standoffDiameter/2 - 1,    // top left */
                            /*               niceNanoSize.y/2 - screwHeadDiameter/2, */
                            /*               block.z, */
                            /*               screwDiameter); */
                            sunkenScrew(niceNanoSize.x/2 + standoffDiameter/2 + 1,    // top right
                                    niceNanoSize.y/2 - screwHeadDiameter/2 + .55,
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
                    /* // 1. Inside close bumper (thumb) */
                    /* rotate([0, -sliceAngle, 0]) translate([bumperDia/2-5, bumperDia/2+6.5, .69]) */
                    /*     cylinder(d=bumperDia-2, h=2, center=true); */
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

                /* // BUMPERS */
                /* // 2. Inside far bumper: need to build this up */
                /* difference(){ */
                /*     union(){ */
                /*         // Cylinder for bumper */
                /*         rotate([0, -sliceAngle, 0]) */
                /*             translate([bumperDia/2+.3, PCBTopEdge-3.5, 0.643]) */
                /*             cylinder(d=bumperDia, h=stringHoleThickness); */
                /*         // Sphere to go on top */
                /*         rotate([0, -sliceAngle, 0]) */
                /*             translate([bumperDia/2+.35, PCBTopEdge-3.54, stringHoleThickness + 0.0]) */
                /*             rotate([-10, 0, 0]) */
                /*             sphere(d=bumperDia, $fn=128); */
                /*         // Fill in between sphere and back leg */
                /*         translate([bumperDia/2 - 1.5, PCBTopEdge-1.3, 6.0]) */
                /*             rotate([90, 0, 0]) */
                /*             cylinder(d=bumperDia, h=2.3); */
                /*     } */
                /*     // Hollow out spot for bumper inside cylinder */
                /*     rotate([0, -sliceAngle, 0]) translate([bumperDia/2+.3, PCBTopEdge-3.5, 0.69]) cylinder(d=bumperDia-2, h=2, center=true); */
                /*     // Slice off inside corner */
                /*     translate([-bumperDia/2, PCBTopEdge-1.4, -0.05]) { */
                /*         cube([bumperDia, bumperDia, 2*bumperDia + .1]); */
                /*     } */
                /*     // Slice off front edge */
                /*     translate([-bumperDia, PCBTopEdge-bumperDia/2-3, 0]) */
                /*         cube([bumperDia, bumperDia, 2*bumperDia]); */
                /*     // Slice off bottom (of sphere) */
                /*     rotate([0, -sliceAngle, 0]) */
                /*         translate([0, PCBTopEdge-bumperDia+2.5, -bumperDia+0.65]) */
                /*         cube([bumperDia, bumperDia, bumperDia]); */
                /* } */

                // HINGE PIECES
                // Thumb block
                rotate([90, 0, switchAngle.z]){
                    translate([4.3 + hingeDia, block.z - topThickness - hingeDia/2 - raiseThumbBlock, 0]){
                        rotate([0, 0, -90]){
                            // Need to put hinges in different spots to avoid the switch wires
                            if (side == 1) { // if right side
                                translate([0, 0, -13.5]) hinge();
                                translate([0, 0, -4.1]) hinge();
                                difference(){
                                    translate([0, 0, -17.7]) hinge();
                                    // Cut off part of hinge sticking out over edge of board
                                    rotate([switchAngle.z, 0, 0])
                                        translate([-7, -18.88, -20]) cube([10, 10, 10]);
                                }
                            } else { // if left side
                                translate([0, 0,  -2.0]) hinge();
                                translate([0, 0,  -6.2]) hinge();
                                translate([0, 0,  -14.1]) hinge();
                            }
                        }
                    }
                }

                // Back leg
                translate([.55, block.y - 14, block.z - topThickness - hingeDia/2 - 2*raiseThumbBlock]){
                    rotate([0, 90, 0]){
                        translate([0, 0, 0]) hinge();
                        translate([0, 0, 4.2]) hinge();
                        translate([0, 0, 8.4]) hinge();
                    }
                }

                // bump for locking back folding leg in place
                if (side == -1) { // Left side only; right side goes on MCU Cover
                    difference() {
                        translate([13.1, 78.9, block.z - topThickness - 8])
                            sphere(2);
                        // lop off edge part of sphere that sticks out on inside wall
                        translate([11.5, 76.2, block.z - topThickness - 10])
                            cube([3, 1, 3]);
                    }
                }

                // bump for locking thumb folding leg in place
                difference() {
                    rotate(switchAngle)
                        translate([4.5, -1.6, block.z - topThickness - 10.2])
                        sphere(2);
                    translate([1.5, -4, block.z - topThickness - 15])
                        cube([10, 4, 10]);
                }

                // Wire clip
                rotate([180-switchAngle.z/2, 90, 0])
                    if (side == 1) {  // if right side
                        translate([-block.z + topThickness, -16.5, -19]) wireClip(4);
                    } else {          // if left side
                        translate([-block.z + topThickness, -16.5, -21.5]) wireClip(4);
                    }

            }  // union

        }  // translate

}  // main module


module clip(clipNumber){  // clipNumber = how many clips to produce
    for (i = [0:clipNumber - 1]) {
        translate([-clipSlotLength-clipWidth - 1, -60 -(clipThickness + 2) * i - 2, block.z - clipWidth]) {
            rotate([90, 0, 0]) {
                difference(){
                    union(){
                        difference(){
                            union(){
                                translate([clipTipLength,0,0])  // Main body
                                    cube([clipSlotLength-clipTipLength + clipSlotGap + stringHoleRadius, clipWidth, clipThickness], center=false);
                                translate([clipTipLength, clipWidth, (clipThickness + clipSlotDepth)/2])  // add front angle
                                    rotate([0,-clipTipAngle,180])
                                    cube([clipTipLength, clipWidth, (clipThickness-clipSlotDepth)/2]);
                                translate([clipTipLength, 0, (clipThickness - clipSlotDepth)/2])  // add front angle
                                    rotate([180,clipTipAngle,180])
                                    cube([clipTipLength, clipWidth, (clipThickness-clipSlotDepth)/2]);
                                translate([clipSlotLength + stringHoleRadius + clipSlotGap, clipWidth/2, 0])
                                    cylinder(h=clipThickness, r=clipWidth/2, center=false);                              // string end
                            }
                            translate([clipSlotLength + stringHoleRadius + clipSlotGap, clipWidth/2, -.1])
                                cylinder(h=clipThickness + .2, r=stringHoleRadius, center=false);                    // remove slot
                            translate([-.1,-.1,(clipThickness-clipSlotDepth)/2])
                                cube([clipSlotLength + .1, clipWidth + .2, clipSlotDepth], center=false);                    // remove string hole
                            translate([0,-.1,-clipSlotDepth])         // shave off bottom
                                cube([clipSlotLength, clipWidth + .2, clipSlotDepth], center=false);
                            translate([0,-.1,clipThickness])         // shave off top
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
                        translate([
                                clipTipLength - stringHoleRadius*3/2 - clipSlotGap/3.4,
                                clipRidgeWidth,
                                clipThickness])  // ridge on top
                            cube([clipSlotLength, clipRidgeWidth, clipRidgeHeight], center=false);
                        translate([
                                clipTipLength - stringHoleRadius*3/2 - clipSlotGap/3.4,
                                clipRidgeWidth,
                                -clipRidgeHeight])  // ridge on bottom
                            cube([clipSlotLength, clipRidgeWidth, clipRidgeHeight], center=false);

                    }
                }
            }
        }
    }
}


// GENERATE MODEL

// RIGHT SIDE
main("right");
thumb("right");
leg("right");

// LEFT SIDE
translate([0,-1,0]) {
    main("left");
    thumb("left");
    leg("left");
}

// MCU COVER -- For printing
translate([-1, 91, 0]) {
    rotate([0, 0, 90]) {
        MCUCover();
    }
}

/* // MCU COVER -- Put in place */
/* translate([2.7, 34.85, block.z*2-MCUCoverSize.z-topThickness]) { */
/*     rotate([180, 0, 180]) { */
/*         MCUCover(); */
/*     } */
/* } */

// STRING CLIP
clip(2);
