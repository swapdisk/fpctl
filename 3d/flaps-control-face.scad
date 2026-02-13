$fn=360;
eps=0.01;

// Cover dims
cov_thick=0.50;

// Minifactorize
mf=20;

// Bezel dims
bezel_thick=3;
bezel_corner_rad=3;
bezel_f=1.25;

// Panel dims
panel_thick=3;
panel_margin=6;
panel_f=1.3;
panel_l=7.5;
panel_r=58;

// Flap control dims
arch_rad=80-mf;
total_wide=30;
slot_wide=8;
detent_wide=8;
detent_rad=arch_rad-28;
detent_deep=3;
detent_deg=7;

// Deco mounting corners
dmc_xy=6.10;
dmc_ty=7.00;
sm_rad=2;
lg_rad=dmc_xy/2;
dmc_hole_rad=2.86/2;
gp_base=4.2;
gp_high=arch_rad*panel_f;
gp_wide=panel_l+total_wide+panel_r;

// Potentiometer dims
pot_rad=9.90/2;
pot_reg_wide=2.0;
pot_reg_offset=11.96;

// Label cavity
lc_deep=0.5;
lc_edge=0.8;

// Label
lab_thick=0.20;
lab_rad=1;
lab_mar=3;
lab_corners=[[-36, 45, lab_rad],
            [-36-8.5, 45, lab_rad],
            [-36-8.5, 45+20, lab_rad],
            [-36, 45+20, lab_rad]];

// Attachment
screw_rad=2.46/2;
screw_deep=panel_thick+bezel_thick+2;
el_thick=3;
el_holes_rad=3.20/2;

// Face tabs
s=1.10;
tab_thick=1.0;
ft=[[dmc_xy*2+dmc_ty+sm_rad-gp_high+s/2, 0, gp_high-dmc_xy*2-sm_rad*2-dmc_ty-s, tab_thick],
    [dmc_xy*2+dmc_ty+sm_rad-gp_high+s/2, gp_wide-tab_thick, gp_high-dmc_xy*2-sm_rad*2-dmc_ty-s, tab_thick],
    [dmc_xy-tab_thick, dmc_xy+sm_rad+s/2, tab_thick, gp_wide-sm_rad*2-dmc_xy*2-s],
    [dmc_xy-gp_high, dmc_xy+sm_rad+s/2, tab_thick, gp_wide-sm_rad*2-dmc_xy*2-s]];

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

rotate([0, 180, 90]) translate([0, 0, -arch_rad*0.87+panel_thick+bezel_thick]) difference() {
    union() {
        // face tabs
        translate([arch_rad*panel_f/2-dmc_xy,
                       -total_wide-panel_l, 
                       arch_rad*0.87-cov_thick]) {
            for (f=ft) {
                translate([f[0], f[1], -6+0.1]) cube([f[2], f[3], 6]);
            }
        }
    }
}

