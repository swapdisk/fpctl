$fn=360;
eps=0.01;
m2_thrd=1.98/2;
m2_hole=2.60/2;
m25_thrd=2.46/2;
m25_hole=3.06/2;

// Cover dims
cov_thick=0.70;

// Panel dims
pan_x=216.0;
pan_y=83.5;
pan_thick=3.4;
pan_rad=2;

// Face tabs
s=1.10;
dd=8;
tab_thick=1.0;
ft=[[dd+s/2, 0, 40-dd-s, tab_thick],
    [60+s/2, 0, 50-s, tab_thick],
    [130+s/2, 0, 30-s, tab_thick],
    [180+s/2, 0, 10-s, tab_thick],
    [dd+s/2, pan_y-tab_thick, pan_x-dd*2-s, tab_thick],
    [0, dd+s/2, tab_thick, pan_y-dd*2-s],
    [pan_x-tab_thick, dd+s/2, tab_thick, pan_y-dd*2-s]];

//// Face tabs
//s=1.10;
//dd=8;
//tab_thick=1.0;
//ft=[[dd+s/2, 0, pan_x-dd*2-s, tab_thick],
//    [dd+s/2, pan_y-tab_thick, pan_x-dd*2-s, tab_thick],
//    [0, dd+s/2, tab_thick, pan_y-dd*2-s],
//    [pan_x-tab_thick, dd+s/2, tab_thick, pan_y-dd*2-s]];

// Small round buttons
smbut_rad=6.04; // 5.04;
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

// Display window
disp_wide=182.00;
disp_high=9.500;
disp_x=(pan_x-disp_wide)/2;
disp_y=68.28-disp_high/2;
  
// Panel screws
ps_xy=[[48.19, 4.26], [175.39, 4.26], [4.26, 79.29], [211.74, 79.29]];

// Labels
lab_thick=0.20;
lab_rad=1;
lab_mar=3;
spdmach_x=smbut_x[0]-1;
spdmach_y=41.51;
spdmach_w=8.74;
spdmach_h=5.92;
metric_x=smbut_x[2]-1;
metric_y=41.51;
metric_w=12.05;
metric_h=5.92;
hdgtrk_x=95.88;
hdgtrk_y=29.82;
hdgtrk_w=6.51;
hdgtrk_h=6.26;
vsfpa_x=118.78;
vsfpa_y=29.82;
vsfpa_w=6.02;
vsfpa_h=6.26;
ptlo_x=204.96;
ptlo_y=39.55;
ptlo_w=10.46;
ptlo_h=12.22;
vsup_x=knob_x[3]-1;
vsup_y=31.23;
vsup_w=4.10;
vsup_h=2.74;
vsdn_x=knob_x[3]-1;;
vsdn_y=57.37; // 58.37;
vsdn_w=4.10;
vsdn_h=2.74;
u100_x=137.76;
u100_y=30.23;
u100_w=5.52;
u100_h=2.74;
u1000_x=150.36;
u1000_y=30.23;
u1000_w=7.68;
u1000_h=2.74;
lab_corners=[
            // spd mach
            [[spdmach_x-spdmach_w/2, spdmach_y, lab_rad],
            [spdmach_x+spdmach_w/2, spdmach_y, lab_rad],
            [spdmach_x+spdmach_w/2, spdmach_y+spdmach_h, lab_rad],
            [spdmach_x-spdmach_w/2, spdmach_y+spdmach_h, lab_rad]],
            // metric alt
            [[metric_x-metric_w/2, metric_y, lab_rad],
            [metric_x+metric_w/2, metric_y, lab_rad],
            [metric_x+metric_w/2, metric_y+metric_h, lab_rad],
            [metric_x-metric_w/2, metric_y+metric_h, lab_rad]],
            // hdg trk
            [[hdgtrk_x-hdgtrk_w/2, hdgtrk_y, lab_rad],
            [hdgtrk_x+hdgtrk_w/2, hdgtrk_y, lab_rad],
            [hdgtrk_x+hdgtrk_w/2, hdgtrk_y+hdgtrk_h, lab_rad],
            [hdgtrk_x-hdgtrk_w/2, hdgtrk_y+hdgtrk_h, lab_rad]],
            // v/s fpa
            [[vsfpa_x-vsfpa_w/2, vsfpa_y, lab_rad],
            [vsfpa_x+vsfpa_w/2, vsfpa_y, lab_rad],
            [vsfpa_x+vsfpa_w/2, vsfpa_y+vsfpa_h, lab_rad],
            [vsfpa_x-vsfpa_w/2, vsfpa_y+vsfpa_h, lab_rad]],
            // push to level off
            [[ptlo_x-ptlo_w/2, ptlo_y, lab_rad],
            [ptlo_x+ptlo_w/2, ptlo_y, lab_rad],
            [ptlo_x+ptlo_w/2, ptlo_y+ptlo_h, lab_rad],
            [ptlo_x-ptlo_w/2, ptlo_y+ptlo_h, lab_rad]],
            // v/s up
            [[vsup_x-vsup_w/2, vsup_y, lab_rad],
            [vsup_x+vsup_w/2, vsup_y, lab_rad],
            [vsup_x+vsup_w/2, vsup_y+vsup_h, lab_rad],
            [vsup_x-vsup_w/2, vsup_y+vsup_h, lab_rad]],
            // v/s dn
            [[vsdn_x-vsdn_w/2, vsdn_y, lab_rad],
            [vsdn_x+vsdn_w/2, vsdn_y, lab_rad],
            [vsdn_x+vsdn_w/2, vsdn_y+vsdn_h, lab_rad],
            [vsdn_x-vsdn_w/2, vsdn_y+vsdn_h, lab_rad]],
            // hdg trk
            [[u100_x-u100_w/2, u100_y, lab_rad],
            [u100_x+u100_w/2, u100_y, lab_rad],
            [u100_x+u100_w/2, u100_y+u100_h, lab_rad],
            [u100_x-u100_w/2, u100_y+u100_h, lab_rad]],
            // hdg trk
            [[u1000_x-u1000_w/2, u1000_y, lab_rad],
            [u1000_x+u1000_w/2, u1000_y, lab_rad],
            [u1000_x+u1000_w/2, u1000_y+u1000_h, lab_rad],
            [u1000_x-u1000_w/2, u1000_y+u1000_h, lab_rad]],
            ];


