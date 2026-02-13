$fn=360;
eps=0.01;
m2_thrd=1.98/2;
m2_hole=2.60/2;
m25_thrd=2.46/2;
m25_hole=3.06/2;

// Panel dims
pan_x=216.0;
pan_y=83.5;
pan_thick=3.4;
pan_rad=2;

// Face tabs
s=0;
dd=8;
tab_thick=1.2;
ft=[[dd, 0, 40-dd, tab_thick],
    [60, 0, 50, tab_thick],
    [130, 0, 30, tab_thick],
    [180, 0, 10, tab_thick],
    [dd, pan_y-tab_thick, pan_x-dd*2, tab_thick],
    [0, dd, tab_thick, pan_y-dd*2],
    [pan_x-tab_thick, dd, tab_thick, pan_y-dd*2]];

// Small round buttons
smbut_rad=5.04;
smbut_x=[11.29, 108.43, 167.20];
smbut_y=49.56;

// Knobs
knob_rad=9.81;
knob_x=[33.02, 67.54, 145.63, 188.28];
knob_y=36.84;
uc_rad=23.20/2;

// Rectangle buttons
rectbut_wide=12.69;
rectbut_high=8.75;
rectbut_x=[61.25, 139.34, 181.99];
rectbut_y=10.22;

// Square buttons
sqbut_wide=12.59;
sqbut_high=12.59;
sqbut_xy=[[93.94, 27.02], [110.34, 27.02], [102.14, 10.59]];

// Escutcheon dims
esc_high=3.80;
esc_thick=1.20;
felt_mar=1.40;

// Display window
disp_wide=182.00;
disp_high=9.500;
disp_x=(pan_x-disp_wide)/2;
disp_y=68.28-disp_high/2;
  
// Panel screws
ps_xy=[[48.19, 4.26], [175.39, 4.26], [4.26, 79.29], [211.74, 79.29]];
    
// Display lens area dims
d_cav_thick=pan_thick-0.90;
d_cav_wide=disp_wide+16;
d_cav_high=disp_high+6.6;
d_cav_x=disp_x-8;
d_cav_y=disp_y-4;
d_lens_thick=0.60;
d_lens_wide=disp_wide+5;
d_lens_high=disp_high+5; //16.06;
d_lens_x=disp_x-2.5;
d_lens_y=disp_y-2.5;

// Display screws
disp_screws=[10, 65, 128, 185];
          
// Display stud dims
d_stud_or=5.00/2;
d_stud_high=4.32-d_cav_thick;
d_x=10.5;
d_y=74.71;

corner_screw_holes=[[3.75, 3.75],
                    [pan_x-3.75, 3.75],
                    [10, 3.75],
                    [pan_x-10, 3.75],
                    [115, 3.75],
                    [10, pan_y-3.75],
                    [pan_x-10, pan_y-3.75],
                    [115, pan_y-3.75],
                    [3.75, pan_y/2],
                    [pan_x-3.75, pan_y/2]];

