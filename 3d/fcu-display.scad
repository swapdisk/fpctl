$fn=180;
eps=0.01;
m2_thrd=1.98/2;
m2_hole=2.60/2;
m25_thrd=2.46/2;
m25_hole=3.06/2;

// Screw hole location
disp_screws=[10, 65, 128, 185];
mounting_tab_wide=5.00;

// Panel thickness
disp_thick=2.00;
disp_wide=195;
disp_high=14.5;

// Display module dims
mod_wide=38.60;
mod_high=12.08;
mod_thick=4.02;
mod_space=1.18;
mod_slot=1.20;
pin_hole_x=3.04;
pin_hole_y=11.50;

color("grey") {
    difference() {
        union() {
            // base plate
            cube([disp_wide, disp_high, disp_thick]);
        }
        // pin holes
        for (x = [2.5:mod_wide:disp_wide]) {
            translate([x, disp_high/2-pin_hole_y/2, -eps]) cube([pin_hole_x, pin_hole_y, 99]);
        }
    }

    // Module clips
    for (x = [2:mod_wide:disp_wide]) {
        translate([x-2, 0, disp_thick])
            cube([x < disp_wide ? 4.5 : 2, disp_high/2-pin_hole_y/2, mod_space]);
        translate([x-2, 0, disp_thick+mod_space]) 
            cube([x < disp_wide ? 4.5 : 2, disp_high/2-mod_high/2, mod_slot]);
        translate([x-2, 0, disp_thick+mod_space+mod_slot])
            cube([x < disp_wide ? 4.5 : 2, disp_high/2-pin_hole_y/2-0.1, mod_thick-mod_space-mod_slot]);
        translate([x+2, 0, disp_thick])
            cube([x < disp_wide ? mod_wide-4 : 0, disp_high/2-mod_high/2, mod_space+mod_slot]);
    }
    for (x = [2:mod_wide:disp_wide]) {
        translate([x-2, disp_high/2+pin_hole_y/2, disp_thick])
            cube([x < disp_wide ? 4.5 : 2, disp_high/2-pin_hole_y/2, mod_space]);
        translate([x-2, disp_high/2+mod_high/2, disp_thick+mod_space]) 
            cube([x < disp_wide ? 4.5 : 2, disp_high/2-mod_high/2, mod_slot]);
        translate([x-2, disp_high/2+pin_hole_y/2+0.1, disp_thick+mod_space+mod_slot])
            cube([x < disp_wide ? 4.5 : 2, disp_high/2-pin_hole_y/2-0.1, mod_thick-mod_space-mod_slot]);
        translate([x+2, disp_high/2+mod_high/2, disp_thick])
            cube([x < disp_wide ? mod_wide-4 : 0, disp_high/2-mod_high/2, mod_space+mod_slot]);
    }
    
    // screw mounts
    for (s = disp_screws) {
        translate([s, -4, 0]) difference() {
            union() {
                cylinder(disp_thick, mounting_tab_wide/2, mounting_tab_wide/2);
                translate([-mounting_tab_wide/2, 0, 0])
                    cube([mounting_tab_wide, mounting_tab_wide-1, disp_thick]);
            }
            translate([0, 0, -eps]) cylinder(99, m2_hole, m2_hole);
        }
        translate([s, disp_high+4, 0]) rotate([0, 0, 180]) difference() {
            union() {
                cylinder(disp_thick, mounting_tab_wide/2, mounting_tab_wide/2);
                translate([-mounting_tab_wide/2, 0, 0])
                    cube([mounting_tab_wide, mounting_tab_wide-1, disp_thick]);
            }
            translate([0, 0, -eps]) cylinder(99, m2_hole, m2_hole);
        }
    }
}

    // Debug modules
//    for (x = [2+eps:mod_wide:disp_wide]) {
//    //    translate([x, disp_high/2-mod_high/2, disp_thick+mod_space]) cube([mod_wide-0.2, mod_high, 3]);
//        translate([x, disp_high/2-mod_high/2, disp_thick+mod_space]) {
//            include <oled-128x32-ssd1306.scad>;
//        }
//    }

//for (s = xy_screws) {
//    translate([s[0], s[1], p_thick]) {
//        difference() {
//            cylinder(stud_high, stud_or, stud_or);
//            cylinder(stud_high+0.01, stud_ir, stud_ir);
//        }
//    }
//}
