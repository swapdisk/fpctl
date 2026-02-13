$fn=360;
eps=0.01;

// Cover dims
cov_thick=0.50;

// Gear panel
gp_high=72.00;
gp_wide=41.62;
gp_thick=3;

// Deco mounting corners
dmc_xy=8.62;
sm_rad=2;
lg_rad=2.15;

gp_corners=[[0, dmc_xy, sm_rad],
            [dmc_xy, 0, sm_rad],
            [gp_wide-sm_rad*2-dmc_xy, 0, sm_rad],
            [gp_wide-sm_rad*2, dmc_xy, sm_rad],
            [gp_wide-sm_rad*2, gp_high-sm_rad*2-dmc_xy, sm_rad],
            [gp_wide-sm_rad*2-dmc_xy, gp_high-sm_rad*2, sm_rad],
            [dmc_xy, gp_high-sm_rad*2, sm_rad],
            [0, gp_high-sm_rad*2-dmc_xy, sm_rad]];

// Gear slot
gs_rad=2;
gs_corners=[[9.33, 19.82, gs_rad],
            [13.41, 19.82, gs_rad],
            [13.41, 45.17, gs_rad],
            [9.33, 45.17, gs_rad]];

// Label
lab_thick=0.20;
lab_rad=1;
lab_mar=3;
lab_corners=[[25, 8, lab_rad],
            [32, 8, lab_rad],
            [32, 56, lab_rad],
            [25, 56, lab_rad]];

// Face tabs
s=1.10;
tab_thick=1.0;
ft=[[dmc_xy+sm_rad+s/2, 0, gp_wide-sm_rad*2-dmc_xy*2-s, tab_thick],
    [dmc_xy+sm_rad+s/2, gp_high-tab_thick, gp_wide-sm_rad*2-dmc_xy*2-s, tab_thick],
    [0, dmc_xy+sm_rad+s/2, tab_thick, gp_high-sm_rad*2-dmc_xy*2-s],
    [gp_wide-tab_thick, dmc_xy+sm_rad+s/2, tab_thick, gp_high-sm_rad*2-dmc_xy*2-s],
];

// subtractable radius
module sr(deg) {
    rotate([0, 0, deg]) linear_extrude(99) {
        difference() {
            square([sm_rad, sm_rad]);
            intersection() {
                square([sm_rad, sm_rad]);
                translate([sm_rad, sm_rad, 0]) circle(sm_rad);
            }
        }
    }
}

// Cover rotated to mirror
rotate([0, 180, 90]) difference() {
    union() {
        // main panel
        linear_extrude(cov_thick) hull() {
            for (c = gp_corners) {
                translate([c[0]+c[2], c[1]+c[2], 0]) circle(c[2]);
            }
        }
        // face tabs
        for (f=ft) {
            translate([f[0], f[1], -gp_thick+0.1]) cube([f[2], f[3], gp_thick]);
        }
    }
    
    // subtract deco mounting corners
    translate([dmc_xy, 0, -eps]) sr(0);
    translate([0, dmc_xy, -eps]) sr(0);
    translate([0, 0, -eps]) linear_extrude(99) hull() {
        translate([dmc_xy-lg_rad, dmc_xy-lg_rad, 0]) circle(lg_rad);
        translate([0, dmc_xy-lg_rad, 0]) circle(lg_rad);
        translate([dmc_xy-lg_rad, 0, 0]) circle(lg_rad);
    }
    translate([gp_wide-dmc_xy, gp_high, -eps]) sr(180);
    translate([gp_wide, gp_high-dmc_xy, -eps]) sr(180);
    translate([0, 0, -eps]) linear_extrude(99) hull() {
        translate([gp_wide-dmc_xy+lg_rad, gp_high-dmc_xy+lg_rad, 0]) circle(lg_rad);
        translate([gp_wide, gp_high-dmc_xy+lg_rad, 0]) circle(lg_rad);
        translate([gp_wide-dmc_xy+lg_rad, gp_high, 0]) circle(lg_rad);
    }
    
    // subtract slot
    translate([0, 0, -eps]) linear_extrude(99) hull() {
        for (c = gs_corners) {
            translate([c[0]+c[2], c[1]+c[2], 0]) circle(c[2]);
        }
    }

    // subtract label
    translate([0, 0, -eps]) linear_extrude(99) hull() {
        for (c = lab_corners) {
            translate([c[0]+c[2], c[1]+c[2], 0]) circle(c[2]);
        }
    }
//    translate([0, 0, lab_thick-99]) linear_extrude(99) hull() {
//        for (i = [0:3]) {
//            c=lab_corners[i];
//            translate([c[0]+c[2]+(i==0||i==3?-lab_mar:lab_mar),
//                       c[1]+c[2]+(i<2?-lab_mar:lab_mar),
//                       0]) circle(eps);
//        }
//    }
//    %translate([0, 0, -eps]) linear_extrude(5) {
//        for (i = [0:3]) {
//            c=lab_corners[i];
//            translate([c[0]+c[2], c[1]+c[2], 0]) text(str(i), size=8, 
//                font="Routed Gothic:style=Regular", halign="center");
//        }
//    }    
}

// Debug
//translate([32, 0, 0]) color("red", 0.5) cube(8.62+1);
