$fn=180;
eps=0.01;
m2_thrd=1.98/2;
m2_hole=2.60/2;
m25_thrd=2.46/2;
m25_hole=3.06/2;

// Subpanel thick
p2_thick=2.50;

// Cherry switch knockout and thick
cko=14.00;
ckt=1.50;

// Small round buttons
smbut_x=[11.29, 108.43, 167.20];
smbut_y=49.56;

// Encoders
enc_rad=4.65;
enc_x=[33.02, 67.54, 145.63, 188.28];
enc_y=36.84;
enc_reg_rad=1.65;
enc_reg_off=9.00;

// Rectangle buttons
rectbut_wide=12.59;
rectbut_high=8.75;
rectbut_ttsc=8.31+0.50;
rectbut_x=[61.25, 139.34, 181.99];
rectbut_y=10.22;

// Square buttons
sqbut_wide=12.59;
sqbut_high=12.59;
sqbut_ttsc=8.85+0.50;
sqbut_xy=[[93.94, 27.02], [110.34, 27.02], [102.14, 10.59]];

// Hinge dims
hinge_thick=10.00/2;
hinge_pin=2.84/2;

// Screw hole locations
xy_screws=[[200, 5],
           [201.7, 57],
           [167, 5],
           [167, 36],
           [131, 57],
           [121, 5],
           [82, 57],
           [50, 57],
           [54, 5],
           [17, 36],
           [5, 13.5],
           [5, 69]];
// Encoder flippy locations
x_flippies=[17.47, 60.12, 138.20, 172.72];

//color("red") translate([14.3, 26, 1.5]) {
//    include <pushpull-fit.scad>;
//}

difference () {
    union() {
        // Import switch knockout plate from Inkscape
//        color("grey") translate([216-11, 0, 5.5]) rotate([0, 180, 0]) 
//            linear_extrude(0.5) import("fcu-p2.svg");
        // Base plate
        translate([0, 10, 0]) cube([13, 64, p2_thick]);
        translate([0, 10, 0]) cube([205, 53, p2_thick]);
        translate([49, 0, 0]) cube([156, 63, p2_thick]);
        // Hinge body
        translate([0, 63, hinge_thick/2]) rotate([0, 90, 0]) 
            cylinder(205, hinge_thick/2, hinge_thick/2);             
        // strength support
        translate([49, 0, 0]) cube([156, 1, 6]);
        translate([49, 0, 0]) cube([1, 17, 6]);
        translate([0, 17, 0]) cube([95, 1, 6]);
        translate([125, 17, 0]) cube([80, 1, 6]);
        translate([77, 39.6, 0]) cube([59, 1, 6]);
        translate([205, 0, 0]) cube([1, 66, 6]);
        translate([43.28, 28, 0]) cube([1, 38, 6]);
        translate([155.88, 28, 0]) cube([1, 38, 6]);
        translate([205, 0, 0]) cube([1, 66, 6]);
        translate([0, 17, 0]) cube([1, 57, 6]);
        translate([0, 62.5, 0]) cube([205, 1, 6]);
        
    }

    // Small round buttons
    for (i=smbut_x) {
        translate([i-cko/2, smbut_y-cko/2, -eps]) {
            cube([cko, cko, p2_thick+1]);
            translate([-1, -1, ckt]) cube([cko+2, cko+2, p2_thick+1]);
        }
    }

    // Encoders
    for (i=enc_x) {
        translate([i, enc_y, -eps]) {
            cylinder(p2_thick+1, enc_rad, enc_rad);
            translate([0, enc_reg_off, 0]) cylinder(p2_thick+1, enc_reg_rad, enc_reg_rad);
        }
    }
        
    // Rectangle buttons
    for (i=rectbut_x) {
        translate([i+rectbut_wide/2-cko/2, rectbut_y+rectbut_high/2-rectbut_ttsc/2-cko/2, -eps]) {
            cube([cko, cko, p2_thick+1]);
            translate([-1, -1, ckt]) cube([cko+2, cko+2, p2_thick+5]);
        }
    }

    // Square buttons
    for (i=sqbut_xy) {
        translate([i[0]+sqbut_wide/2-cko/2, i[1]+sqbut_high/2-sqbut_ttsc/2-cko/2+1.70, -eps]) {
            cube([cko, cko, p2_thick+1]);
            translate([-1.3, -1.3, ckt]) cube([cko+2.6, cko+2.6, p2_thick+1]);
        }
    }
    
    // Debug hide big piece
//    translate([0, -eps, -eps]) cube([999, 22.2, 9]);
//    translate([0, -eps, -eps]) cube([x_flippies[0]+eps, 99, 9]);
//    translate([x_flippies[0]+20.2, -eps, -eps]) cube([x_flippies[1]-x_flippies[0]-20, 99, 9]);
//    translate([x_flippies[1]+20.2, -eps, -eps]) cube([x_flippies[2]-x_flippies[1]-20, 99, 9]);
//    translate([x_flippies[2]+20.2, -eps, -eps]) cube([x_flippies[3]-x_flippies[2]-20, 99, 9]);
//    translate([x_flippies[3]+20.2, -eps, -eps]) cube([99, 99, 9]);
    // Debug hide all but one
//    translate([0, -eps, -eps]) cube([999, 21, 9]);
//    translate([0, -eps, -eps]) cube([160, 99, 9]);
//    translate([-x_flippies[0]+216-11-9.5+20.2, -eps, -eps]) cube([x_flippies[1]-x_flippies[0]-20, 99, 9]);
//    translate([-x_flippies[1]+216-11-9.5+20.2, -eps, -eps]) cube([x_flippies[2]-x_flippies[1]-55.5, 99, 9]);

    // Hinge pin
    translate([-eps, 63, hinge_thick/2]) rotate([0, 90, 0])
        cylinder(999, hinge_pin, hinge_pin);
    
    // Mounting screw holes
    for (h = xy_screws) {
        translate([h[0], h[1], -49]) cylinder(99, m2_hole, m2_hole);
    }
    
    // Encoder flippies
    for (x = x_flippies) {
        translate([216-11-9.5-x, 20, -eps]) {
            cube([1.5, 40.5, 9]);
            cube([0.2, 99, 9]);
            cube([20.5, 1.5, 9]);
            // translate([20.5/2, 9.68, 0]) cube([20.5/2, 2, 9]);
            translate([19, 0, 0]) cube([1.5, 40.5, 9]);
            translate([20.3, 0, 0]) cube([0.2, 99, 9]);
            // Debug hide entire flippies
            //cube([20.3+eps, 99, 9]);

            translate([-3.2, 4, 0]) cylinder(99, m25_hole, m25_hole);
            translate([23.7, 4, 0]) cylinder(99, m25_hole, m25_hole);
        }
    }
}