$fn=180;
eps=0.01;

// Collar dims
collar_rad=7.40/2;

// Detent guide dims
guide_z=19.38;
guide_thick=4.70;
guide_tall=14.21-1;
guide_rad=38-18.5+1;
guide_deg=30;
notch_thick=guide_thick+guide_thick/2+4.10;
notch_tall=5;
notch_rad=49.21-20.5;
notch_deg=6.30;

// Screw hole
screw_x=notch_rad+2.59;
screw_rad=2.20/2;
screw_deep=8;

translate([0, 0, -guide_z]) rotate([0, 90, 0]) difference() {
    union() {
        //translate([-guide_rad-guide_wide, -sup_wide/2, 0]) cube([sup_tall, sup_wide, 14]);
        //cylinder(guide_thick, guide_rad+guide_wide, guide_rad+guide_wide);
        // Notch
        rotate([0, 0, 180-notch_deg/2]) 
            rotate_extrude(angle=notch_deg)
                translate([notch_rad, 0, 0])
                    square([notch_tall, notch_thick]);
        // Guide
        rotate([0, 0, 180-guide_deg/2])
            rotate_extrude(angle=guide_deg)
                translate([guide_rad, 0, 0])
                    square([guide_tall, guide_thick]);
    }
    // collor channel
    rotate([0, -90, 0]) cylinder(99, collar_rad, collar_rad);
    // screw hole
    translate([-screw_x, 0, notch_thick-screw_deep]) cylinder(99, screw_rad, screw_rad);
    translate([-screw_x, 0, notch_thick-screw_deep-0.3]) cylinder(3, screw_rad+1.2, screw_rad);
    
    // Debug
    //translate([-49, 0, 0]) cube(99);
}

// Debug
//translate([13.6, 0, 0]) rotate([0, 0, 180]) {
//    include<flaps-knob-pull-guide-pt2.scad>;
//}