// projection(cut=true) translate([0, 0, -2.9]) 
union() { // translate([0, 0, -pan_thick-0.7]) {
    difference() {
        union() {
            // base panel
            linear_extrude(pan_thick) hull() {
                translate([pan_rad, pan_rad, 0]) circle(pan_rad);
                translate([pan_x-pan_rad, pan_rad, 0]) circle(pan_rad);
                translate([pan_x-pan_rad, pan_y-pan_rad, 0]) circle(pan_rad);
                translate([pan_rad, pan_y-pan_rad, 0]) circle(pan_rad);    
            }
            // Display studs
            for (s = disp_screws) {
                translate([d_x+s, d_y+4, -d_stud_high])
                    cylinder(d_stud_high, d_stud_or, d_stud_or);
                translate([d_x+s, d_y-18.5, -d_stud_high])
                    cylinder(d_stud_high, d_stud_or, d_stud_or);
            }
            // Base escutcheons
            for (i=rectbut_x) {
                translate([i-esc_thick-felt_mar, rectbut_y-esc_thick-felt_mar, -esc_high]) 
                    cube([rectbut_wide+esc_thick*2+felt_mar*2, 
                        rectbut_high+esc_thick*2+felt_mar*2,
                        esc_high]);
            }
            for (i=sqbut_xy) {
                translate([i[0]-esc_thick-felt_mar, i[1]-esc_thick-felt_mar, -esc_high]) 
                    cube([sqbut_wide+esc_thick*2+felt_mar*2, 
                        sqbut_high+esc_thick*2+felt_mar*2,
                        esc_high]);
            }
            for (i=smbut_x) {
                translate([i, smbut_y, -esc_high])
                    cylinder(esc_high, smbut_rad+esc_thick+felt_mar, smbut_rad+esc_thick+felt_mar);
            // strength support at top
            translate([d_cav_x-1, d_cav_y+d_cav_high, -5]) cube([pan_x-d_cav_x*2+2, 3, 5]);
        }

        }
        // subtract face tabs
        for (f=ft) {
            translate([f[0], f[1], -eps]) cube([f[2], f[3], 99]);
        }

        // corner screw holes
        for (h=corner_screw_holes) {
            translate([h[0], h[1], -eps]) cylinder(pan_thick-0.5, m25_thrd, m25_thrd);
            translate([h[0], h[1], -10]) cylinder(10, 3, 3);
        }

        // Small round buttons
        for (i=smbut_x) {
            translate([i, smbut_y, -eps])
                cylinder(pan_thick+1, smbut_rad, smbut_rad);
            translate([i, smbut_y, -esc_high-eps])
                cylinder(esc_high+pan_thick-2, smbut_rad+felt_mar, smbut_rad+felt_mar);
        }
        // subtract hack for alt units control
        translate([smbut_x[2]-9, smbut_y-5, -esc_high-eps]) cube([3, 10, esc_high+eps]);
        // Knobs
        for (i=knob_x) {
            translate([i, knob_y, -eps]) 
                cylinder(pan_thick+1, knob_rad, knob_rad);
        }
        // Alt units control screws
        translate([knob_x[2], knob_y, -eps]) {
            translate([uc_rad, uc_rad, 0]) cylinder(pan_thick-0.5, m2_thrd, m2_thrd);
            translate([uc_rad, -uc_rad, 0]) cylinder(pan_thick-0.5, m2_thrd, m2_thrd);
            translate([-uc_rad, -uc_rad, 0]) cylinder(pan_thick-0.5, m2_thrd, m2_thrd);
            translate([-uc_rad, uc_rad, 0]) cylinder(pan_thick-0.5, m2_thrd, m2_thrd);
            // room for switch screw
            translate([-20.1, -4.3, -eps]) cube([8, 12.9, 2]);
        }
        // Rectangle buttons
        for (i=rectbut_x) {
            echo(i);
            translate([i, rectbut_y, -eps]) 
                cube([rectbut_wide, rectbut_high, pan_thick+1]);
            translate([i-felt_mar, rectbut_y-felt_mar, -esc_high-eps])
                cube([rectbut_wide+felt_mar*2, rectbut_high+felt_mar*2, esc_high+pan_thick-2]);
        }
        // Square buttons
        for (i=sqbut_xy) {
            translate([i[0], i[1], -eps]) 
                cube([sqbut_wide, sqbut_high, pan_thick+1]);
             translate([i[0]-felt_mar, i[1]-felt_mar, -esc_high-eps])
                cube([sqbut_wide+felt_mar*2, sqbut_high+felt_mar*2, esc_high+pan_thick-2]);
        }
        
        // Panel screws
        for (i=ps_xy) {
            translate([i[0], i[1], -eps]) 
                cylinder(pan_thick+1, m2_hole, m2_hole);
        }

        // Display window
        translate([disp_x, disp_y, -eps]) 
            cube([disp_wide, disp_high, pan_thick+1]);

        // Display area cavity
        translate([d_cav_x, d_cav_y, -eps])
            cube([d_cav_wide, d_cav_high, d_cav_thick]);
        // Display lens
        translate([d_lens_x, d_lens_y, d_cav_thick-eps*2])
            cube([d_lens_wide, d_lens_high, d_lens_thick]);
        // Display stud screw holes
        for (s=disp_screws) {
//            translate([d_x+s, d_y+4, -d_stud_high-eps])
//                cylinder(d_stud_high+pan_thick-0.5, m2_thrd, m2_thrd);
            translate([d_x+s, d_y+4, -d_stud_high-eps])
                cylinder(3, m2_thrd, m2_thrd);
            translate([d_x+s-2.8, d_y, -d_stud_high-9])
                cube([5.6, 9, 9]); // supoport carve out
            translate([d_x+s, d_y-18.5, -d_stud_high-eps])
                cylinder(d_stud_high+pan_thick-0.5, m2_thrd, m2_thrd);
        }
            
        // Debug
//        translate([-eps, -eps, -eps]) cube([52, 99, 99]);
//        translate([195, -eps, -eps]) cube([52, 99, 99]);
    }

