$fn=360;
eps=0.01;
m2_thrd=1.98/2;
m2_hole=2.60/2;
m25_thrd=2.46/2;
m25_hole=3.06/2;
p815_thrd=3.70/2;
p815_hole=4.10/2;
p815_head=11.20/2;
p815_deep=13.50;

// wall dims
wall_high=30;
wall_wide=25;
wall_thick=4.0;
wall_bev=(sqrt(wall_thick*wall_thick*2));

// corner flange dims
cf_wide=14;
cf_head_deep=2.20;
cf_hole_thick=2.60;
cf_thrd_thick=1+p815_deep-cf_hole_thick;
cf_offset=2.70;

cf_list=[0];

// Debug junction
translate([-0.0, wall_high-0, 0]) rotate([180, 270, 0]) {
//    color("darkgrey") import("case-corner-test.stl");
}

// translate([4, 0, 4]) cube(17);

difference() {
    union() {
        // wall base
        cube([wall_wide, wall_high, wall_thick]);
                
        // corner flanges
        for (y=cf_list) {
            // screw threads flange
            translate([wall_thick+cf_offset, y, wall_thick]) cube([cf_wide, cf_wide, cf_thrd_thick]);
            // screw hole flange
            translate([wall_thick+cf_thrd_thick, y+cf_wide+1, wall_thick]) 
                cube([cf_hole_thick+cf_head_deep, cf_wide, cf_wide+cf_offset]);
            // supports
            translate([wall_thick+cf_thrd_thick, y+cf_wide, wall_thick])
                cube([cf_wide-cf_thrd_thick+cf_offset, 1, cf_thrd_thick]);
            translate([wall_thick+cf_thrd_thick, y+cf_wide*2+1, wall_thick])
                cube([cf_wide-cf_thrd_thick+cf_offset, 1, cf_thrd_thick]);
            translate([wall_thick+cf_thrd_thick+cf_hole_thick+cf_head_deep, y+cf_wide+1, wall_thick])
                rotate([270, 0, 0]) cylinder(cf_wide, wall_thick, wall_thick, $fn=4);
        }
    }
    
    // bevel corner
    translate([0, -eps, wall_thick]) rotate([270, 0, 0]) cylinder(99, wall_thick, wall_thick, $fn=4);
    
    // corner flange holes
    for (y=cf_list) {
        // screw threads
        translate([wall_thick+cf_offset+cf_wide/2, y+cf_wide/2+1, wall_thick])
            cylinder(p815_deep, p815_thrd, p815_thrd);
        translate([wall_thick+cf_offset+cf_wide/2, y+cf_wide/2+1, wall_thick+cf_thrd_thick-1])
            cylinder(1.2, p815_thrd, p815_thrd+0.4);
        // screw hole and head
        translate([wall_thick+cf_thrd_thick-eps, y+cf_wide+1+cf_wide/2, wall_thick+cf_wide/2+cf_offset]) 
            rotate([0, 90, 0]) cylinder(cf_hole_thick+cf_head_deep+eps*2, p815_hole, p815_hole);
        translate([wall_thick+cf_thrd_thick+cf_hole_thick, y+cf_wide+1+cf_wide/2, wall_thick+cf_wide/2+cf_offset])
            rotate([0, 90, 0]) cylinder(cf_head_deep+wall_bev, p815_head, p815_head);
    }
    
    // Debug
    //translate([-100, -100, -eps]) cube([114, 109, 999]);
}
