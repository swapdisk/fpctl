// DO NOT USE
// See gear-control-lower.scad, gear-control-panel.scad, etc.

//$fn=360;
//eps=0.01;
//
//// Gear panel
//gp_high=72.00;
//gp_wide=41.62;
//gp_thick=3;
//gp_base=1.2;
//
//// Deco mounting corners
//dmc_xy=8.62;
//sm_rad=1;
//lg_rad=2.15;
//dmc_hole_rad=2.86/2;
//
//gp_corners=[[0, dmc_xy, sm_rad],
//            [dmc_xy, 0, sm_rad],
//            [32.26, 0, sm_rad],
//            [39.62, 7.36, sm_rad],
//            [39.62, 70-dmc_xy, sm_rad],
//            [39.62-dmc_xy, 70.00, sm_rad],
//            [7.36, 70.00, sm_rad],
//            [0, 62.64, sm_rad]];
//
//// Gear slot
//gs_corners=[[8.83, 19.82, sm_rad],
//            [15.41, 19.82, sm_rad],
//            [15.41, 48.17, sm_rad],
//            [8.83, 48.17, sm_rad]];
//
//// Attachment
//screw_x=24.41;
//screw_y=25;
//screw_rad=2.46/2;
//screw_deep=gp_thick-0.5;
//el_thick=3;
//el_holes_rad=3.20/2;
//
//// pot mount dims
//el_x=18.41;
//el_y=18.82;
//el_high=32.35;
//el_wide=9;
//ex_tall=22;
//ex_rad=11.5;
//pot_rad=7.20/2;
//pot_reg_wide=2.5;
//pot_reg_offset=pot_rad+3.30;
//
//// subtractable radius
//module sr(deg) {
//    rotate([0, 0, deg]) linear_extrude(99) {
//        difference() {
//            square([sm_rad, sm_rad]);
//            intersection() {
//                square([sm_rad, sm_rad]);
//                translate([sm_rad, sm_rad, 0]) circle(sm_rad);
//            }
//        }
//    }
//}
//
//difference() {
//    // pot mount el
//    union() {
//        translate([el_x, el_y, -el_thick]) cube([el_wide, el_high, el_thick]);
//        translate([el_x, el_y+el_high/2, -ex_tall]) 
//        rotate([0, 90, 0]) linear_extrude(el_thick) hull() {
//            translate([-ex_tall, el_high/2, 0]) circle(eps);
//            translate([-ex_tall, -el_high/2, 0]) circle(eps);
//            circle(ex_rad);
//        }
//    }
//    // screw holes
//    for (y = [screw_y, gp_high-screw_y]) {
//        translate([screw_x, y, -99+eps]) cylinder(99, el_holes_rad, el_holes_rad);
//    }
//    // stop pegs
//    translate([0, 24.66, -12]) rotate([0, 90, 0]) cylinder(99, screw_rad, screw_rad);
//    translate([0, 45.33, -12]) rotate([0, 90, 0]) cylinder(99, screw_rad, screw_rad);
//    // potentiometer knockout and reg slot and not subtract thickness
//    rotate([0, 90, 0]) translate([ex_tall, el_y+el_high/2, 0]) {
//        cylinder(99, pot_rad, pot_rad);
//        rotate([0, 0, 45]) rotate_extrude(angle=60) translate([pot_reg_offset, 0, 0])
//            square([pot_reg_wide, 99]);
//    }
//}
//
//difference() {
//    // main panel
//    linear_extrude(gp_thick) hull() {
//        for (c = gp_corners) {
//            translate([c[0]+c[2], c[1]+c[2], 0]) circle(c[2]);
//        }
//    }
//
//    // subtract deco mounting corners
//    translate([dmc_xy, 0, gp_base]) sr(0);
//    translate([0, dmc_xy, gp_base]) sr(0);
//    translate([0, 0, gp_base]) linear_extrude(99) hull() {
//        translate([dmc_xy-lg_rad, dmc_xy-lg_rad, 0]) circle(lg_rad);
//        translate([0, dmc_xy-lg_rad, 0]) circle(lg_rad);
//        translate([dmc_xy-lg_rad, 0, 0]) circle(lg_rad);
//    }
//    translate([gp_wide-dmc_xy, gp_high, gp_base]) sr(180);
//    translate([gp_wide, gp_high-dmc_xy, gp_base]) sr(180);
//    translate([0, 0, gp_base]) linear_extrude(99) hull() {
//        translate([gp_wide-dmc_xy+lg_rad, gp_high-dmc_xy+lg_rad, 0]) circle(lg_rad);
//        translate([gp_wide, gp_high-dmc_xy+lg_rad, 0]) circle(lg_rad);
//        translate([gp_wide-dmc_xy+lg_rad, gp_high, 0]) circle(lg_rad);
//    }
//
//    // subtract deco mounting holes
//    translate([dmc_xy-lg_rad, dmc_xy-lg_rad, -eps]) cylinder(99, dmc_hole_rad, dmc_hole_rad);
//    translate([gp_wide-dmc_xy+lg_rad, gp_high-dmc_xy+lg_rad, -eps]) cylinder(99, dmc_hole_rad, dmc_hole_rad);
//    
//    // subtract slot
//    translate([0, 0, -eps]) linear_extrude(99) hull() {
//        for (c = gs_corners) {
//            translate([c[0]+c[2], c[1]+c[2], 0]) circle(c[2]);
//        }
//    }
//    
//    // screw holes
//    for (y = [screw_y, gp_high-screw_y]) {
//        translate([screw_x, y, -eps]) cylinder(screw_deep, screw_rad, screw_rad);
//    }
//}
//
//// Debug
////translate([32, 0, 0]) color("red", 0.5) cube(8.62+1);
//
//// Debug
//translate([13, el_y+el_high/2, -ex_tall]) rotate([-18, 0, 0]) translate([0, 0, 19.38]) {
//    include <gear-knob-pot-base.scad>;
//}
//
//// Debug
////translate([-42, 30, -22]) rotate([0, 0, 90]) translate([0, 0, 19.38]) {
////    include <flaps-control-mockup.scad>;
////}
