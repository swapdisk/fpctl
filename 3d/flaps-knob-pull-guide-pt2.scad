$fn=180;
eps=0.01;

// Collar dims
collar_rad=7.40/2;

// Detent guide dims
guide_z=19.38;
guide_thick=4.70;
guide_tall=14.21-1;
guide_rad=38-18.5+1;
//
//guide_tall=16.21;
//guide_rad=38-16;
guide_deg=30;
notch_thick=guide_thick+4.10;
notch_tall=99;
notch_rad=49.01-20.5;

notch_deg=6.50;

// Screw hole
hole_x=notch_rad+2.79;
hole_rad=2.20/2;

//sup_wide=23.29;
//sup_tall=1.23;

translate([0, 0, -guide_z]) rotate([0, 90, 0]) difference() {
    union() {
        //translate([-guide_rad-guide_wide, -sup_wide/2, 0]) cube([sup_tall, sup_wide, 14]);
        //cylinder(guide_thick, guide_rad+guide_wide, guide_rad+guide_wide);
        // Guide
        rotate([0, 0, 180-guide_deg/2])
            rotate_extrude(angle=guide_deg)
                translate([guide_rad, 0, 0])
                    square([guide_tall, guide_thick]);
    }
    // Notch
    rotate([0, 0, 180-notch_deg/2]) 
        rotate_extrude(angle=notch_deg)
            translate([notch_rad, guide_thick/2, 0])
                square([notch_tall, notch_thick]);
    //rotate([0, -90, 0]) cylinder(99, collar_rad, collar_rad);
    translate([-hole_x, 0, -eps]) cylinder(99, hole_rad, hole_rad);
    
    // Debug
    //translate([-49, 0, 0]) cube(99);
}

// Debug
//translate([14, 0, 0]) rotate([0, 0, 180]) {
//    include<flaps-knob-pull-guide.scad>;
//}
