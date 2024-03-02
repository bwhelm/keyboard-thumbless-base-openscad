$fn= $preview ? 32 : 64;  // render more accurately than preview
switchHoleSide = 14.5;    // size of square hole in mm
switchClipSide = 13.8;    // size of square hole in mm
switchClipDepth = 1.3;    // thickness of clips on switches
switchHoleDepth = 2.2;    // depth of switch hole
switchAngle = 30;         // angle to rotate thumb switches
keyHeight = 18;           // space devoted to each key
keyWidth = 19;
keyFromTop = 10;           // distance of key from top of block
keyFromBottom = 1;        // distance of key from bottom of block

blockWidth = 70;          // total width of block (23 for just the keys)
blockLength = 114;         // length of block in contact with keyboard
blockDepth = 5;           // depth of block
topThickness = 4;         // thickness of top

screwDiameter = 2.2;      // diameter of screws
screwLength = 6;          // length of screw shaft
pcbThickness = 1.6;       // thickness of PCB
nutThickness = 1.3;       // thickness of nut
screwHeadDiameter = 6.3;  // diameter of nut, point to point

keyboardLength = 102;     // length of keyboard to front surface of thumb

stringHoleRadius = 2;     // radius of hole for string
stringHoleThickness = 5;  // thickness of string holder
stringHolderLength = 10;  // length of string holder attached to top

archAngle = 15;           // angle of rotation of arch under keys
archFudge = 12;           // amount to move arch left

// Calculated constants
blockHeight = keyHeight*2 + keyFromTop + keyFromBottom;  // total height of block
sliceAngle = 90 - atan2(keyboardLength, blockHeight);  // angle at which to slice off bottom of feet

// Fastener locations
fastener1 = [-.1, 4, 10.53];

