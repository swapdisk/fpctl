$fn=360;
eps=0.01;

// Gear panel
gp_high=72.00;
gp_wide=41.62;
gp_thick=3;
gp_base=1.2;

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

// Gear slot
slot_rad=2;
gs_corners=[[9.33, 19.82, slot_rad],
            [13.41, 19.82, slot_rad],
            [13.41, 45.17, slot_rad],
            [9.33, 45.17, slot_rad]];

// Label
lab_thick=0.20;
lab_rad=1;
lab_mar=3;
lab_corners=[[25, 8, lab_rad],
            [32, 8, lab_rad],
            [32, 56, lab_rad],
            [25, 56, lab_rad]];
            
// Attachment
screw_x=24.41;
screw_y=25;
screw_rad=2.46/2;
screw_deep=gp_thick-0.5;
el_thick=3;
el_holes_rad=3.20/2;

// Face tabs
tab_thick=1.2;
ft=[[dmc_xy+sm_rad, 0, gp_wide-sm_rad*2-dmc_xy*2, tab_thick],
    [dmc_xy+sm_rad, gp_high-tab_thick, gp_wide-sm_rad*2-dmc_xy*2, tab_thick],
    [0, dmc_xy+sm_rad, tab_thick, gp_high-sm_rad*2-dmc_xy*2],
    [gp_wide-tab_thick, dmc_xy+sm_rad, tab_thick, gp_high-sm_rad*2-dmc_xy*2],
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

translate([0, 0, -3.5]) {
    difference() {
        // main panel
        linear_extrude(gp_thick) hull() {
            for (c = gp_corners) {
                translate([c[0]+c[2], c[1]+c[2], 0]) circle(c[2]);
            }
        }

        // subtract face tabs
        for (f=ft) {
            translate([f[0], f[1], -eps]) cube([f[2], f[3], 99]);
        }
        
        // subtract deco mounting corners
        // bottom left
        translate([dmc_xy, 0, gp_base]) sr(0);
        translate([0, dmc_xy, gp_base]) sr(0);
        translate([0, 0, gp_base]) linear_extrude(99) hull() {
            translate([dmc_xy-lg_rad, dmc_xy-lg_rad, 0]) circle(lg_rad);
            translate([0, dmc_xy-lg_rad, 0]) circle(lg_rad);
            translate([dmc_xy-lg_rad, 0, 0]) circle(lg_rad);
        }
        // top right
        translate([gp_wide-dmc_xy, gp_high, gp_base]) sr(180);
        translate([gp_wide, gp_high-dmc_xy, gp_base]) sr(180);
        translate([0, 0, gp_base]) linear_extrude(99) hull() {
            translate([gp_wide-dmc_xy+lg_rad, gp_high-dmc_xy+lg_rad, 0]) circle(lg_rad);
            translate([gp_wide, gp_high-dmc_xy+lg_rad, 0]) circle(lg_rad);
            translate([gp_wide-dmc_xy+lg_rad, gp_high, 0]) circle(lg_rad);
        }

        // subtract deco mounting holes
        translate([dmc_xy-lg_rad, dmc_xy-lg_rad, -eps]) cylinder(99, dmc_hole_rad, dmc_hole_rad);
        translate([gp_wide-dmc_xy+lg_rad, gp_high-dmc_xy+lg_rad, -eps]) cylinder(99, dmc_hole_rad, dmc_hole_rad);
        
        // subtract slot
        translate([0, 0, -eps]) linear_extrude(99) hull() {
            for (c = gs_corners) {
                translate([c[0]+c[2], c[1]+c[2], 0]) circle(c[2]);
            }
        }

        // subtract label
        translate([0, 0, gp_thick-lab_thick]) linear_extrude(99) hull() {
            for (i = [0:3]) {
                c=lab_corners[i];
                translate([c[0]+c[2]+(i==0||i==3?-lab_mar:lab_mar),
                           c[1]+c[2]+(i<2?-lab_mar:lab_mar),
                           0]) circle(eps);
            }
        }
        // screw holes
        for (y = [screw_y, gp_high-screw_y]) {
            translate([screw_x, y, -eps]) cylinder(screw_deep, screw_rad, screw_rad);
        }
    }

    // Debug
    //translate([32, 0, 0]) color("red", 0.5) cube(8.62+1);

//    // Mockup includes
//    translate([0, 0, 0]) {
//        include<gear-control-lower.scad>;
//    }
//    rotate([0, 180, 90]) translate([0, 0, -gp_thick]) {
//        import("gear-control-panel-face.stl");
//    }
}