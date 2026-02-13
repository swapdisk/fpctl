$fn=360;
eps=0.01;

// Cover dims
cov_thick=0.70;

// Label
lab_thick=0.20;
lab_rad=1;
lab_mar=3;
lab_corners=[
            [[9.40, 18.25, lab_rad],
                [9.40+35.20, 18.25, lab_rad],
                [9.40+35.20, 18.25+4.00, lab_rad],
                [9.40, 18.25+4.00, lab_rad]],
            [[89.56, 18.25, lab_rad],
                [89.56+35.20, 18.25, lab_rad],
                [89.56+35.20, 18.25+4.00, lab_rad],
                [89.56, 18.25+4.00, lab_rad]],
            [[53.75, 31.40, lab_rad],
                [53.75+4.00, 31.40, lab_rad],
                [53.75+4.00, 31.40+35.20, lab_rad],
                [53.75, 31.40+35.20, lab_rad]],
            [[68.90, 31.40, lab_rad],
                [68.90+11.51, 31.40, lab_rad],
                [68.90+11.51, 31.40+35.20, lab_rad],
                [68.90, 31.40+35.20, lab_rad]]
            ];

// Panel dims
pan_x=136.4;
pan_y=78;
pan_thick=3.4;
pan_rad=2;
js_y_off=-11.00;
dome_thick=1.0;
dome_rad=18.885+0.5+dome_thick;
dome_y=3.00;
left_x=28;
right_x=left_x+80.16;

// Bezel dims
bez_xy=37.00;
bez_rad=7.20/2;
bez_high=13.00;
bez_thick=1.70;
bez_cone=24.00;

// Rectangle buttons
rectbut_wide=12.59;
rectbut_high=8.75;
rectbut_x=[pan_x/2-rectbut_wide/2, right_x-rectbut_wide/2];
rectbut_y=63.4;
rectbut_screw_rad=1.98/2;
echo(pan_x/2-12, right_x+12, (pan_x/2+right_x)/2);
rectbut_screw_holes=[[pan_x/2-12, rectbut_y-0.5],
                     [pan_x/2-12, rectbut_y+9],
                     [(pan_x/2+right_x)/2, rectbut_y-0.5],
                     [(pan_x/2+right_x)/2, rectbut_y+9],
                     [right_x+12, rectbut_y-0.5],
                     [right_x+12, rectbut_y+9]];

// Board position
bp_x=left_x-17.275;
bp_y=pan_y/2-21.325+js_y_off;
bp_z=-18.82;

// Screw holes
pcb_screw_rad=2.46/2;
pcb_screw_deep=2.6;
pcb_screw_holes=[[3.75, 4.08],
                 [3.75, 41.22],
                 [136.4-3.75, 4.08],
                 [136.4-3.75, 41.22]];
corner_screw_holes=[[2.75, 2.75],
                    [pan_x-2.75, 2.75],
                    [2.75, pan_y-2.75],
                    [pan_x-2.75, pan_y-2.75]];

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
    
//    // pcb screw holes
//    for (h=pcb_screw_holes) {
//        translate([h[0], h[1]+bp_y, -eps]) cylinder(pcb_screw_deep, pcb_screw_rad, pcb_screw_rad);
//    }
//    // corner screw holes
//    for (h=corner_screw_holes) {
//        translate([h[0], h[1], -eps]) cylinder(pcb_screw_deep, pcb_screw_rad, pcb_screw_rad);
//    }
    // Rectangle buttons
    for (i = rectbut_x) {
        translate([i, rectbut_y, -eps]) cube([rectbut_wide, rectbut_high, 99]);
    }
//    // button screw holes
//    for (h=rectbut_screw_holes) {
//        translate([h[0], h[1], -eps]) 
//            cylinder(pcb_screw_deep, rectbut_screw_rad, rectbut_screw_rad);
//    }

    // left bezel knockout
    translate([left_x, pan_y/2+js_y_off, -1]) linear_extrude(bez_high) hull() {
        translate([bez_xy/2, bez_xy/2, 0]) circle(bez_rad);
        translate([-bez_xy/2, bez_xy/2, 0]) circle(bez_rad);
        translate([bez_xy/2, -bez_xy/2, 0]) circle(bez_rad);
        translate([-bez_xy/2, -bez_xy/2, 0]) circle(bez_rad);
    }
//    translate([left_x-bez_xy/2-0.2, pan_y/2-bez_xy/2+js_y_off-0.2, -eps]) cube([bez_xy+0.4, bez_xy+0.4, 99]); 
    // right bezel knockout
    translate([right_x, pan_y/2+js_y_off, -1]) linear_extrude(99) hull() {
        translate([bez_xy/2, bez_xy/2, 0]) circle(bez_rad);
        translate([-bez_xy/2, bez_xy/2, 0]) circle(bez_rad);
        translate([bez_xy/2, -bez_xy/2, 0]) circle(bez_rad);
        translate([-bez_xy/2, -bez_xy/2, 0]) circle(bez_rad);
    }
    //%translate([right_x-bez_xy/2, pan_y/2-bez_xy/2, -eps]) cube([bez_xy, bez_xy, 99]); 
//    translate([right_x-bez_xy/2-0.2, pan_y/2-bez_xy/2+js_y_off-0.2, -eps]) cube([bez_xy+0.4, bez_xy+0.4, 99]);
    
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