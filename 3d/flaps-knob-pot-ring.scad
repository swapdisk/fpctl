$fn=360;
eps=0.01;

//difference() {
//    cylinder(8, 6, 6);
//    translate([0, 0, -eps]) cylinder(99, 3.05, 3.05);
//}
//
//for (n=[0:17]) {
//    rotate([0, 0, n/18*360]) translate([-3.67, 0, 0]) cylinder(8, 1, 1, $fn=3);
//}

// translate([20, 0, -19.38]) rotate([0, 270, 0]) cylinder(40, 0.1, 0.1);

// Pot base dims
pb_rad=9;
pb_high=8.5;
box_wide=7.40;
box_high=pb_high;
box_tall=10.38;

// Pot nut cavity
pnc_rad=pb_rad-2;
pnc_high=99; // 4.75;

// Pot shaft
shaft_rad=0.3; // 3.05;
shaft_col=0;
shaft_deep=26.40-1.88;  // 4.75 + something

// Screw holes
screw_ir=2.46/2;
screw_deep=5;
screw_z=pb_rad+box_tall-4.6;

// Post dims
p_high=box_tall+1;
p_rad=4.20/2;
glue_high=1.20;
glue_rad=p_rad+0.90;

translate([-pb_high+box_wide/2, 0, -pb_rad-box_tall]) difference() {
    // Main body
    union() {
        rotate([0, 90, 0]) cylinder(pb_high, pb_rad, pb_rad);
        translate([pb_high-box_high, -box_wide/2-2, 0]) cube([box_high, box_wide+4, pb_rad+box_tall]);
    }
    // Spring screw hole 
    translate([-eps, 0, screw_z]) rotate([0, 90, 0]) cylinder(screw_deep, screw_ir, screw_ir);
    // Pot shaft hole
    translate([-eps, 0, 0]) rotate([0, 90, 0]) cylinder(99, shaft_rad, shaft_rad);
    // Pot nut cavity
    translate([pb_high-pnc_high, 0, 0]) rotate([0, 90, 0]) cylinder(99, pnc_rad, pnc_rad);
    // Post hole
    translate([pb_high-box_wide/2, 0, pb_rad+box_tall-p_high+eps]) {
        cylinder(p_high, p_rad, p_rad);
        translate([0, 0, p_high-glue_high]) cylinder(glue_high, p_rad, glue_rad);
    }

    // Debug
    //translate([+pb_high-box_wide/2, 0, -49]) cube(99);
}

//// Pot shaft flat bit
//translate([-pb_high+box_wide/2, 0, -pb_rad-box_tall])
//    rotate([240, 0, 0])
//        translate([0, shaft_rad-flat_thick, -shaft_rad]) 
//        cube([pb_high-pnc_high, flat_thick, shaft_rad*2]);

// Debug
//include <flaps-knob-pull-collar.scad>;

echo(-pb_rad-box_tall);