// PCB keyhole positions
rightKeys = [[ 88.7,  90.0,  0],
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
rightDiodes = [[ 98.2,  94.2, 90],
               [120.3,  90.0, 85],
               [144.9,  97.7, 75],
               [ 98.1, 114.9, 90],
               [118.7, 107.9, 85],
               [140.6, 113.9, 75],
               [ 98.2, 122.7,-90],
               [117.7, 119.2,-95],
               [138.8, 121.0,-105],
               [156.7, 131.1,-115],
               [161.0, 118.8,-115],
              ];
rightReference = [89.0 - fastener1[2], 145.0 + fastener1[1]];

leftKeys = [[280.0,  90.0,  0],
            [280.0, 108.0,  0],
            [280.0, 126.0,  0],
            [261.0,  88.0,  0],
            [261.0, 106.0,  0],
            [261.0, 124.0,  0],
            [238.1,  82.0,  5],
            [239.7,  99.9,  5],
            [241.2, 117.8,  5],
            [217.6, 108.9, 15],
            [222.3, 126.3, 15],
            [213.0,  91.6, 15],
            [198.3, 122.3, 25],
            [205.9, 138.7, 25],
           ];
leftDiodes = [[270.5,  98.9, 90],
              [270.5, 106.8,-90],
              [270.5, 124.7,-90],
              [251.5,  96.9, 90],
              [251.5, 103.7,-90],
              [251.5, 122.7,-90],
              [229.4,  91.7, 95],
              [230.4, 103.0,-85],
              [232.4, 126.0, 95],
              [224.4,  97.8,-165],
              [292.3, 138.6,163],
              [207.8, 108.7,-75],
              [211.3, 121.7,105],
              [212.8, 127.5,-75],
              [207.9, 127.8,-155],
             ];
leftReference = [279.6 + fastener1[2], 145.0 + fastener1[1]];

module keyhole(side, lower) {
    // side: -1 for left keyboard half, 1 for right
    // lower: 1 for lower key, 0 for upper
    // Key clip
    translate([0, 0, switchClipDepth/2])
        cube([switchClipSide, switchClipSide, switchClipDepth+.01], center=true);
    // Key body hole
    translate([0,
            0,
            switchClipDepth + switchHoleDepth/2])
        cube([switchHoleSide, switchHoleSide, switchHoleDepth], center=true);
    // holes for tabs
    translate([0, 0, 0])
        cylinder(h=11, r=1.7, center=true);
    translate([0, 5.5, 0])
        cylinder(h=11, r=.95, center=true);
    translate([0, -5.5, 0])
        cylinder(h=11, r=.95, center=true);
    // holes for pins/wires
    rotate([0,0,180*lower]) {
    translate([5.9, 0, 0])
        cylinder(h=100, r=1.5, center=true);  // FIXME: Make these smaller?
    translate([3.8, side * 5, 0])
        cylinder(h=100, r=1.5, center=true);  // FIXME: Make these smaller?
        }
}

module keySolderBumps(side) {  // Holes for bumps from solder joints/tabs of keys
                               // tabs
    rotate([0, 90, 0])
        translate([0, -2.5, 0])
            cube([14, 11, 2.5], center=true);

    /* // tabs */
    /* rotate([0, 90, 0]) cylinder(h=3, r=3, $fn=8, center=true); */
    /* translate([0, 0, 5.5]) */
    /*     rotate([0, 90, 0]) cylinder(h=3, r=2, $fn=8, center=true); */
    /* translate([0, 0, -5.5]) */
    /*     rotate([0, 90, 0]) cylinder(h=3, r=2, $fn=8, center=true); */
    /* // pins */
    /* translate([0, -5.9, 0]) */
    /*     rotate([0, 90, 0]) cylinder(h=3, r=2, $fn=8, center=true); */
    /* translate([0, -3.8, side * 5]) */
    /*     rotate([0, 90, 0]) cylinder(h=3, r=2, $fn=8, center=true); */
}

module diodeSolderBumps() {  // Holes for bumps from solder joints of diodes
    rotate([0, 90, 0])
        translate([-2.54, 0, 0])
            cube([9, 4, 2.5], center=true);
    /* rotate([0, 90, 0]) cylinder(h=3, r=2, $fn=8, center=true); */
    /* translate([0, 0, 5.08]) */
    /*     rotate([0, 90, 0]) cylinder(h=3, r=2, $fn=8, center=true); */
}

module screwHole() {
    rotate([0, 90, 0]){
        // screw shaft
        cylinder(h=blockHeight + .1, d=screwDiameter, center=false);
        // screw head
        translate([0, 0, screwLength - pcbThickness - nutThickness - 1])
            /* cylinder(h=blockHeight + .1, d=4.8, $fn=6, center=false); */
            cylinder(h=blockHeight + .1, d=screwHeadDiameter, center=false);
    }
}

module stringConnector() {
    difference(){
        union(){
            cube([stringHoleThickness, stringHoleRadius*4, stringHolderLength+2*stringHoleRadius + 0], center=true);
            translate([0, 0, -stringHolderLength/2 - stringHoleRadius])
                rotate([0, 90, 0])
                cylinder(h=stringHoleThickness, r=2*stringHoleRadius, center=true);
        }
        translate([0, 0, -stringHolderLength/2 - stringHoleRadius])
                rotate([0, 90, 0])
                cylinder(h=stringHoleThickness + 1, r=stringHoleRadius, center=true);
        rotate([0,-38,0])
            translate([stringHoleThickness, 0, stringHolderLength/2 - 2])
                cube([stringHoleThickness, stringHoleRadius*4 + .1, stringHolderLength-2], center=true);
    }
}

module solderHole() {
    rotate([0, 90, 0]) cylinder(h=2.1, d=3, center=true);
}

module thumbCluster(side) {
    side = side == "left" ? -1 : 1;
    // flip the board if on the left side
    rotate([0,-90,180])
    mirror([0, -(side - 1) / 2,0])
    /* translate([0, 0, 0]) */
    translate([0, 0, 0])
    {
        difference(){
            union() {
            // Main block
            cube([blockHeight, blockWidth, blockLength]);

                // Add rotated thumb block
                translate([0, 0, 0])
                    rotate([-switchAngle, 0, 0])
                        cube([blockHeight, keyWidth, keyWidth]);
            }

            // Top key hole
            rotate([-switchAngle, 0, 0])
                translate([keyFromTop + (keyHeight)/2, keyWidth/2, 0])
                    keyhole(side, 0);

            // Bottom key hole
            rotate([-switchAngle, 0, 0])
                translate([keyFromTop + (keyHeight)/2 + keyHeight, keyWidth/2, 0])
                    keyhole(side, 1);

            // Cut out arch behind keys (extruding oval of correct size)
            translate([blockHeight, blockWidth/2, blockLength + archFudge])
                rotate([90 + archAngle, 0, 0])
                    linear_extrude(height=2*blockWidth+1, center=true)
                        resize([2*blockHeight, 2*(blockLength-blockDepth)])
                            circle();

            // Cut out rectangle with keys
            translate([blockHeight/2 + topThickness,
                       (blockWidth + keyWidth/2)/2,
                       blockLength/2])
                    cube([blockHeight,
                          blockWidth - keyWidth - keyWidth/2,
                          blockLength + 10], center=true);

            // Slice angle off bottom of feet
            translate([blockHeight, -.05, 0])
                rotate([0, -sliceAngle, 0])
                    cube([blockHeight, blockWidth + .1, blockLength + 1], center=false);

            // Add screw hole for reference location
            translate(fastener1)
                screwHole();

            // Add holes for solder bumps
            if (side == "right") {
                // Keys
                for (location = rightKeys) {
                    translate([0, -(location.y - rightReference.y), (location.x - rightReference.x)])
                        rotate([-location[2],0,0])
                        keySolderBumps(side);
                }
                // Diodes
                for (location = rightDiodes) {
                    translate([0, -(location.y - rightReference.y), (location.x - rightReference.x)])
                        rotate([-location[2],0,0])
                        diodeSolderBumps();
                }
                // Switch
                translate([0, -(143.0 - rightReference.y), (98.0 - rightReference.x)])
                    rotate([-23,0,0])
                        cube([3,7,9], center=true);
                // Reset button
                translate([0, -(138.1 - rightReference.y), (113.5 - rightReference.x)])
                    rotate([-12.3,0,0])
                        cube([3,5,11.4], center = true);

                // Add second screw hole
                translate([-.1, blockWidth - 16.5, 40])
                    screwHole();
                translate([-.1, -(82.3 - rightReference.y), (144.1 - rightReference.x)])
                    screwHole();
                translate([-.1, -(137.7 - rightReference.y), (148.7 - rightReference.x)])
                    screwHole();
            }
            else {  // Left side
                // Keys
                for (location = leftKeys) {
                    translate([0, -(location.y - leftReference.y), -(location.x - leftReference.x)])
                        rotate([-location[2],180,0])
                        keySolderBumps(side);
                }
                // Diodes
                for (location = leftDiodes) {
                    translate([0, -(location.y - leftReference.y), -(location.x - leftReference.x)])
                        rotate([180+location[2],0,0])
                        diodeSolderBumps();
                }

                // Add second screw hole
                translate([-.1, -(83.3 - leftReference.y), -(225.1 - leftReference.x)])
                    screwHole();
            }

            // Slice off end of long tail (min thickness ~= .67mm
            translate([-.05, -.05, blockLength-13])
                cube([2, blockWidth+.1, 16]);

            // Cut out slot for clip
            translate([0, 39, blockLength - 14])
                cube([10, 12, 30], center=true);

            // Cut out curve on bottom edge
            translate([0, -(214.73 - leftReference.y), -(236.07 - leftReference.x)])
                rotate([0, 90, 0])
                linear_extrude(height=2*blockHeight+1, center=true)
                circle(r=74.25);

            // Cut all other curves
            difference() {
                translate([-.1, -.1, 50])
                    cube([blockHeight+.2, blockWidth + .2, blockLength + .2], center=false);
                translate([0, -(161.51 - leftReference.y), -(242.04 - leftReference.x)])
                    rotate([0,90,0])
                        linear_extrude(height=2*blockHeight + .8, center=true)
                            circle(r=89.44);
            }

        }

        // Add string connector
        translate([stringHoleThickness/2 + topThickness,
                blockWidth*.6,
                stringHolderLength/2 - stringHoleRadius])
            stringConnector();

    }
}


// right side
thumbCluster("right");
// left side
/* translate([0,20,0]) thumbCluster("left"); */
