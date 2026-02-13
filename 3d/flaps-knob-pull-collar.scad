$fn=360;
eps=0.01;

// Collar dims
col_or=7.30/2;
col_ir=4.60/2;
col_len=65-5.6-4;

// Spring screw hole
ss_ir=2.46/2;
ss_deep=5;
ss_z=18.5;

// Guide screw hole
gs_ir=1.98/2;
gs_deep=5;
gs_z=11.92;

// Detent tab dims
tab_high=8;
tab_long=7;
tab_wide=1.50;
tab_z=20.83;

// Flat bit
fb_z=41.40;
fb_deep=0.65;

difference() { 
    // collar body
    union() {
        cylinder(col_len, col_or, col_or);
        // Dimple for screw hole
        translate([-col_or+1, 0, ss_z]) rotate([180, 90, 0]) cylinder(3.7, col_or, ss_ir+0.5);
        translate([0, 0, ss_z]) rotate([180, 90, 0]) cylinder(col_or-1, col_or, col_or);
        // Dimple for guide screw
        translate([col_or-1.7, 0, gs_z]) rotate([0, 90, 0]) cylinder(3.3, 2.4, gs_ir+0.2);
    }
    // Shaft hole
    translate([0, 0, -eps]) cylinder(99, col_ir, col_ir);
    // Screw hole for spring
    translate([0, 0, ss_z]) rotate([180, 90, 0]) cylinder(99, ss_ir, ss_ir);
    // screw hole for guide
    translate([0, 0, gs_z]) rotate([0, 90, 0]) cylinder(99, gs_ir, gs_ir);
    // flat bit
    translate([-49, col_or-fb_deep, fb_z]) cube(99);
}

//// Detent tab
//translate([col_ir, -tab_wide/2, tab_z]) difference() {
//    cube([tab_long, tab_wide, tab_high]);
//    translate([tab_long, -eps, 2]) rotate([0, -44, 0]) cube(9);
//}

// Debug
//union() {
//    include <flaps-knob-pull-guide.scad>;
//}
