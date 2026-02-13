$fn=120;
eps=0.01;

// Scale
sf=0.6;

// Chop bottom of stl
z_chop=73.00+eps;

// Center offset of stl
x_stl=42.00;

// Post dims
p2_high=7.00*sf+eps;
p2_rad=4.20/2;
glue2_high=0.70;
glue2_rad=p2_rad+0.70;

// Fill pin hole
pin_y=5;
pin_rad=1.27;
pin_wide=22;

// Set screw
set_head_rad=3.90/2;
set_head_high=1.30;
set_threads_rad=1.98/2;

difference() {
    union() {
        translate([x_stl*sf, 0, -z_chop*sf]) scale([sf, sf, sf]) {
            import("flaps-assembly-ma60-21-top-knob.stl");
        }
        // Fill pin hole
        rotate([90, 0, 0]) translate([0, -pin_y*sf, -pin_wide/2*sf]) 
            cylinder(pin_wide*sf, pin_rad*sf, pin_rad*sf); 
    }
    translate([-99, -99, -eps]) cube([199, 199, 99]);
    translate([0, 0, -glue2_high+eps]) cylinder(glue2_high, p2_rad, glue2_rad);
    translate([0, 0, -6-eps]) cylinder(99, p2_rad, p2_rad);

    // FIXME: make real set screw?
    rotate([90, 0, 180]) translate([0, -pin_y*sf, -pin_wide/2*sf]) {
        translate([0, 0, -1]) cylinder(set_head_high+1, set_head_rad, set_head_rad);
        cylinder(pin_wide/2*sf, set_threads_rad, set_threads_rad);
    }

    
    // Debug
    //translate([0, -49, -49]) cube([99, 99, 99]);
}

// Debug
//include <flaps-knob-top-scaled.scad>;
