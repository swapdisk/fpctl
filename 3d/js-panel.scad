$fn=360;
eps=0.01;
m2_thrd=1.98/2;
m2_hole=2.60/2;
m25_thrd=2.46/2;
m25_hole=3.06/2;

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
s=0;
dd=8;
tab_thick=1.2;
ft=[[dd, 0, pan_x-dd*2, tab_thick],
    [dd, pan_y-tab_thick, pan_x-dd*2, tab_thick],
    [0, dd, tab_thick, pan_y-dd*2],
    [pan_x-tab_thick, dd, tab_thick, pan_y-dd*2]];
 
// Uncomment one choice only:
//union() {
//projection(cut=true) translate([0, 0, -2.9]) { 
translate([0, 0, -pan_thick-0.7]) {
    color("lightgrey") difference() {
        union() {
            // base panel
            linear_extrude(pan_thick) hull() {
                translate([pan_rad, pan_rad, 0]) circle(pan_rad);
                translate([pan_x-pan_rad, pan_rad, 0]) circle(pan_rad);
                translate([pan_x-pan_rad, pan_y-pan_rad, 0]) circle(pan_rad);
                translate([pan_rad, pan_y-pan_rad, 0]) circle(pan_rad);    
            }
        }
        // subtract face tabs
        for (f=ft) {
            translate([f[0], f[1], -eps]) cube([f[2], f[3], 99]);
        }
        
        // pcb screw holes
        for (h=pcb_screw_holes) {
            translate([h[0], h[1]+bp_y, -eps]) cylinder(pcb_screw_deep, m25_thrd, m25_thrd);
        }
        // corner screw holes
        for (h=corner_screw_holes) {
            translate([h[0], h[1], -eps]) cylinder(pcb_screw_deep, m25_thrd, m25_thrd);
        }
        // Rectangle buttons
        for (i = rectbut_x) {
            translate([i, rectbut_y, -eps]) cube([rectbut_wide, rectbut_high, 99]);
        }
        // button screw holes
        for (h=rectbut_screw_holes) {
            translate([h[0], h[1], -eps]) 
                cylinder(pcb_screw_deep, m2_thrd, m2_thrd);
        }

        // left bezel knockout
        translate([left_x, pan_y/2+js_y_off, pan_thick-bez_thick]) linear_extrude(bez_high) hull() {
            translate([bez_xy/2, bez_xy/2, 0]) circle(bez_rad);
            translate([-bez_xy/2, bez_xy/2, 0]) circle(bez_rad);
            translate([bez_xy/2, -bez_xy/2, 0]) circle(bez_rad);
            translate([-bez_xy/2, -bez_xy/2, 0]) circle(bez_rad);
        }
        translate([left_x-bez_xy/2-0.2, pan_y/2-bez_xy/2+js_y_off-0.2, -eps]) cube([bez_xy+0.4, bez_xy+0.4, 99]); 
        // right bezel knockout
        translate([right_x, pan_y/2+js_y_off, pan_thick-bez_thick]) linear_extrude(bez_high) hull() {
            translate([bez_xy/2, bez_xy/2, 0]) circle(bez_rad);
            translate([-bez_xy/2, bez_xy/2, 0]) circle(bez_rad);
            translate([bez_xy/2, -bez_xy/2, 0]) circle(bez_rad);
            translate([-bez_xy/2, -bez_xy/2, 0]) circle(bez_rad);
        }
        //%translate([right_x-bez_xy/2, pan_y/2-bez_xy/2, -eps]) cube([bez_xy, bez_xy, 99]); 
        translate([right_x-bez_xy/2-0.2, pan_y/2-bez_xy/2+js_y_off-0.2, -eps]) cube([bez_xy+0.4, bez_xy+0.4, 99]);
        
        // Debug
        //translate([-82, -82, -eps]) cube(99);
    }

    // Debug button interface
    color("grey") for (i = rectbut_x) {
        translate([rectbut_wide/2, 0, 0]) {
            translate([i, rectbut_y, -13.5+3.91]) rotate([0, 0, 180]) {
                include <cherry-keycap-fcu1.scad>;
            }
            translate([i, rectbut_y, -19.3-3]) rotate([0, 0, 180]) {
                include <cherry-cherry.scad>;
            }
            translate([i+13/2, rectbut_y+13/2, -25.81-3]) rotate([0, 0, 180]) {
                color("pink") cube([13, 13, 6.5]);
            }
        }
    }

    // Debug key switch plate
    translate([pan_x/2-15, rectbut_y-10, -25.81-3-1.5]) {
        include <js-key-switch-plate.scad>;
    }
    //translate([0, 0, -10]) color("lightblue") {
    //    include <cherry-escutcheon.scad>;
    //}
    //translate([61, 70, -10]) color("red") cube(0.9);

    // Debug bezel align
    //translate([0, 0, 3.4]) cube([17, 15, 0.7]);
    translate([left_x, pan_y/2+js_y_off, -bez_high+4.2]) union() {
        include <js-bezel.scad>;
        color("grey") translate([0, 0, 15]) cylinder(22, 2.2, 2.2);
        color("lightblue") translate([0, 0, 15+22+17.8/2]) sphere(17.8/2);
    }
    translate([right_x, pan_y/2+js_y_off, -bez_high+4.2]) union() {
        include <js-bezel.scad>;
        color("grey") translate([0, 0, 15]) cylinder(22, 2.2, 2.2);
        color("lightgreen") translate([0, 0, 15+22+17.8/2]) sphere(17.8/2);

    }

    // Debug face
    translate([0, 0, 3.4]) rotate([0, 180, 90]) {
        include <js-panel-face.scad>;
    }

    // Debug board position and studs
    translate([bp_x, bp_y, bp_z]) {
        include <js-board.scad>;
    }

    // Debug corners
    //translate([right_x, pan_y-5.75, 0]) color("red") cube(5.75);
    //translate([0, 0, 0]) color("red") cube(9.5);
}

// Debug other panels
// Moved to main-mockup.scad