//projection(cut=true) translate([0, 0, panel_thick+bezel_thick])
rotate([0, 180, 90]) translate([0, 0, -arch_rad*0.87+panel_thick+bezel_thick]) difference() {
    union() {
        // guide base
        rotate([90, -49, 0]) rotate_extrude(angle=82) 
            translate([0, 0, 0]) square([detent_rad+detent_wide, total_wide]);
        
        // panel 
        translate([-arch_rad*panel_f/2,
                   -total_wide-panel_l, 
                   arch_rad*0.87-panel_thick-bezel_thick])
            linear_extrude(bezel_thick+panel_thick) hull() {
                translate([sm_rad, sm_rad, 0]) circle(sm_rad);
                translate([arch_rad*panel_f-sm_rad, sm_rad, 0]) circle(sm_rad);
                translate([arch_rad*panel_f-sm_rad, panel_l+total_wide+panel_r-sm_rad, 0])
                    circle(sm_rad);
                translate([sm_rad, panel_l+total_wide+panel_r-sm_rad, 0]) circle(sm_rad);    
        }
    }

    // Cover only
    translate([-49, -49, arch_rad*0.87-99-cov_thick]) cube([99, 99*2, 99]);
    
    // main control body
    rotate([90, -55, 0]) rotate_extrude(angle=70) square([arch_rad, total_wide]);

    
    // subtract face tabs
//    translate([arch_rad*panel_f/2-dmc_xy,
//                   -total_wide-panel_l, 
//                   arch_rad*0.87-panel_thick-bezel_thick]) {
//        for (f=ft) {
//            translate([f[0], f[1], -eps]) cube([f[2], f[3], 99]);
//        }
//    }

    // subtract deco mounting corners
    // bottom left
    translate([arch_rad*panel_f/2-dmc_xy,
                   -total_wide-panel_l, 
                   arch_rad*0.87-panel_thick-bezel_thick]) {
                   //%cylinder(99, .1, .1);
        translate([0, 0, gp_base]) sr(90);
        translate([dmc_xy, dmc_xy, gp_base]) sr(90);
        translate([0, 0, gp_base]) linear_extrude(9) hull() {
            translate([dmc_xy, dmc_xy-lg_rad, 0]) circle(lg_rad);
            translate([lg_rad, dmc_xy-lg_rad, 0]) circle(lg_rad);
            translate([lg_rad, 0, 0]) circle(lg_rad);
            translate([dmc_xy, 0, 0]) circle(lg_rad);
        }
        translate([dmc_xy-lg_rad, dmc_xy-lg_rad, -eps])
            cylinder(99, dmc_hole_rad, dmc_hole_rad);
    }
    // bottom right
    translate([arch_rad*panel_f/2-dmc_xy,
                   -total_wide-panel_l, 
                   arch_rad*0.87-panel_thick-bezel_thick]) {
        translate([0, panel_l+total_wide+panel_r, gp_base]) sr(180);
        translate([dmc_xy, panel_l+total_wide+panel_r-dmc_xy, gp_base]) sr(180);
        translate([0, panel_l+total_wide+panel_r-dmc_xy/2, gp_base]) linear_extrude(9) hull() {
            translate([dmc_xy, dmc_xy-lg_rad, 0]) circle(lg_rad);
            translate([lg_rad, dmc_xy-lg_rad, 0]) circle(lg_rad);
            translate([lg_rad, 0, 0]) circle(lg_rad);
            translate([dmc_xy, 0, 0]) circle(lg_rad);
        }
        translate([dmc_xy-lg_rad, panel_l+total_wide+panel_r-lg_rad, -eps]) 
            cylinder(99, dmc_hole_rad, dmc_hole_rad);
    }
    // top left
    translate([dmc_ty-arch_rad*panel_f/2,
                   -total_wide-panel_l, 
                   arch_rad*0.87-panel_thick-bezel_thick]) {
        translate([0, 0, gp_base]) sr(90);
        translate([dmc_xy, 0, gp_base]) sr(0);
        translate([0, 0, gp_base]) linear_extrude(9) hull() {
            translate([lg_rad, dmc_xy-lg_rad, 0]) circle(lg_rad);
            translate([lg_rad, 0, 0]) circle(lg_rad);
        }
        translate([lg_rad, dmc_xy-lg_rad, -eps]) 
            cylinder(99, dmc_hole_rad, dmc_hole_rad);
    }
    // top right
    translate([dmc_ty-arch_rad*panel_f/2,
                   -total_wide-panel_l, 
                   arch_rad*0.87-panel_thick-bezel_thick]) {
        translate([0, panel_l+total_wide+panel_r, gp_base]) sr(180);
        translate([dmc_xy, panel_l+total_wide+panel_r, gp_base]) sr(270);
        translate([0, panel_l+total_wide+panel_r-dmc_xy/2, gp_base]) linear_extrude(9) hull() {
            translate([lg_rad, dmc_xy-lg_rad, 0]) circle(lg_rad);
            translate([lg_rad, 0, 0]) circle(lg_rad);
        }
        translate([lg_rad, panel_l+total_wide+panel_r-lg_rad, -eps]) 
            cylinder(99, dmc_hole_rad, dmc_hole_rad);
    }

    translate([0, -total_wide/2+slot_wide/2, 0]) {
        // lever slot
        rotate([90, -60.5, 0]) rotate_extrude(angle=59) square([999, slot_wide]);
        // round ends of slot
        translate([0, -slot_wide/2, 0])
            rotate([-29.5, 0, 90]) cylinder(999, slot_wide/2, slot_wide/2);
        translate([0, -slot_wide/2, 0])
            rotate([29.5, 0, 90]) cylinder(999, slot_wide/2, slot_wide/2);
        // subtract left side
        translate([-arch_rad*panel_f/2, -total_wide+1, -999])
            cube([arch_rad*panel_f, total_wide, 999+arch_rad*0.87-panel_thick-bezel_thick]);
        // subtract right side
        translate([-arch_rad*panel_f/2, 3.5-3+slot_wide/2, -999])
            cube([arch_rad*panel_f, total_wide, 
                999+arch_rad*0.87-panel_thick-bezel_thick-el_thick]);
    }
    // el holes
    for (x = [-arch_rad*bezel_f/3, 0, arch_rad*bezel_f/3]) {
        translate([x, -4.4-3+slot_wide/2, arch_rad*0.87-panel_thick-bezel_thick-el_thick-eps]) 
            cylinder(el_thick+eps+eps, el_holes_rad, el_holes_rad);
    }
    // screw holes
    for (x = [-arch_rad*bezel_f/3, 0, arch_rad*bezel_f/3]) {
        translate([x, -4.4-3+slot_wide/2, arch_rad*0.87-panel_thick-bezel_thick-eps]) 
            cylinder(screw_deep-0.9, screw_rad, screw_rad);
        translate([x, 4.4+3-slot_wide/2-total_wide, arch_rad*0.87-panel_thick-bezel_thick-eps]) 
            cylinder(screw_deep-0.9, screw_rad, screw_rad);
    }

    // label cavities
    rotate([90, -61, 0]) rotate_extrude(angle=58) 
        translate([arch_rad-lc_deep, lc_edge, 0])
            square([999, total_wide/2-slot_wide/2-lc_edge*2]);
    rotate([90, -61, 0]) rotate_extrude(angle=58) 
        translate([arch_rad-lc_deep, lc_edge+total_wide/2+slot_wide/2, 0])
            square([999, total_wide/2-slot_wide/2-lc_edge*2]);

    // subtract label
    translate([arch_rad*panel_f/2,
                   -total_wide-panel_l, 
                   0]) linear_extrude(99) hull() {
        for (i = [0:3]) {
            c=lab_corners[i];
            translate([c[0]+c[2],
                       c[1]+c[2],
                       0]) circle(lab_rad);
        }
    }

    // potentiometer knockout and reg slot and not subtract thickness
    rotate([90, 0, 0]) cylinder(total_wide, pot_rad, pot_rad);
    rotate([90, -73, 0]) rotate_extrude(angle=34) translate([pot_reg_offset, 0, 0])
        square([pot_reg_wide, total_wide]);
//    translate([0, -total_wide/2+slot_wide/2+2.5, 0]) rotate([-90, 0, 0]) 
//        cylinder(999, arch_rad+detent_wide-26, arch_rad+detent_wide-26);
        
    // detent slot
    rotate([90, -62, 0]) rotate_extrude(angle=56) translate([detent_rad, 0, 0])
        square([detent_wide, total_wide]);
        
    // detents
    for (d = [4:13:56]) {
        rotate([90, -60-d+detent_deg/2, 0]) rotate_extrude(angle=detent_deg)
            translate([detent_rad-detent_deep, 0, 0])
                square([detent_wide+detent_deep, total_wide]);
    }
}

echo (gp_high);
