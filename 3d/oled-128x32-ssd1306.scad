$fn=360;
eps=0.01;

// base board
color("skyblue") cube([38.00, 12.00, 1.20]);
// display
color("darkgrey") translate([5.00, 0.25, 1.20]) cube([30.00, 11.50, 1.80]);
// active area
color("cyan") translate([7.10, 3.99, 3.00]) cube([22.38, 5.58, 0.05]);
//pix=0.174;
//color("cyan") translate([7.10, 3.99, 3.00+eps]) for (x=[0:127]) {
//    for (y=[0:31]) {
//        translate([x*pix*1.005, y*pix, 0]) cube([pix-0.03, pix-0.03, eps]);
//    }
//}  
// pins
color("silver") translate([1.50, 2.19-0.32, -8.00]) {
    for (y=[0:3]) {
        translate([0, y*2.54, 0]) cube([0.64, 0.64, 11.00]);
    }
}