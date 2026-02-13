$fn=360;
eps=0.01;
m2_thrd=1.98/2;
m2_hole=2.60/2;
m25_thrd=2.46/2;
m25_hole=3.06/2;
m25_head=4.60/2;
p815_thrd=3.70/2;
p815_hole=4.10/2;
p815_head=11.20/2;
p815_deep=13.50;

// wall dims
wall_high=19.125;
wall_wide=292;
wall_thick=4.0;
wall_bev=(sqrt(wall_thick*wall_thick*2));

// back wall tabs
bw_wide=12;
bw_high=10;
bw_thick=2;
bw_x=[26-12, 68-12, 110-12, 164+18, 206+18, 248+18];

// Debug vents
//for (x=[11:6:281]) {
//    color("black") translate([x-0.9, 0.4, 0]) linear_extrude(4) text(str((x-11)/6), size=1.5, 
//            font="Routed Gothic:style=Regular");
//}

// Debug stop
translate([175, 14.5, 4]) rotate([60, 0, 0]) translate([0, 10, 0]) rotate([0, 0, 180]) {
    include<case-top-stop.scad>;
}
// translate([-33, 184.08, 6])
difference() {
    union() {
        cube([wall_wide, wall_high, wall_thick]);
        
        // tabs for back screws
        for (x=bw_x) {
            translate([x, 14.506, wall_thick]) rotate([-30, 0, 0]) cube([bw_wide, bw_thick, bw_high]);
        }
    }

    // bevel corners
    // left side
    translate([0, -eps, wall_thick]) rotate([270, 0, 0]) cylinder(999, wall_thick, wall_thick, $fn=4);
    translate([wall_wide, -eps, wall_thick]) rotate([270, 0, 0]) cylinder(999, wall_thick, wall_thick, $fn=4);
    // top
    translate([-eps, wall_high, 0]) rotate([30, 0, 0]) cube([999, 4, 4.619]);

    // back wall tab screws
    for (x=bw_x) {
        translate([x+bw_wide/2, 14.506, wall_thick+bw_high/2]) rotate([240, 0, 0])
            cylinder(99, m25_hole, m25_hole);
    }

    // vents
    for (x=[11:6:281]) {
        translate([x, 5, -eps]) linear_extrude(wall_thick+eps*2) hull() {
            circle(1.5);
            translate([0, 8, 0]) circle(1.5);
        }
//        translate([x-0.3, 0.9, 3.9]) linear_extrude(1) text(str((x-11)/6), size=2, 
//                font="Routed Gothic:style=Regular");
    }
        
    // Debug
    //translate([-100, -100, -eps]) cube([114, 109, 999]);
}
