$fn=360;
eps=0.01;

// Panel dims
pan_x=46;
pan_y=78;
pan_thick=3.4;
pan_rad=2;

// Warning buttons
wbut_wide=20.02;
wbut_high=20.02;
wbut_x=pan_x/2-wbut_wide/2;
wbut_y=[13, 44];
wbut_screw_rad=1.98/2;
wbut_screw_holes=[[pan_x/2-16.2, wbut_y[0]-5.5],
                    [pan_x/2-16.2, wbut_y[0]-5.5+25],
                    [pan_x/2-16.2, wbut_y[0]-5.5+50],
                    [pan_x/2+16.2, wbut_y[0]-5.5],
                    [pan_x/2+16.2, wbut_y[0]-5.5+25],
                    [pan_x/2+16.2, wbut_y[0]-5.5+50],
                    ];
echo(wbut_screw_holes);              
pcb_screw_rad=2.46/2;
pcb_screw_deep=2.6;
corner_screw_holes=[[2.75, 2.75],
                    [pan_x-2.75, 2.75],
                    [pan_x/2, 2.75],
                    [2.75, pan_y/2],
                    [pan_x-2.75, pan_y/2],
                    [2.75, pan_y-2.75],
                    [pan_x/2, pan_y-2.75],
                    [pan_x-2.75, pan_y-2.75]];
echo(corner_screw_holes);

// Escutcheon dims
esc_high=3.80;
esc_thick=1.80;
esc_x=70.5;
esc_y=15.35;
felt_mar=1.40;

difference() {
    union() {
        // base panel
        linear_extrude(pan_thick) hull() {
            translate([pan_rad, pan_rad, 0]) circle(pan_rad);
            translate([pan_x-pan_rad, pan_rad, 0]) circle(pan_rad);
            translate([pan_x-pan_rad, pan_y-pan_rad, 0]) circle(pan_rad);
            translate([pan_rad, pan_y-pan_rad, 0]) circle(pan_rad);    
        }
        // base escutcheons
        for (y=wbut_y) {
            translate([wbut_x-esc_thick-felt_mar, y-esc_thick-felt_mar, -esc_high]) 
                cube([wbut_wide+esc_thick*2+felt_mar*2, 
                    wbut_high+esc_thick*2+felt_mar*2,
                    esc_high]);
        }

    }
    // subtract escutcheons inside
    for (y=wbut_y) {
        translate([wbut_x-felt_mar, y-felt_mar, -esc_high-eps])
            cube([wbut_wide+felt_mar*2, wbut_high+felt_mar*2, esc_high+pan_thick-2]);
    }

    // corner screw holes
    for (h=corner_screw_holes) {
        translate([h[0], h[1], -eps]) cylinder(pcb_screw_deep, pcb_screw_rad, pcb_screw_rad);
    }
    // Warning buttons
    for (i = wbut_y) {
        translate([wbut_x, i, -eps]) cube([wbut_wide, wbut_high, 99]);
    }
    // button screw holes
    for (h=wbut_screw_holes) {
        translate([h[0], h[1], -eps])         
        cylinder(pcb_screw_deep, wbut_screw_rad, wbut_screw_rad);
    }

}

// Debug button interface
//for (y=wbut_y) {
//    translate([pan_x/2, 19-16.4+y+0.5, -13.5+3.91]) rotate([0, 0, 180]) {
//        include <cherry-keycap-fcu1.scad>;
//    }
//    translate([pan_x/2, 19-16.4+y+0.5, -19.3-3]) rotate([0, 0, 180]) {
//        include <cherry-cherry.scad>;
//    }
//    translate([pan_x/2+13/2, 19-16.4+y+0.5+13/2, -25.81-3]) rotate([0, 0, 180]) {
//        color("pink") cube([13, 13, 6.5]);
//    }
//}
//echo(pan_x/2+13/2, 19-16.4+44+0.5+13/2);
//
//// Debug key switch plate
//translate([0, 0, -25.81-3-1.5]) {
//    include <warn-key-switch-plate.scad>;
//}
