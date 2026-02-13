$fn=180;
eps=0.01;

// Params Cherry post
c2_wide=3.90;
base_high=12.60;
spline_high=3.50;
spline_t1=1.10;
spline_t2=1.34;
f2_high=0.30;
f2_plus=0.40;

// Cherry mate
difference() {
    // cherry base
    union () {
        include <cherry-female.scad>;
    }
    // registration nubs
    translate([3.4, 0, -eps]) cylinder(1.3, 0.8, 0.8);
    translate([3.4, 0, -eps]) cylinder(0.3, 1.2, 1.2);
    translate([-3.4, 0, -eps]) cylinder(1.3, 0.8, 0.8);
    translate([-3.4, 0, -eps]) cylinder(0.3, 1.2, 1.2);
}

// Base
translate([0, 0, 5]) cylinder(base_high-5, 2.5, 2.5);

// Cherry post
translate([0, 0, base_high+spline_high/2]) {
    cube([c2_wide, spline_t2, spline_high], center=true);
    cube([spline_t1, c2_wide, spline_high], center=true);
    cube([c2_wide-f2_plus, spline_t2-f2_plus, spline_high+f2_high*2], center=true);
    cube([spline_t1-f2_plus, c2_wide-f2_plus, spline_high+f2_high*2], center=true);

} 
