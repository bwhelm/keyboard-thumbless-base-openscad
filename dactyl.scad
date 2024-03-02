$fn=90;
switchHoleSide = 14.5; // size of square hole in mm
switchClipSide = 13.8; // size of square hole in mm
switchClipDepth = 1.3; // thickness of clips on switches
switchHoleDepth = 2.2; // depth of switch hole
keyHeight = 18;        // space devoted to each key
keyWidth = 19;
keyDepth = 5;
keyFromTop = 3;        // distance of key from top of block
keyFromBottom = 1;     // distance of key from bottom of block

blockWidth = 70;       // total width of block (23 for just the keys)
blockLength = 80;      // length of block in contact with keyboard
blockDepth = 5;        // depth of block
topThickness = 4;      // thickness of top

screwDiameter = 2;     // diameter of screws
screwLength = 6;       // length of screw shaft
pcbThickness = 1.6;    // thickness of PCB
nutThickness = 1.3;    // thickness of nut
screwHeadDiameter = 6; // diameter of nut, point to point

keyboardLength = 102;  // length of keyboard to front surface of thumb

stringHoleRadius = 2;     // radius of hole for string
stringHoleThickness = 5;  // thickness of string holder
stringHolderLength = 10;  // length of string holder attached to top

// Calculated constants
blockHeight = keyHeight*2 + keyFromTop + keyFromBottom;  // total height of block
sliceAngle = 90 - atan2(keyboardLength, blockHeight);  // angle at which to slice off bottom of feet

module keyhole() {
    // total block
    /* difference(){ */
    /*     cube([keyHeight, keyWidth, keyDepth], center=true); */
        // Key clip
        translate([0, 0, keyDepth/2 - switchClipDepth/2])
            cube([switchClipSide, switchClipSide, switchClipDepth+.01],center=true);
        // Key body hole
        translate([0,
                0,
                keyDepth/2 - switchClipDepth/2 - switchHoleDepth/2])
            cube([switchHoleSide, switchHoleSide, switchHoleDepth],center=true);
        // holes for tabs
        translate([0,
                0,
                0])
            cylinder(h=11,r=1.7,center=true);
        translate([0,
                5.5,
                0])
            cylinder(h=11,r=.95,center=true);
        translate([0,
                -5.5,
                0])
            cylinder(h=11,r=.95,center=true);
        // holes for pins/wires
        translate([5.9,
                0,
                0])
            cylinder(h=100,r=1.5,center=true);
        translate([3.8,
                5,
                0])
            cylinder(h=100,r=1.5,center=true);
/* } */
}

module screwHole() {
    rotate([0,90,0]){
        // screw shaft
        cylinder(h=blockHeight + .1, d=screwDiameter, center=false);
        // screw head
        translate([0,0,screwLength - pcbThickness - nutThickness - 1])
            cylinder(h=blockHeight + .1, d=screwHeadDiameter, center=false);
    }
}

module stringConnector() {
    difference(){
        union(){
            cube([stringHoleThickness, stringHoleRadius*4, stringHolderLength+2*stringHoleRadius + 0], center=true);
            translate([0, 0, -stringHolderLength/2 - stringHoleRadius])
                rotate([0,90,0])
                cylinder(h=stringHoleThickness, r=2*stringHoleRadius, center=true);
        }
        translate([0, 0, -stringHolderLength/2 - stringHoleRadius])
                rotate([0,90,0])
                cylinder(h=stringHoleThickness + 1, r=stringHoleRadius, center=true);
    }
}

indexRadius = 60;
middleRadius = 66;
ringRadius = 64;
pinkyRadius = 52;
middleRotate = 0;
ringRotate = 0;
pinkyRotate = 0;
module finger(radius){
    /* t */
    alpha = 2*asin(keyHeight/2/radius);
        cylinder(h=keyWidth+.1,r=radius-2.2,center=true);
    translate([0, -radius, 0]){
        // Slice out arc
        rotate([-90,0,0]) {
        keyhole();}
        }
    translate([-radius*sin(alpha), -radius*cos(alpha), 0])
        rotate([-90,0,-alpha]) {keyhole();}
    translate([radius*sin(alpha), -radius*cos(alpha), 0])
        rotate([-90,0,alpha]) {keyhole();}
}

difference(){
    translate([0,-pinkyRadius,keyWidth])
        cube([60,53,5*keyWidth - .1],center=true);
    translate([0,0,-keyWidth])
        finger(indexRadius);
    finger(indexRadius);
    translate([0,0,keyWidth])
        rotate([0,middleRotate,0])
        finger(middleRadius);
    translate([0,0,2*keyWidth])
        rotate([0,ringRotate,0])
        finger(ringRadius);
    translate([0,0,3*keyWidth])
        rotate([0,pinkyRotate,0])
        finger(pinkyRadius);
    translate([0,-pinkyRadius-31,keyWidth])
        rotate([90,0,90])
        linear_extrude(height=60+1,center=true)
            resize([30, 5*keyWidth])
                circle(d=10);
}

module thumbCluster(side) {
    factor = (side=="left") ? -1 : 1;
    left = (side=="left") ? 1 : 0;
    translate([(blockHeight + 10) * left, 0,0])
    {
        difference(){
            // Main block
            cube([blockHeight,blockWidth,blockLength]);

            // Top key hole
            translate([keyFromTop + (keyHeight)/2,
                    left * blockWidth + factor * (keyWidth)/2,
                    0])
                keyhole();

            // Bottom key hole
            translate([keyFromTop + (keyHeight)/2 + keyHeight,
                    left * blockWidth + factor * (keyWidth)/2,
                    0])
                keyhole();

            // Cut out arch behind keys (extruding oval of correct size)
            translate([blockHeight,
                        blockWidth/2,
                        blockLength])  // FIXME: why this fudge factor?
                rotate([90,0,0])
                    linear_extrude(height=blockWidth+1,center=true)
                        resize([2*blockHeight, 2*(blockLength-blockDepth)])
                            circle(d=10);

            // Cut out rectangle with keys
            translate([blockHeight/2 + topThickness,
                        (blockWidth + factor * keyWidth/2)/2,
                        blockLength/2])
                    cube([blockHeight,
                          blockWidth - keyWidth - keyWidth/2,
                          blockLength + .1],center=true);

            // Slice angle off bottom of feet
            translate([blockHeight,
                        -.05,
                        0])
                rotate([0,-sliceAngle,0])
                    cube([5,blockWidth + .1,blockDepth + 1],center=false);

            // Add screw holes
            translate([-.1,
                        (1-left) * blockWidth - factor*16,
                        40])
                screwHole();
            translate([-.1,
                        (1-left) * blockWidth - factor*(16+50),
                        40-29.47])
                screwHole();

            // Slice off end of long tail (min thickness ~= .67mm
            translate([-.05,-.05,blockLength-13])
                cube([2,blockWidth+.1,16]);

        }

        // Add string connector
        translate([stringHoleThickness/2 + topThickness,
                   blockWidth/2,
                   stringHolderLength/2 - stringHoleRadius])
            stringConnector();
    }
}


/* thumbCluster("right"); */
/* thumbCluster("left"); */
