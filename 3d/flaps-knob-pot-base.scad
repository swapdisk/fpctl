$fn=180;
eps=0.01;

// Pot base dims
pb_rad=11;
pb_high=10;
box_wide=7.40;
box_high=pb_high;
box_tall=8.38;

// Pot nut cavity
pnc_rad=pb_rad-2;
pnc_high=4.75;

// Pot shaft
shaft_rad=3.22;
flat_thick=0.90;

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
        translate([pb_high-box_high, -box_wide/2, 0]) cube([box_high, box_wide, pb_rad+box_tall]);
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

// Pot shaft flat bit
translate([-pb_high+box_wide/2, 0, -pb_rad-box_tall])
    rotate([240, 0, 0])
        translate([0, shaft_rad-flat_thick, -shaft_rad]) 
        cube([pb_high-pnc_high, flat_thick, shaft_rad*2]);

// Debug
//include <flaps-knob-pull-collar.scad>;

echo(-pb_rad-box_tall);