    // P2 screw hole location
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

    // P2 stud dims
    p2_stud_or=5.00/2;
    p2_stud_high=21;  // 13+6.5+1.5;

    // P2 studs
    for (s = xy_screws) {
        translate([s[0], s[1], -p2_stud_high]) {
            difference() {
                cylinder(p2_stud_high, p2_stud_or, p2_stud_or);
                translate([0, 0, -eps]) cylinder(8, m2_thrd, m2_thrd);
            }
        }
    }

    // Debug button interface
    //    rectbut_wide=12.59;
    //    rectbut_high=8.75;
    //    //rectbut_x=[pan_x/2-rectbut_wide/2, right_x-rectbut_wide/2];
    //    rectbut_y=11.68;
    //    rectbut_screw_rad=1.98/2;
    //    rectbut_x=[-154.75];
//    mocksq=13.9;
//    rectbut_ttsc=8.31+0.50;
//    for (i = rectbut_x) {
//        rotate([0, 0, 0]) translate([rectbut_wide/2, 0, -4.7+3.28+0.7]) {
//            translate([i, rectbut_y, -13.5+3.91]) rotate([0, 0, 180]) {
//                include <cherry-keycap-fcu1.scad>;
//            }
//            translate([i, rectbut_y, -19.3-3+7.60]) rotate([0, 0, 180]) {
//                include <cherry-cherry-short.scad>;
//            }
//            translate([i+mocksq/2, rectbut_y+mocksq/2, -25.81-3+7.60]) rotate([0, 0, 180]) {
//                color("grey") cube([mocksq, mocksq, 6.5]);
//            }
//        }
//    }
//    sqbut_ttsc=8.85+0.50;
//    for (i = sqbut_xy) {
//        rotate([0, 0, 0]) translate([sqbut_wide/2, sqbut_ttsc-sqbut_high/2+.25, -4.7+3.28+0.7]) {
//            translate([i[0], i[1], -13.5+3.91]) rotate([0, 0, 180]) {
//                include <cherry-keycap-fcu0.scad>;
//            }
//            translate([i[0], i[1], -19.3-3+7.60]) rotate([0, 0, 180]) {
//                include <cherry-cherry-short.scad>;
//            }
//            translate([i[0]+mocksq/2, i[1]+mocksq/2, -25.81-3+7.60]) rotate([0, 0, 180]) {
//                color("grey") cube([mocksq, mocksq, 6.5]);
//            }
//        }
//    }
    
    // Debug subpanel
//    color("grey") translate([0, 0, -p2_stud_high-2.5]) { 
//        include <fcu-p2.scad>;
//    }
    // Debug display panel
//    translate([d_x, d_y-18.5+4, -d_stud_high-2.0]) {
//        include <fcu-display.scad>;
//    }
//    // Debug alt units control
//    translate([145.63, 36.84, 4.1]) {
//        include<alt-units-proto.scad>;
//    }
    // Debug alt knob
//    translate([145.63, 36.84, -p2_stud_high+6.0]) rotate([180, 0, 0]) {
//        include<knob-alt.scad>;
//    }


//// Knobs
//knob_rad=9.81;
//knob_x=[33.02, 67.54, 145.63, 188.28];
//knob_y=36.84;
    
//    // Debug knobs
//    for (x=[27.7, 70.4, 148.4, 182.9]) {
//        translate([x, 38.5, -17]) {
//            include<knob-alt.scad>;
//        }
//    }
}

// Debug align bit
//translate([-eps, -eps, -49]) cube([45, 99, 99]);
//translate([-eps, 64, -49]) cube([999, 99, 99]);
//translate([85, -eps, -49]) cube([999, 99, 99]);

echo(d_stud_high+pan_thick-0.5);
