$fn=360;
eps=0.01;
m2_thrd=1.98/2;
m2_hole=2.60/2;
m25_thrd=2.46/2;
m25_hole=3.06/2;
m25_head=4.60/2;

m25h_holes=[[2.75, 2.75],
            [43.25, 2.75],
//            [2.75, 31.5-2.75],
//            [2.75, 31.5-2.75+2.75++1.5+2.75],
//            [3.75, 31.5-2.75+2.75++1.5+10.755],
//            [3.75, 31.5-2.75+2.75++1.5+47.895],
            [2.75, 31.5-2.75+2.75++1.5+75.25],
            [43.25, 31.5-2.75+2.75++1.5+75.25],
            [3.75, 89.5],
            [3.75, 24.5]
            
];

hinge_offset=6;
hinge_swing_rad=30;
hinge_wide=32;
hinge_thick=10;
hinge_col_rad=8.50/2;
hinge_pin_rad=4.60/2;

// Debug hinge pin
// color("silver") translate([6, 24, 0]) cylinder(32+24.5, hinge_pin_rad-0.21, hinge_pin_rad-0.21);

//projection() {
union() {

// Debug card window panel
translate([-0.7, -16.5, 281]) rotate([180, 90, 0]) {
    color("lightgrey") translate([0, -18-28-0.5, -1.3]) {
        include<blank-panel-b.scad>;
    }
    translate([0, -18-28-0.5, 3.4]) rotate([180, 0, 0]) {
        include<blank-panel-b-face.scad>;
    }
}
// Debug front panel
color("lightgrey") translate([49.9, 35.5, -1.5-4]) rotate([180, 270, 270]) {
    include<case-front-panel-right.scad>;
}
translate([49.9, 35.5, 142-1.5-4+0.5]) rotate([180, 270, 270]) {
    include<case-front-panel-left.scad>;
}
//translate([0, 0, 281]) rotate([180, 0, 0]) {
//    include<hinge-left.scad>;
//}


// Debug panel rotation
//translate([-4.1, -30-1.5, 0]) color("grey") cube([4.7, 30, 30]);
//translate([6, 24, 0]) rotate([0, 0, -90]) translate([-6, -24, 0])

mirror([0, 1, 0]) difference() {
    union() {
//        // Debug flaps frame and blank panel
//        mirror ([0, 1, 0]) color("lightgrey") translate([4.7, -16.5, 95.6]) rotate([180, 90, 0]) {
//           include<joiner-flaps-warn.scad>;
//       }
//       mirror ([0, 1, 0]) color("lightgrey") translate([-3.4, 0, 143.1]) rotate([180, 90, 180]) {
//           include<blank-panel-a.scad>;
//        }
        
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
            translate([-2, 5.9, 0]) square(2);
            translate([-9, 0, 0]) square(2);
            translate([-9, 5.9, 0]) square(2);
        }    
        translate([0, 0, 9]) cube([hinge_offset, 7.9, hinge_wide+5]);
        
        // mounting joiner flaps area
        translate([6, 15, 0]) cube([6, 7, hinge_wide]); 
        translate([6, 15+7, 0]) cube([6, 60, hinge_wide]); 
        translate([4.7, 15+7, 0]) cube([7.3, 60, 8]); 
        translate([6, 15+7+60, 0]) cube([6, 5, hinge_wide]); 
        translate([6, 15+7+60+5, 0]) cube([6, 9, hinge_wide]); 
        translate([4.7, 15+7+60+5, 0]) cube([7.3, 9, 8]); 
        translate([6, 15+7+60+5+9, 0]) cube([6, 9.5, hinge_wide]); 
        translate([6, 15+7+60+5+9+7, 0]) cube([6, 2.5, hinge_wide+14]); 
        
        // mounting joiner lower-upper area
//        translate([0, 39+47, 0]) cube([6.3, 16, 8.5]);
        translate([3.3, 39+47+17, 0]) cube([3.0, 15, hinge_wide+14]);
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
        translate([-h[0], h[1], 6.3]) cylinder(6, m25_head, m25_head);
    }
}

} //projection

//translate([0, 0, 0]) rotate([0, 90, 0]) cylinder(99, 2, 2);
