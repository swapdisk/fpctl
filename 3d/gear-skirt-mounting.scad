$fn=360;
eps=0.01;
m2_thrd=1.98/2;
m2_hole=2.60/2;
m25_thrd=2.46/2;
m25_hole=3.06/2;

// Gear panel
gp_high=72.00;
gp_wide=41.62;

// Deco mounting corners
dmc_xy=8.62;
sm_rad=2;
lg_rad=2.15;
dmc_hole_rad=2.86/2;

gp_corners=[[0, dmc_xy, sm_rad],
            [dmc_xy, 0, sm_rad],
            [gp_wide-sm_rad*2-dmc_xy, 0, sm_rad],
            [gp_wide-sm_rad*2, dmc_xy, sm_rad],
            [gp_wide-sm_rad*2, gp_high-sm_rad*2-dmc_xy, sm_rad],
            [gp_wide-sm_rad*2-dmc_xy, gp_high-sm_rad*2, sm_rad],
            [dmc_xy, gp_high-sm_rad*2, sm_rad],
            [0, gp_high-sm_rad*2-dmc_xy, sm_rad]];

difference() {
    // base
    cube([gp_wide+6, gp_high+6, 3]);
    // control carve out
    translate([3, 3, 2.0]) linear_extrude(99) offset(1.2) hull() {
        for (c = gp_corners) {
            translate([c[0]+c[2], c[1]+c[2], 0]) circle(c[2]);
        }
    }
    // control opening
    translate([7, 13, -eps]) cube([gp_wide-8, gp_high-20, 99]);
    // screws to control
    translate([9.48, 9.48, -eps]) cylinder(99, m25_thrd, m25_thrd);
    translate([gp_wide+6-9.48, gp_high+6-9.48, -eps]) cylinder(99, m25_thrd, m25_thrd);
    // screws to skirt
    translate([3.5, 3.5, -eps]) cylinder(99, m2_hole, m2_hole);
    translate([gp_wide+6-3.5, 3.5, -eps]) cylinder(99, m2_hole, m2_hole);
    translate([gp_wide+6-3.5, gp_high+6-3.5, -eps]) cylinder(99, m2_hole, m2_hole);
    translate([3.5, gp_high+6-3.5, -eps]) cylinder(99, m2_hole, m2_hole);

    // Debug
    //translate([gp_wide/2+3, gp_high/2+3, -eps]) cube(99);

}

