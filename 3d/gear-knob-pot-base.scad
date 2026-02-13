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
//pnc_high=6.25+1.08-3.16;
pnc_high=3.68;

// Pot shaft
shaft_rad=3.06;
flat_thick=1.48;
shaft_deg=30;
head_rad=4.60/2;

// Screw holes
screw_ir=2.46/2;
screw_deep=5;
screw_z=pb_rad+box_tall-3-4;
hole_ir=2.86/2;

// Post dims
p_high=box_tall+1;
p_rad=4.20/2;
glue_high=1.20;
glue_rad=p_rad+0.90;

// Handle dims
handle_wide=7;
handle_tall=9;
handle_long=20;
handle_wc=11;

color("grey", 1) translate([-5.31, 0, 31.0]) rotate([90, 180, 90]) {
    include <gear-lever-wheel.scad>;
}
color("grey") translate([5.75, 0, 31.0]) rotate([270, 0, 90]) {
    include <gear-lever-wheel.scad>;
}

// Handle
difference() {
    union() {
        color("lightgrey") translate([box_wide/2-handle_wide, -handle_tall/2, -p_high]) 
            cube([handle_wide, handle_tall, p_high+eps]); 
        color("lightgrey") translate([box_wide/2-handle_wide+1, -handle_tall/2, 0])
            cube([handle_wide-2, handle_tall, handle_long]);
        color("lightgrey") translate([box_wide/2-handle_wide, -handle_tall/2, handle_long]) 
            cube([handle_wide, handle_tall, handle_wc]);
        color("lightgrey") translate([box_wide/2-handle_wide, 0, handle_long+handle_wc]) 
            rotate([0, 90, 0]) cylinder(handle_wide, handle_tall/2, handle_tall/2);
        // sloped bit
        color("lightgrey") translate([box_wide/2-handle_wide, -handle_tall/2, handle_long]) 
            rotate([0, 60, 0]) cube([3, handle_tall, 1]);
        color("lightgrey") translate([box_wide/2, -handle_tall/2, handle_long]) 
            rotate([0, 210, 0]) cube([1, handle_tall, 3]);
    }
    // screw holes
    translate([-pb_high+box_wide/2, 0, -pb_rad-box_tall+screw_z]) rotate([0, 90, 0])
        cylinder(screw_deep+4, screw_ir, screw_ir);
    translate([-pb_high+box_wide/2, 0, -pb_rad-box_tall+screw_z+5]) rotate([0, 90, 0])
        cylinder(screw_deep+4, screw_ir, screw_ir);
}
    
// Pot knob
translate([-pb_high+box_wide/2, 0, -pb_rad-box_tall]) difference() {
    // Main body
    union() {
        // base cylinder
        rotate([0, 90, 0]) cylinder(pb_high, pb_rad, pb_rad);
        // handle mounting stem
        translate([pb_high-box_high, -box_wide/2, 0]) cube([box_high, box_wide, pb_rad+box_tall]);
    }
    // Subtract handle
    translate([pb_high-handle_wide+eps, -handle_tall/2, pb_rad+box_tall-p_high+eps]) 
        cube([handle_wide, handle_tall, p_high]);
    // Mounting holes
    translate([-eps, 0, screw_z]) rotate([0, 90, 0]) 
        cylinder(screw_deep, hole_ir, hole_ir);
    translate([-eps, 0, screw_z+5]) rotate([0, 90, 0])
        cylinder(screw_deep, hole_ir, hole_ir);
    // Pot shaft hole
    translate([-eps, 0, 0]) rotate([0, 90, 0]) cylinder(99, shaft_rad, shaft_rad);
    // Set screw
    translate([(pb_high-pnc_high)/2, 0, 0]) rotate([shaft_deg-90, 0, 0]) {
        translate([0, 0, flat_thick]) cylinder(pb_rad, screw_ir, screw_ir);
        translate([0, 0, flat_thick+6]) cylinder(pb_rad, head_rad, head_rad);
    }
    // Pot nut cavity
    translate([pb_high-pnc_high, 0, 0]) rotate([0, 90, 0]) cylinder(99, pnc_rad, pnc_rad);
    // Post hole
    translate([pb_high-box_wide/2, 0, pb_rad+box_tall-p_high+eps]) {
        cylinder(p_high, p_rad, p_rad);
        translate([0, 0, p_high-glue_high]) cylinder(glue_high, p_rad, glue_rad);
    }

    // Debug
    //translate([+pb_high-box_wide+0.5, 0, -49]) cube(99);
}

// Pot shaft flat bit
difference() {
    translate([-pb_high+box_wide/2, 0, -pb_rad-box_tall])
        rotate([shaft_deg, 0, 0])
            translate([0, shaft_rad-flat_thick, -shaft_rad]) 
                cube([pb_high-pnc_high, flat_thick, shaft_rad*2]);
    // Set screw again
    translate([(pb_high-pnc_high)/2-pb_high+box_wide/2, 0, -pb_rad-box_tall]) 
        rotate([shaft_deg-90, 0, 0])
            translate([0, 0, flat_thick]) cylinder(pb_rad, screw_ir, screw_ir);
}

// Debug
//include <flaps-knob-pull-collar.scad>;

echo(-pb_rad-box_tall, pnc_high);
