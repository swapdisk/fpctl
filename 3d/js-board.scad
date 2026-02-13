$fn=360;
eps=0.01;

// Board dims
pcb_x=115.10;
pcb_y=52.50;
pcb_thick=1.62;
pcb_hole_rad=2.64/2;
pcb_holes=[ [3.96, 4.08],
            [3.96, 41.22],
            [110.97, 4.08],
            [110.97, 41.22]];
            
// Joystick control dims
jsc_x=15.75;
jsc_y=15.75;
jsc_z=12.22;
jsc_pos=[ [9.40, 13.45],
          [89.56, 13.45]];
          
// Stick dims
jss_x=1.86;
jss_y=1.18;
jss_z=19.62;

// Dome position
dome_high=10.75;

// Debug show board, etc.
translate([0, 0, -pcb_thick]) difference() {
    union() {
        // base pcb
        color("powderblue") cube([pcb_x, pcb_y, pcb_thick]);
        // Joysticks
        color("silver") for (j=jsc_pos) {
            translate([j[0], j[1], pcb_thick])
                cube([jsc_x, jsc_y, jsc_z]);
            translate([j[0]+jsc_x/2-jss_x/2, j[1]+jsc_y/2-jss_y/2, pcb_thick])
                cube([jss_x, jss_y, jss_z]);
        }
        // Domes
        color("grey") for (j=jsc_pos) {
            translate([j[0]+jsc_x/2, j[1]+jsc_y/2, pcb_thick+dome_high]) {
                include <ex-sphere.scad>;
            }
        }
    }
    for (h=pcb_holes) {
        translate([h[0], h[1], -eps]) cylinder(99, pcb_hole_rad, pcb_hole_rad);
    }
}

// Shorten brackets to go under jointer by this amount
shorter=2.3;

// Bracket poly points
bpp=[[0, shorter],
     [0, 5],
     [5.5, 10.5],
     [5.5, 18.82],
     [17.5-7.5/2, 18.82],
     [17.5-7.5/2, 18.82-2.10],
     [9.58+2.10, 18.82-2.10],
     [7.5, 12.12],
     [7.5, shorter]];
pcb_screw_rad=2.46/2;
pcb_screw_deep=2.7;
pan_hole_rad=3.06/2;
pan_head_rad=4.60/2;
pan_deep=5.5;

//            [3.96, 41.22],
//            [110.97, 4.08],
//            [110.97, 41.22]];
// right bracket
translate([110.97+3.96, 0.21+41.22+3.88, 0]) rotate([0, 0, 180]) difference() {
    translate([-9.75, 0.21, 18.82]) {
        // body
        rotate([90, 180, 180]) linear_extrude(7.5) polygon(bpp);
        translate([0, 41.22-4.08, 0]) rotate([90, 180, 180]) {
            linear_extrude(7.5) polygon(bpp);
        }
        translate([17.5-7.5/2, 7.5/2, -18.82]) rotate([0, 0, 0]) cylinder(2.10, 7.5/2, 7.5/2);
        translate([17.5-7.5/2, 41.22-4.08+7.5/2, -18.82]) rotate([0, 0, 0]) cylinder(2.10, 7.5/2, 7.5/2);
        translate([5.5, 0, -18.82]) cube([2, 41.22, 18.82-8.5]);
    }
    // board screw holes
    for (h=[[3.96, 4.08], [3.96, 41.22]]) {
        translate([h[0], h[1], -eps]) cylinder(pcb_screw_deep, pcb_screw_rad, pcb_screw_rad);
    }
    // panel screw holes
    for (h=[[-7, 4.08], [-7, 41.22]]) {
        translate([h[0], h[1], -eps]) cylinder(99, pan_hole_rad, pan_hole_rad);
        translate([h[0], h[1], -eps]) cylinder(18.82-pan_deep, pan_head_rad, pan_head_rad);
    }
}

// left bracket
difference() {
    translate([-9.75, 0.21, 18.82]) {
        // body
        rotate([90, 180, 180]) linear_extrude(7.5) polygon(bpp);
        translate([0, 41.22-4.08, 0]) rotate([90, 180, 180]) linear_extrude(7.5) polygon(bpp);
        translate([17.5-7.5/2, 7.5/2, -18.82]) rotate([0, 0, 0]) cylinder(2.10, 7.5/2, 7.5/2);
        translate([17.5-7.5/2, 41.22-4.08+7.5/2, -18.82]) rotate([0, 0, 0]) cylinder(2.10, 7.5/2, 7.5/2);
        translate([5.5, 0, -18.82]) cube([2, 41.22, 18.82-8.5]);
    }
    // board screw holes
    for (h=[[3.96, 4.08], [3.96, 41.22]]) {
        translate([h[0], h[1], -eps]) cylinder(pcb_screw_deep, pcb_screw_rad, pcb_screw_rad);
    }
    // panel screw holes
    for (h=[[-7, 4.08], [-7, 41.22]]) {
        translate([h[0], h[1], -eps]) cylinder(99, pan_hole_rad, pan_hole_rad);
        translate([h[0], h[1], -eps]) cylinder(18.82-pan_deep, pan_head_rad, pan_head_rad);
    }
}
