$fn=360;
eps=0.01;

dome_thick=1.00;
dome_rad=18.885+0.5;
dome_y=3.00;
jsa_xy=1.00;
jsa_rad=0.20/2;
bez_xy=37.00;
bez_rad=5.00/2;
bez_wide=2.50;
bez_high=13.00;
bez_thick=3.50;
bez_cone=24.00;

// Alignment tabs
at_rad=1.80;
at_high=1.80;
at_pos=14.24;

difference() {
    union() {
        // outer dome
        translate([0, 0, -dome_y]) sphere(dome_rad+dome_thick);
        // alignment tabs
        translate([at_pos, at_pos, -eps]) cylinder(at_high, at_rad, at_rad);
        translate([at_pos, -at_pos, -eps]) cylinder(at_high, at_rad, at_rad);
        translate([-at_pos, at_pos, -eps]) cylinder(at_high, at_rad, at_rad);
        translate([-at_pos, -at_pos, -eps]) cylinder(at_high, at_rad, at_rad);
    }
    // subtract below bezel
    translate([-49, -bez_xy/2-99, -eps]) cube([99, 99, bez_high-bez_thick]);
    translate([-bez_xy/2-99, -49, -eps]) cube([99, 99, bez_high-bez_thick]);
    translate([-49, bez_xy/2, -eps]) cube([99, 99, bez_high-bez_thick]);
    translate([bez_xy/2, -49, -eps]) cube([99, 99, bez_high-bez_thick]);
    
    // subtract inner sphere
    translate([0, 0, -dome_y]) sphere(dome_rad);

    // subtract bottom
    translate([-49, -49, -99]) cube(99);
    
    // subtract joystick aperature
    translate([0, 0, -dome_y]) 
        linear_extrude(height=dome_rad+dome_thick, scale=26) hull() {
        translate([jsa_xy/2, jsa_xy/2, 0]) circle(jsa_rad);
        translate([-jsa_xy/2, jsa_xy/2, 0]) circle(jsa_rad);
        translate([jsa_xy/2, -jsa_xy/2, 0]) circle(jsa_rad);
        translate([-jsa_xy/2, -jsa_xy/2, 0]) circle(jsa_rad);
    }

    // Debug
    //translate([0, -99, -eps]) cube(99);
//    //rotate([0, 0, 45]) translate([0, -99, -eps]) cube(99);
}

// Debug aperature size
//o_xy=20.32;
//translate([-o_xy/2, -o_xy/2, 0]) cube([o_xy, o_xy, 20]);

// Debug test dome
//translate([0, 0, .645]) union() color("red") {
//    include <ex-sphere.scad>;
//}

// Debug bezel align
//union() color("blue") {
//    include <js-bezel.scad>;
//}