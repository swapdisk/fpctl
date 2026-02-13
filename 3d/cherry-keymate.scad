$fn=180;
eps=0.01;

// Params Cherry mate
cherry_thick1=1.16;
cherry_thick2=1.40;
cherry_wide=4.00;
cherry_high=3.90;
shaft_high=15.74;  // 6.60;
shaft_wide=6.80;
shaft_deep=5.20;
fudge_high=0.30;
fudge_plus=0.20;

// Params C2 mate
c2_wide=3.90;
base_high=0.8;
spline_high=3.90;
spline_t=1.2;

// Cherry mate
difference() {
    // cherry base
    union() {
        include <cherry-female.scad>;
    }
    // registration nubs
    translate([3.4, 0, -eps]) cylinder(1.3, 0.8, 0.8);
    translate([3.4, 0, -eps]) cylinder(0.3, 1.2, 1.2);
    translate([-3.4, 0, -eps]) cylinder(1.3, 0.8, 0.8);
    translate([-3.4, 0, -eps]) cylinder(0.3, 1.2, 1.2);
    
    // debug
    //translate([0, 0, -0.01]) cube(99);
}

// post
intersection() {
    translate([-shaft_wide/2, -shaft_deep/2, 4.2]) cube([shaft_wide, shaft_deep, shaft_high-4.2]);
    translate([0, 0, 4.2]) cylinder(shaft_high-4.2, 3, 3);
}
//translate([0, 0, 4.2]) cylinder(shaft_high-4.2, 4, 4);

// C2 mate
for (i = [30, 150, 270]) {
    translate([0, 0, shaft_high+spline_high/2]) rotate([0, 0, i]) {
        cube([c2_wide, spline_t, spline_high], center=true); 
    } 
}
