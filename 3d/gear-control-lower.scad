$fn=360;
eps=0.01;

// Gear panel
gp_high=72.00;
gp_wide=41.62;
gp_thick=3;
gp_base=1.2;

// Attachment
screw_x=24.41;
screw_y=25;
screw_rad=2.46/2;
screw_deep=gp_thick-0.5;
plate_thick=3.00;
el_thick=3.8;
el_holes_rad=3.06/2;

// pot mount dims
el_x=18.41;
el_y=18.82;
el_high=32.35;
el_wide=9;
ex_tall=22;
ex_rad=11.0;
pot_rad=7.00/2;
pot_reg_wide=2.00;
pot_reg_offset=pot_rad+3.40;

difference() {
    // pot mount el
    union() {
        translate([el_x, el_y, -el_thick]) cube([el_wide, el_high, el_thick]);
        translate([el_x, el_y+el_high/2, -ex_tall]) 
        rotate([0, 90, 0]) linear_extrude(plate_thick) hull() {
            translate([-ex_tall, el_high/2, 0]) circle(eps);
            translate([-ex_tall, -el_high/2, 0]) circle(eps);
            circle(ex_rad);
        }
    }
    // screw holes
    for (y = [screw_y, gp_high-screw_y]) {
        translate([screw_x, y, -99+eps]) cylinder(99, el_holes_rad, el_holes_rad);
    }
    // stop pegs
    translate([0, 24.66, -12]) rotate([0, 90, 0]) cylinder(99, screw_rad, screw_rad);
    translate([0, 45.33, -12]) rotate([0, 90, 0]) cylinder(99, screw_rad, screw_rad);
    // potentiometer knockout and reg slot and not subtract thickness
    rotate([0, 90, 0]) translate([ex_tall, el_y+el_high/2, 0]) {
        cylinder(99, pot_rad, pot_rad);
        rotate([0, 0, 45]) rotate_extrude(angle=60) translate([pot_reg_offset, 0, 0])
            square([pot_reg_wide, 99]);
    }
}

// Debug
//translate([32, 0, 0]) color("red", 0.5) cube(8.62+1);

// Debug
translate([13, el_y+el_high/2, -ex_tall]) rotate([-18, 0, 0]) translate([0, 0, 19.38]) {
    include <gear-knob-pot-base.scad>;
}

// Debug
//translate([-42, 30, -22]) rotate([0, 0, 90]) translate([0, 0, 19.38]) {
//    include <flaps-control-mockup.scad>;
//}