//rotate([0, 180, 90]) translate([53.75+3, 10, -10]) cylinder(10, .1, .1);
//echo(53.75+3);
//projection(cut=true) translate([0, 0, -0.5]) rotate([0, 180, 90])

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

    // vs knob arrows
    translate([knob_x[3]-24.54/2, knob_y-24.54/2, -eps]) {
        linear_extrude(99) offset(0.2) import("fcu-p1-vs-arrows.svg");
    }
    // visual divs
    translate([87.32, 11.50, -eps]) {
        linear_extrude(99) offset(0.2) hull() {
            circle(0.4);
            translate([0, 39.50, 0]) circle(0.4);
        }
    }
    translate([129.52, 11.50, -eps]) {
        linear_extrude(99) offset(0.2) hull() {
            circle(0.4);
            translate([0, 39.50, 0]) circle(0.4);
        }
    }
    
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

    // Small round buttons
    for (i=smbut_x) {
        translate([i, smbut_y, -eps])
            cylinder(pan_thick+1, smbut_rad, smbut_rad);
    }
    // Knobs
    for (i=knob_x) {
        translate([i, knob_y, -eps]) 
            cylinder(pan_thick+1, knob_rad, knob_rad);
    }
    // Rectangle buttons
    for (i=rectbut_x) {
        echo(i);
        translate([i, rectbut_y, -eps]) 
            cube([rectbut_wide, rectbut_high, pan_thick+1]);
    }
    // Square buttons
    for (i=sqbut_xy) {
        translate([i[0], i[1], -eps]) 
            cube([sqbut_wide, sqbut_high, pan_thick+1]);
    }
    
    // Panel screws
    for (i=ps_xy) {
        translate([i[0], i[1], -eps]) 
            cylinder(pan_thick+1, 5.1/2, 5.1/2);
    }

    // Display window
    translate([disp_x, disp_y, -eps]) 
        cube([disp_wide, disp_high, pan_thick+1]);
    
    // Debug
//    translate([-43, -eps, -9]) cube([216, 88, 10]);
//    translate([1, -70, -9]) cube([216, 88, 10]);
//    translate([140, 55, -9]) cube([216, 88, 10]);
//    translate([202, -eps, -9]) cube([216, 88, 10]);
}
