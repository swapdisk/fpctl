$fn=360;
eps=0.01;

// Cover dims
cov_thick=0.70;

// Label
lab_thick=0.20;
lab_rad=1;
lab_mar=3;
lab_corners=[
            [[34.25, 9.25, lab_rad],
                [34.25+13, 9.25, lab_rad],
                [34.25+13, 9.25+11, lab_rad],
                [34.25, 9.25+11, lab_rad]],
            ];

// Panel dims
pan_x=136.4;
pan_y=31.5;
pan_thick=3.4;
pan_rad=2;

// Wheel location
wl_x=30.713;
wl_y=3.45;
wl_z=-21.50;

// Wheel cylinder
wlc_rad=25/2;
wlc_wide=8.9;
wlc_x=wl_x+26-wlc_wide/2;
wlc_y=pan_y/2;
wlc_z=wl_z+17.04;
echo(wlc_x, wlc_y, 15.95+wo_rad);

// Wheel opening
wo_rad=4.35;
wo_x=wl_x+26-wo_rad+0.3-0.35/2; // 0.037;
wo_y=pan_y/2;
wo_plus_x=4.35;
wo_plus_y=9.06;
wo_corners=[[wo_x+wo_plus_x-wo_rad, wo_y+wo_plus_y-wo_rad],
            [wo_x+wo_plus_x-wo_rad, wo_y-wo_plus_y+wo_rad],
            [wo_x-wo_plus_x+wo_rad, wo_y-wo_plus_y+wo_rad],
            [wo_x-wo_plus_x+wo_rad, wo_y+wo_plus_y-wo_rad]
           ];

// Face tabs
s=1.10;
dd=8;
tab_thick=1.0;
ft=[[dd+s/2, 0, pan_x-dd*2-s, tab_thick],
    [dd+s/2, pan_y-tab_thick, pan_x-dd*2-s, tab_thick],
    [0, dd+s/2, tab_thick, pan_y-dd*2-s],
    [pan_x-tab_thick, dd+s/2, tab_thick, pan_y-dd*2-s]];

//rotate([0, 180, 90]) translate([53.75+3, 10, -10]) cylinder(10, .1, .1);
//echo(53.75+3);

rotate([0, 180, 90]) difference() {
    union() {
        // base panel
        linear_extrude(cov_thick) hull() {
            translate([pan_rad, pan_rad, 0]) circle(pan_rad);
            translate([pan_x-pan_rad, pan_rad, 0]) circle(pan_rad);
            translate([pan_x-pan_rad, pan_y-pan_rad, 0]) circle(pan_rad);
            translate([pan_rad, pan_y-pan_rad, 0]) circle(pan_rad);    
        }
        // face tabs
        for (f=ft) {
            translate([f[0], f[1], -pan_thick+0.1]) cube([f[2], f[3], pan_thick]);
        }
    }

    // Debug wheel opening
//    translate([wlc_x, wlc_y, wlc_z]) rotate([0, 90, 0]) 
//        cylinder(0.4, wlc_rad, wlc_rad);
//    translate([wlc_x+wlc_wide-0.4, wlc_y, wlc_z]) rotate([0, 90, 0]) 
//        cylinder(0.4, wlc_rad, wlc_rad);

    // subtract wheel opening
    translate([0, 0, -eps]) linear_extrude(99) hull() {
        for (c=wo_corners) {
            translate([c[0]+wo_rad, c[1], 0]) scale([1, 1.15, 1]) circle(wo_rad);
        }
    }
    
    // Cover only
//    translate([-49, -49, -99+pan_thick-cov_thick]) cube([99*2, 99*2, 99]);

    // subtract face tabs
//    for (f=ft) {
//        translate([f[0], f[1], -eps]) cube([f[2], f[3], 99]);
//    }
    
    // subtract label window
    for (l=lab_corners) {
        linear_extrude(99) hull() {
            for (i = [0:3]) {
                c=l[i];
                translate([c[0]+c[2],
                           pan_y-c[1]-c[2],
                           0]) circle(lab_rad);
            }
        }
    }
    // subtract label margin
    for (l=lab_corners) {
        translate([0, 0, -99+lab_thick]) linear_extrude(99) hull() {
            for (i = [0:3]) {
                c=l[i];
                translate([c[0]+c[2]+(i==0||i==3?-lab_mar:lab_mar),
                           pan_y-c[1]-c[2]+(i>1?-lab_mar:lab_mar),
                           0]) circle(eps);
            }
        }
    }
        
    // Debug
    //translate([-82, -82, -eps]) cube(99);
}

// Debug button interface
//translate([pan_x/2, 63.4, -13.5+3.91]) rotate([0, 0, 180]) {
//    include <cherry-keycap-fcu1.scad>;
//}
//translate([pan_x/2, 63.4, -19.3-3]) rotate([0, 0, 180]) {
//    include <cherry-cherry.scad>;
//}
//translate([pan_x/2+13/2, 63.4+13/2, -25.81-3]) rotate([0, 0, 180]) {
//    color("pink") cube([13, 13, 6.5]);
//}

// Debug key switch plate
//translate([pan_x/2-15, rectbut_y-10, -25.81-3-1.5]) {
//    include <js-key-switch-plate.scad>;
//}

//// Debug bezel align
//translate([0, 0, 3.4]) cube([17, 15, 0.7]);
//translate([left_x, pan_y/2+js_y_off, -bez_high+4.2]) union() {
//    include <js-bezel.scad>;
//}
//translate([right_x, pan_y/2+js_y_off, -bez_high+4.2]) union() {
//    include <js-bezel.scad>;
//}

// Debug other panels
//translate([pan_x+1, 0, 0]) cube([95.50, 78.00, 3.4]);

// Debug board position and studs
//translate([bp_x, bp_y, bp_z]) {
//    include <js_board.scad>;
//}

// Debug corners
//translate([right_x, pan_y-5.75, 0]) color("red") cube(5.75);
//translate([0, 0, 0]) color("red") cube(9.5);