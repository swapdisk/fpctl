$fn=360;
eps=0.01;
m2_thrd=1.98/2;
m2_hole=2.60/2;
m25_thrd=2.46/2;
m25_hole=3.06/2;

m25h_holes=[[2.75, 2.75],
            [2.75, 31.5-2.75],
            [2.75, 31.5-2.75+2.75++1.5+2.75],
            [3.75, 31.5-2.75+2.75++1.5+10.755],
            [3.75, 31.5-2.75+2.75++1.5+47.895],
            [2.75, 31.5-2.75+2.75++1.5+75.25],
            
];

hinge_offset=6;
hinge_swing_rad=30;
hinge_wide=32;
hinge_thick=10;
hinge_col_rad=8.50/2;
hinge_pin_rad=4.60/2;

// Debug hinge pin
//color("silver") translate([6, -24, 0]) cylinder(33, hinge_pin_rad-0.1, hinge_pin_rad-0.1);

// Debug card window panel
translate([-0.7, 16.5, 0]) rotate([0, 270, 0]) {
    color("lightgrey") translate([0, -18-28-0.5, -1.3]) {
        include<blank-panel-b.scad>;
    }
    translate([0, -18-28-0.5, 3.4]) rotate([180, 0, 0]) {
        include<blank-panel-b-face.scad>;
    }
}

// Debug panel rotation
//translate([-4.1, -30-1.5, 0]) color("grey") cube([4.7, 30, 30]);
//translate([6, -24, 0]) rotate([0, 0, 17]) translate([-6, 24, 0])

difference() {
    union() {
        // Debug real panel
        color("lightgrey") translate([-0.7, 16.5, 0]) rotate([-20, 270, 0]) {
//            import("main-mockup.stl");
        }
        
        // hinge
        translate([hinge_offset, -24, 0]) {
            // swing arm
            rotate_extrude(90) translate([hinge_swing_rad, 0, 0]) square([hinge_thick, hinge_wide]);
            // hinge collar
            cylinder(hinge_wide, hinge_col_rad, hinge_col_rad);
            // hinge plate
            cube([hinge_swing_rad, hinge_col_rad, hinge_wide]);
            translate([0, -hinge_col_rad, 0]) cube([hinge_swing_rad+hinge_thick, hinge_col_rad, hinge_wide]);
        }
        
        // mounting joiner hinge area
        rotate([0, 90, 0]) linear_extrude(hinge_offset) hull() {
            translate([-2, 2, 0]) circle(2, $fn=4);
            translate([-2, 37, 0]) square(2);
            translate([-8.5, 0, 0]) square(2);
            translate([-8.5, 37, 0]) square(2);
        }    
        translate([0, 0, 5]) cube([hinge_offset, 28, hinge_wide-5]);
        
        // mounting joiner joystick area
        translate([0, 39, 0]) cube([3.0, 10, 8.5]);
        translate([0, 39+10, 0]) cube([6.3, 27, 8.5]);
        translate([0, 39+10+27, 0]) cube([3.0, 10, 8.5]);      
        translate([0, 39, 0]) cube([6.3, 47, 0.7]);
        translate([0, 39-0.7, 0]) cube([6.3, 0.7, 8.5]);
        
        // mounting joiner lower-upper area
        translate([0, 39+47, 0]) cube([6.3, 16, 8.5]);
        translate([3.3, 39+47+16, 0]) cube([3.0, 15, 8.5]);
    }
    
    // hinge pin
    translate([6, -24, -eps]) cylinder(99, hinge_pin_rad, hinge_pin_rad);

    // carve panel clearance
    //rotate([0, 0, -80]) translate([-0.4, 0, 0]) cube([9, 9, 99]);
    translate([3, 0, -eps]) cube([4+eps, 6, 99]);
    translate([-eps, -eps, -eps]) cube([9, 0.6, 99]);
    
    // screw holes
    rotate([0, 90, 0]) for (h=m25h_holes) {
        translate([-h[0], h[1], -eps]) cylinder(9, m25_hole, m25_hole);
    }
}

//translate([0, 0, 0]) rotate([0, 90, 0]) cylinder(99, 2, 2);
