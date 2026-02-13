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
wall_high=16;
wall_wide=18;
wall_thick=4.0;
wall_bev=(sqrt(wall_thick*wall_thick*2));

// corner flange dims
cf_wide=14;
cf_head_deep=2.20;
cf_hole_thick=2.60;
cf_thrd_thick=1+p815_deep-cf_hole_thick;
cf_offset=1.0;

cf_list=[2];

// Debug junction
translate([-0.0, wall_high-0, 0]) rotate([180, 270, 0]) {
    color("darkgrey") import("case-corner-mini.stl");
}

difference() {
    union() {
        // wall base
        cube([wall_wide, wall_high, wall_thick]);
                
        // corner flanges
        for (y=cf_list) {
            // screw flange
            translate([wall_thick+cf_offset+m25_head, y+6, m25_head]) rotate([90, 0, 0]) {
                linear_extrude(6) hull() {
                    circle(m25_head);
                    translate([0, wall_thick+cf_offset, 0]) circle(m25_head);
                }
            }
        }
    }
    
    // bevel corner
    translate([0, -eps, wall_thick]) rotate([270, 0, 0]) cylinder(99, wall_thick, wall_thick, $fn=4);
    
    // corner flange holes
    for (y=cf_list) {
        translate([wall_thick+cf_offset+m25_head, y+6, m25_head]) rotate([90, 0, 0]) {
            translate([0, wall_thick+cf_offset, 0]) cylinder(99, m25_hole, m25_hole);
        }
    }
    
    // Debug
    //translate([-100, -100, -eps]) cube([114, 109, 999]);
}
