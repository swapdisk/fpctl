$fn=360;
eps=0.01;
m2_thrd=1.98/2;
m2_hole=2.60/2;
m25_thrd=2.46/2;
m25_hole=3.06/2;

//    translate([216+sp, 0, -3.4]) difference() {
//        cube([tw-216-sp, 83.5+30, 3.4]);
//        translate([10, 19, -eps]) cube([tw-216-20, 88-14, 99]);
//    }

// Panel dims
pan_x=63.5;
pan_y=113.5;
pan_thick=3.4;
pan_rad=2;

// Gear panel
gp_high=72.00;
gp_wide=41.62;
gp_thick=3;
gp_base=1.2;
gp_plusy=7;

// Deco mounting corners
dmc_xy=8.62;
sm_rad=2;
lg_rad=2.15;
dmc_hole_rad=2.86/2;

gp_corners=[[0, dmc_xy, sm_rad],
            [dmc_xy, 0, sm_rad],
            [gp_wide-sm_rad*2-dmc_xy, 0, sm_rad],
            [gp_wide-sm_rad*2, dmc_xy, sm_rad],
            [gp_wide-sm_rad*2, gp_high-sm_rad*2-dmc_xy, sm_rad],
            [gp_wide-sm_rad*2-dmc_xy, gp_high-sm_rad*2, sm_rad],
            [dmc_xy, gp_high-sm_rad*2, sm_rad],
            [0, gp_high-sm_rad*2-dmc_xy, sm_rad]];

corner_screw_holes=[[3.75, 3.75],
                    [pan_x-3.75, 3.75],
                    [10, 3.75],
                    [pan_x-10, 3.75],
                    [3.75, 10],
                    [3.75, pan_y/2],
                    [3.75, pan_y-10],
                    [pan_x-3.75, 10],
                    [pan_x-3.75, pan_y/2],
                    [pan_x-3.75, pan_y-10],
                    [3.75, pan_y-3.75],
                    [pan_x-3.75, pan_y-3.75],
                    [10, pan_y-3.75],
                    [pan_x-10, pan_y-3.75]];
echo(10-7, pan_y-10-7, pan_y/2-7);
mount_screw_holes=[[11.44, 21.25], [52.06, 21.25], [11.44, 92.25], [52.06, 92.25]];
                                
difference() {
    union() {
        // base panel
        linear_extrude(pan_thick) hull() {
            translate([pan_rad, pan_rad, 0]) circle(pan_rad);
            translate([pan_x-pan_rad, pan_rad, 0]) circle(pan_rad);
            translate([pan_x-pan_rad, pan_y-pan_rad, 0]) circle(pan_rad);
            translate([pan_rad, pan_y-pan_rad, 0]) circle(pan_rad);    
        }
    }
    // corner screw holes
    for (h=corner_screw_holes) {
        translate([h[0], h[1], -eps]) cylinder(pan_thick-0.5, m25_thrd, m25_thrd);
        echo("x", h[0]+216+1.5, pan_thick-0.5);
    }
    
    // mount screw holes
    for (h=mount_screw_holes) {
        translate([h[0], h[1]+gp_plusy, -eps]) cylinder(pan_thick-0.5, m2_thrd, m2_thrd);
    }
    // hole for gear control
    translate([pan_x/2-gp_wide/2, pan_y/2-gp_high/2+gp_plusy, -eps]) linear_extrude(99) offset(1.2) hull() {
        for (c = gp_corners) {
            translate([c[0]+c[2], c[1]+c[2], 0]) circle(c[2]);
        }
    }
    // bevel for hole above
    for (n=[1:10]) {
        translate([pan_x/2-gp_wide/2, pan_y/2-gp_high/2+gp_plusy, pan_thick-1.1+n*0.1]) linear_extrude(99) 
                offset(1.2+n*0.1) hull() {
            for (c = gp_corners) {
                translate([c[0]+c[2], c[1]+c[2], 0]) circle(c[2]);
            }
        }
    }

    //translate([10, 19, -eps]) cube([20, 88-14, 99]);
    
    // mark
    translate([2, pan_y-2, 0]) cylinder(0.2, 0.5, 0.5);
    
    // Debug
    //translate([pan_x/2, pan_y/2, -eps]) cube(99);
}

// Debug joiner
//color("grey") translate([-9, 7, -3]) {
//    include<joiner-fcu-gear.scad>;
//}

// Debug other panels
//sp=1.5;
//translate([-216-sp, 0, 0]) {
//    // FCU take 2
//    translate([0, 30, -0.7]) { 
//        include<fcu-p1.scad>;
//        rotate([0, 180, 90]) translate([0, 0, -3.4]) {
//            include<fcu-p1-face.scad>;
//        }
//        //import("fcu-mockup-0.stl");
//    }
//
//    // Filler below fcu
//    //translate([0, 0, -3.4]) cube([216, 30-sp, 3.4]);
//    include<fcu-p3.scad>;
//    
//    // joiner
//    color("lightgrey") translate([7, 21, -3]) {
//        include<joiner-fcu-p1-p3.scad>;
//    }
//}

// Debug mounting plate
//color("pink") translate([pan_x/2-gp_wide/2-3, pan_y/2-gp_high/2-3+gp_plusy, -3]) {
//    include<gear-skirt-mounting.scad>;
//}
// Debug gear control
//translate([pan_x/2-gp_wide/2, pan_y/2-gp_high/2+gp_plusy, 2.5]) {
//    import("gear-control-panel-mockup-0.stl");
//}
