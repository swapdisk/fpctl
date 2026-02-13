$fn=360;
eps=0.01;

// knob dims
extra_high=19.5;
shaft_extra_rad=9.2/2;
shaft_outside_rad=10.2/2;
shaft_inside_rad=3.08;
flange_thick=2;
shaft_high=22;
hole_high=13;
flat_thick=1.5;
knob_thick=8;
num_bumps=12;
bump_long=8.7;
bump_wide=4.1;
bump_rad=1.2;
total_high=knob_thick+shaft_high+extra_high;

// shaft
translate([0, 0, -total_high]) difference() {
    union() {
        // main shaft
        translate([0, 0, knob_thick]) {
            cylinder(extra_high+shaft_high, shaft_extra_rad, shaft_extra_rad);
            cylinder(shaft_high, shaft_outside_rad, shaft_outside_rad);
        }
        // knob
        for (i=[0:num_bumps-1]) {
            rotate([0, 0, i/num_bumps*360]) {
                translate([0, -bump_wide/2, 0]) 
                    cube([bump_long, bump_wide, knob_thick]);
                translate([0, -bump_wide/2+bump_rad, 0]) 
                    cube([bump_long+bump_rad, bump_wide-bump_rad-bump_rad, knob_thick]);
                translate([bump_long, -bump_wide/2+bump_rad, 0]) 
                    cylinder(knob_thick, bump_rad, bump_rad);
                translate([bump_long, bump_wide/2-bump_rad, 0]) 
                    cylinder(knob_thick, bump_rad, bump_rad);
            }
        }
        
        // debug flange
//        translate([0, 0, knob_thick+shaft_high]) {
//            include<knob-flange.scad>;
//        }
        // debug alt units ring
//        translate([0, 0, knob_thick+shaft_high+6.4]) rotate([180, 0, 0]) {
//            include<alt-units-knob-flange.scad>;
//        }
//        translate([0, 0, knob_thick+shaft_high+2]) rotate([180, 0, 0]) {
//            include<alt-units-knob-ring.scad>;
//        }
    }
    
    // control shaft
    translate([0, 0, total_high-hole_high+eps]) cylinder(hole_high, shaft_inside_rad, shaft_inside_rad);

    // debug
//    translate([0, 0, -1]) cube(99);
}

// flat bit
translate([-2.68, shaft_inside_rad-flat_thick, -hole_high]) cube([5.36, flat_thick, hole_high]); 

